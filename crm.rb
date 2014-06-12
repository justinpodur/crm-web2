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
	@contact = Contact.get(params[:id].to_i)
	if @contact
		erb :edit_contact
	else
		raise Sinatra::NotFound
	end
end

#Show a contact
get "/contacts/:id" do
  @contact = Contact.get(params[:id].to_i)
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

#form for editing contact
put "/contacts/:id" do
	@contact = Contact.get(params[:id].to_i)
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
	@contact = Contact.get(params[:id].to_i)
	if @contact
		@contact.destroy
		redirect to ("/contacts")
	else
		raise Sinatra::NotFound
	end
end

