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
	# @contacts=[]
	# @contacts << Contact.new("Julie", "Hache", "julie@bitmaerlabs.com", "instructor")
	# @contacts << Contact.new("Justin", "Podur", "justin@podu.org", "student")
	# @contacts << Contact.new("Sample", "Guy", "sample@guy.com", "another one")
	# @contacts << Contact.new("Sample2", "Gal", "sample2@gal.com", "yet another")
	erb :contacts
end

# post '/contacts' do
# 	contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
# 	@@rolodex.add_contact[contact]
# end


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
