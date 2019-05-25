
require 'dm-core'
require 'dm-migrations'
require './main'
require './student'
require 'dm-timestamps'
require 'dm-validations'

#enable :sessions

DataMapper.setup(:default, ENV['DATABASE_URL']|| "sqlite3://#{Dir.pwd}/development.db")
configure do
    enable :sessions
    set :username, "frank"
    set :password, "sinatra"
end


class Comment
  include DataMapper::Resource
  property :cid, Serial
  property :comment, String, :required => true
  property :name, String
  property :created_at, DateTime
  property :updated_at, DateTime
end

DataMapper.finalize
#DataMapper.auto_migrate!
DataMapper.auto_upgrade!


get '/comments' do
  @comments = Comment.all
  redirect("/login") unless session[:admin]
  erb :comments, :layout => :layout2
end

get '/comments/new' do
  comment = Comment.new
  erb :new_comment
end

#Route for the new comment form
get '/comments/new' do
  redirect("/login") unless session[:admin]
  @comment = Comment.new
  erb :new_comment
end

#Shows a single comment
get '/comments/:cid' do
  redirect("/login") unless session[:admin]
  @comment = Comment.get(params[:cid])
  erb :show_comment
end

#Route for the form to edit a single comment
get '/comments/:cid/edit' do
  redirect("/login") unless session[:admin]
  @comment = Comment.get(params[:cid])
  erb :edit_comment
end

#Creates new comment
post '/comments' do
  redirect("/login") unless session[:admin]
  @comment = Comment.create(params[:comment])
  redirect to('/comments')
end

#Edits a single student
put '/comments/:cid' do
  redirect("/login") unless session[:admin]
  @comment = Comment.get(params[:cid])
  @comment.update(params[:comment])
  redirect to("/comments/#{@comment.cid}")
end

#Deletes a single comment
delete '/comments/:cid' do
  redirect("/login") unless session[:admin]
  Comment.get(params[:cid]).destroy
  redirect to('/comments')
end
