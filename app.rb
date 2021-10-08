require 'roo-xls'
require 'csv'
require 'sinatra'
require './lib/plan_fact.rb'
require './lib/emails.rb'
require './lib/contacts.rb'

set :bind, '0.0.0.0'
set :port, 8080

get '/' do
  erb :index
end

get '/download_file' do 
  send_file './public/res.csv', :filename => 'res.csv', :type => 'Application/octet-stream'
end

get '/delete_files' do
  FileUtils.rm_rf Dir.glob("./public/*")
  redirect to '/'
end

get '/emails' do 
  erb :emails_form
end

get '/contacts' do 
  erb :contacts_form
end

get '/plan_fact' do 
  erb :plan_fact_form
end

post '/generate_emails' do 
  file = params[:file][:tempfile]
  create_mailing_list(file)
  erb :show_link
end

post '/generate_plan_fact' do
  file = params[:file][:tempfile]
  convert_file(file)
  erb :show_link
end

post '/generate_contacts' do
  file = params[:file][:tempfile]
  create_contacts_list(file)
  erb :show_link
end