# frozen_string_literal: true

require 'sinatra'
require_relative '../../domain/task'
require_relative '../../domain/task_repository'

class TodoListApp < Sinatra::Base
  def initialize(task_repository)
    @task_repository = task_repository
  end

  post '/api/todo' do
    task = Task.new
    @task_repository.store(task)
    [201]
  end
end