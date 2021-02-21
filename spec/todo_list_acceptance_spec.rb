# todo_list_acceptance_spec.rb
# frozen_string_literal: true

ENV['APP_ENV'] = 'test'

require 'rspec'
require 'rack/test'

require_relative '../src/infrastructure/entry_point/todo_list_app.rb'
require_relative '../src/domain/task_repository'
require_relative '../src/domain/task'

def todo_application
  @task_repository = double(TaskRepository)

  TodoListApp.new @task_repository
end

def build_client
  Rack::Test::Session.new(
    Rack::MockSession.new(
      todo_application
    )
  )
end

RSpec.describe 'As a user I want to' do

  before do
    @client = build_client
  end

  it "add a new task to the list" do

    expect(@task_repository)
      .to receive(:store)
            .with(instance_of(Task))

    @client.post '/api/todo',
                 { task: 'Write a test that fails' },
                 { 'CONTENT_TYPE' => 'application/json' }

    expect(@client.last_response.status).to eq(201)
  end
end
