# frozen_string_literal: true

require 'sinatra'
require_relative '../../../src/domain/task'

class TodoListApp < Sinatra::Base

  def initialize(add_task_handler, get_tasks_list_handler, mark_task_completed)
    @add_task_handler = add_task_handler
    @get_tasks_list_handler = get_tasks_list_handler
    @mark_task_completed = mark_task_completed
  end

  post '/api/todo' do
    payload = JSON.parse request.body.read.to_s

    @add_task_handler.execute payload['task']

    [201]
  end

  get '/api/todo' do
    tasks = @get_tasks_list_handler.execute do |task|
      "[#{task.completed ? '√' : ' '}] #{task.id}. #{task.description}"
    end

    [200, tasks.to_json]
  end

  patch '/api/todo/:task_id' do |task_id|
    @mark_task_completed.execute task_id.to_i

    [200]
  end
end