# frozen_string_literal: true

require 'sinatra'
#noinspection RubyResolve
require 'sqlite3'

require 'sinatra/base'
#noinspection RubyResolve
require 'sinatra/env_to_config'

class MyApp < Sinatra::Base
  #noinspection RubyResolve
  register Sinatra::EnvToConfig

  #noinspection RubyUnusedLocalVariable
  def self.env_to_config(i, i1)
    # code here
  end

  env_to_config :key1, :key2

end


get '/' do
  erb :home
end

get '/about' do
  erb :about
end

get '/index' do
  erb :index
end

get '/login' do
  erb :login
end

get '/images' do
  erb :index
end

#get '/layout1' do
#erb :layout1
#end


#get '/sent' do
#erb :sent
#end

require 'sinatra'
#noinspection RubyResolve
require 'sqlite3'

# Method connect with database
#noinspection RubyResolve
def get_db
  SQLite3::Database.new 'base.db'
end

# Configure application
configure do
  db = get_db
  db.execute 'CREATE TABLE IF NOT EXISTS "Messages"
    (
      "id" INTEGER PRIMARY KEY AUTOINCREMENT,
      "username" TEXT,
      "phone" TEXT,
      "email" TEXT,
      "option" TEXT,
      "comment" TEXT
    )'
  db.close
end

# Method save form data to database
def save_form_data_to_database
  db = get_db
  db.execute 'INSERT INTO Messages (username, phone, email, option, comment)
  VALUES (?, ?, ?, ?, ?)', [@username, @phone, @email, @option, @comment]
  db.close
end

# Index page with form
get '/index1' do
  @title = 'Форма за заявки на Sinatra (Ruby)'
  erb :index1
end

post '/' do
  @username = params[:username]
  @phone = params[:phone]
  @email = params[:email]
  @option = params[:option]
  @comment = params[:comment]

  save_form_data_to_database

  @title = 'Благодаря, вашето сообщение е изпратено'
  erb :sent
end
