# todo_list_acceptance_spec.rb
# frozen_string_literal: true

ENV['APP_ENV'] = 'test'

require 'rspec'
require 'rack/test'
require 'json'

require_relative '../src/infrastructure/entry_point/todo_list_app'
require_relative '../src/infrastructure/persistence/memory_storage'
require_relative '../src/application/add_task_handler'
require_relative '../src/application/get_task_list_handler'
require_relative '../src/application/mark_task_completed_handler'
require_relative '../src/domain/task_repository'
require_relative '../src/domain/task'

def todo_application
  @task_repository = TaskRepository.new MemoryStorage.new
  @add_task_handler = AddTaskHandler.new @task_repository
  @get_tasks_list_handler = GetTaskListHandler.new @task_repository
  @mark_task_completed = MarkTaskCompletedHandler.new @task_repository

  TodoListApp.new @add_task_handler, @get_tasks_list_handler, @mark_task_completed
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

def api_post_task(description)
  @client.post '/api/todo',
               { task: description }.to_json,
               { 'CONTENT_TYPE' => 'application/json' }
end

def api_get_tasks
  @client.get '/api/todo'
end

RSpec.describe 'As a user I want to' do

  before do
    @client = build_client
  end

  it "add a new task to the list" do

    api_post_task('Write a test that fails')

    expect(@client.last_response.status).to eq(201)
    expect(@task_repository.next_id).to eq(2)
  end

  it 'get a list with all the tasks I\'ve introduced' do
    api_post_task('Write a test that fails')
    api_post_task('Write Production code that makes the test pass')

    api_get_tasks

    expect(@client.last_response.status).to eq(200)

    expected_list = [
      '[ ] 1. Write a test that fails',
      '[ ] 2. Write Production code that makes the test pass'
    ]

    expect(@client.last_response.body).to eq(expected_list.to_json)
  end

  it 'mark a task completed' do
    api_post_task('Write a test that fails')
    api_post_task('Write Production code that makes the test pass')

    @client.patch '/api/todo/1',
                  { completed: true }.to_json,
                  { 'CONTENT_TYPE' => 'application/json' }

    expect(@client.last_response.status).to eq(200)

    api_get_tasks

    expected_list = [
      '[√] 1. Write a test that fails',
      '[ ] 2. Write Production code that makes the test pass'
    ]

    expect(@client.last_response.body).to eq(expected_list.to_json)
  end
end
