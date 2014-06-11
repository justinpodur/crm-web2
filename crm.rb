require_relative 'contact'
require 'sinatra'
require_relative 'rolodex'

@@rolodex = Rolodex.new

get '/' do
	@crm_app_name = "Hoostin CRM"
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
	erb :edit_contact
end

#View a contact
get '/contacts/:id' do
	erb :view_contact
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
