require 'dm-core'
require 'dm-migrations'
require 'sinatra/activerecord'

class Student
  include DataMapper::Resource
  property :id, Serial
  property :name, String
  property :dob, String
  property :address, String  
end
DataMapper.finalize
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/test.db")
Student.auto_migrate!

configure do
  enable :sessions
  set :username, 'frank'
  set :password, 'sinatra'
end



get '/students' do
  redirect("/login") unless session[:admin]
  @students = Student.all
  erb :students
end

get '/students/new' do
  redirect("/login") unless session[:admin]
  stud = Student.new
  stud.name = "terry"
  stud.dob = "14/22/1994"
  stud.address = "Santa Bruno"
  stud.save
#   @students = Student.new
#   erb :new_student
    redirect("/students")
end

get '/students/:id' do
  redirect("/login") unless session[:admin]
  @students = Student.get(params[:id])
  erb :show_student
end

get '/students/:id/edit' do
  redirect("/login") unless session[:admin]
  @students = Student.get(params[:id])
  if @students
    puts(@students.name, @students.grade)
  else
    puts("Student not found")
  end
  erb :edit_students
end

post '/students' do  
  redirect("/login") unless session[:admin]
  students = Student.create(params['students'])
  redirect to("/students/#{students.id}")
end

put '/students/:id' do
  redirect("/login") unless session[:admin]
  students = Student.get(params[:id])
  students.update(params['students'])
  redirect to("/students/#{students.id}")
end

delete '/students/:id' do
  redirect("/login") unless session[:admin]
  Student.get(params[:id]).destroy
  redirect to('/students')
end
