# todo_list_acceptance_spec.rb
# frozen_string_literal: true

ENV['APP_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require 'json'

require_relative '../src/infrastructure/entry_point/todo_list_app'
require_relative '../src/infrastructure/persistence/memory_storage'
require_relative '../src/domain/task_repository'
require_relative '../src/domain/task'

def todo_application
  @task_repository = TaskRepository.new MemoryStorage.new
  @add_task_handler = AddTaskHandler.new @task_repository
  TodoListApp.new @add_task_handler
end

def build_client
  Rack::Test::Session.new(
    Rack::MockSession.new(
      todo_application
    )
  )
end

RSpec::Matchers.define :has_same_data do |expected|
  match do |actual|
    expected.id == actual.id && expected.description == actual.description
  end
end


RSpec.describe 'As a user I want to' do

  before do
    @client = build_client
  end

  it "add a new task to the list" do

    @client.post '/api/todo',
                 { task: 'Write a test that fails' }.to_json,
                 { 'CONTENT_TYPE' => 'application/json' }

    expect(@client.last_response.status).to eq(201)
    expect(@task_repository.next_id).to eq(2)
  end
end
