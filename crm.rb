require 'sinatra'
require relative 'contact'

get '/' do
	@crm_app_name = "Hoostin CRM"
	erb :index
end

#View about page
get '/about' do
	"The incredible power of about pages is here demonstrated"
end

#View all contacts
get '/contacts' do
	erb :contacts
end

#Add new contact
get '/contacts/new' do
end

#Edit a contact
get '/contacts/:id/edit' do
end

#View a contact
get '/contacts/:id' do
end

get '/:name' do
	puts params
	name = params[:name].capitalize
	"Hi I'm #{name}!"
end
