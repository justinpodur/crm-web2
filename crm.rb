require 'sinatra'

get '/' do
	@crm_app_name = "Hoostin CRM"
	erb :index
end

get '/about' do
	"The incredible power of about pages is here demonstrated"
end

get '/contacts' do
	erb :contacts
end


get '/:name' do
	puts params
	name = params[:name].capitalize
	"Hi I'm #{name}!"
end
