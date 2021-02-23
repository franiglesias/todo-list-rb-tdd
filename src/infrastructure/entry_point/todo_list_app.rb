# frozen_string_literal: true

require 'sinatra'

class TodoListApp < Sinatra::Base
  def initialize(add_task_handler, get_tasks_list_handler, task_repository)
    @add_task_handler = add_task_handler
    @get_tasks_list_handler = get_tasks_list_handler
    @task_repository = task_repository
  end

  post '/api/todo' do
    payload = JSON.parse request.body.read.to_s

    @add_task_handler.execute payload['task']

    [201]
  end

  get '/api/todo' do
    tasks = @get_tasks_list_handler.execute do |task|
      "[ ] #{task.id}. #{task.description}"
    end

    [200, tasks.to_json]
  end
end