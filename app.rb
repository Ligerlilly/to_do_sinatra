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

get '/list/:id/tasks/new' do
	@list_id = params.fetch 'id'

	erb :task_form
end

post '/list/:id/tasks' do
	list_id = params.fetch 'list_id'
	@list  = List.find(list_id.to_i)
	description = params.fetch 'task_description'
	due_date = '2015-8-18'
	complete = false
	@task = Task.new({description: description, due_date: due_date, complete: complete, list_id: list_id})
	@task.save
	@tasks = @list.tasks
	erb :list
end
