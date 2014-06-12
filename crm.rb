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
	erb :edit_contact
end

#View a contact
get '/contacts/:id' do
	erb :view_contact
end

get "/contacts/1000" do
  @contact = @@rolodex.find(1000)
  erb :show_contact
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

