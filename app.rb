require 'sinatra'
require './lib/list'
require './lib/task'
require 'pg'
require 'sinatra/reloader'

DB = PG.connect({:dbname => "to_do"})

get '/'  do
	@lists = List.all
	erb(:index)
end


get '/lists/new' do


	erb(:list_form)
end


post '/lists' do
	@message = "Your submission was a Success!"
	name = params.fetch 'list_name'
	@list = List.new({name: name, id: nil})
	@list.save
	@lists   = List.all
	erb :index
end

get 'list/:id/task/new' do
	@list_id = params.fetch 'id'
	erb :task_form
end

post '/list/:id/tasks' do
	@task = Task.new(params)
	@task.save
	erb :list
end
