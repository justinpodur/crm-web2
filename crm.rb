require_relative 'rolodex'

require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite3:database.sqlite3")

class Contact
	include DataMapper::Resource

	property :id, Serial
	property :first_name, String
	property :last_name, String
	property :email, String
	property :note, String
end

DataMapper.finalize
DataMapper.auto_upgrade!

@@rolodex = Rolodex.new

# Temporary fake data so that we always find contact with id 1000.
#@@rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))


CRM_APP_NAME = "Hoostin CRM"

get '/' do
	erb :index
end

#View all contacts
get '/contacts' do
	@contacts = Contact.all
	erb :contacts
end

post '/contacts' do
	contact = Contact.create(
		:first_name => params[:first_name],
		:last_name => params[:last_name],
		:email => params[:email],
		:note => params[:note]
		)
 	redirect to('/contacts')
end


#Add new contact
get '/contacts/new' do
	erb :new_contact
end

#Edit a contact
get '/contacts/:id/edit' do
	@contact = @@rolodex.find_contact(params[:id].to_i)
	if @contact
		erb :edit_contact
	else
		raise Sinatra::NotFound
	end
end

get "/contacts/:id" do
  @contact = @@rolodex.find_contact(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

put "/contacts/:id" do
	@contact = @@rolodex.find_contact(params[:id].to_i)
	if @contact
		@contact.first_name = params[:first_name]
		@contact.last_name = params[:last_name]
		@contact.email = params[:email]
		@contact.note = params[:note]

		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end

#Delete a contact
delete '/contacts/:id' do
	@contact = @@rolodex.find_contact(params[:id].to_i)
	if @contact
		@@rolodex.delete_contact(@contact.id)

		redirect to ("/contacts")
	else
		raise Sinatra::NotFound
	end
end

get '/:name' do
	puts params
	name = params[:name].capitalize
	"Hi I'm #{name}!"
end

