require_relative 'contact'
require 'sinatra'
require_relative 'rolodex'

@@rolodex = Rolodex.new

# Temporary fake data so that we always find contact with id 1000.
@@rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))


CRM_APP_NAME = "Hoostin CRM"

get '/' do
	erb :index
end

#View all contacts
get '/contacts' do
	erb :contacts
end

post '/contacts' do
 	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
 	@@rolodex.add_contact(new_contact)
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
get '/contacts/:id/delete' do
	erb :delete_contact
end

get '/:name' do
	puts params
	name = params[:name].capitalize
	"Hi I'm #{name}!"
end

