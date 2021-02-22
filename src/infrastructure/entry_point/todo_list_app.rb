  # frozen_string_literal: true

  require 'sinatra'
  require_relative '../../domain/task'
  require_relative '../../domain/task_repository'
  require_relative '../../application/add_task_handler'

  class TodoListApp < Sinatra::Base
    def initialize(add_task_handler)
      @add_task_handler = add_task_handler
    end

    post '/api/todo' do
      payload = JSON.parse request.body.read.to_s

      @add_task_handler.execute payload['task']

      [201]
    end
  end