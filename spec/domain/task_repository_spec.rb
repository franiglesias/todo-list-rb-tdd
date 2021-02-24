require 'rspec'

require_relative '../../src/domain/task_repository'
require_relative '../../src/domain/task'
require_relative '../../src/infrastructure/persistence/memory_storage'


describe 'TaskRepository' do
  before() do
    memory_storage = MemoryStorage.new
    @task_repository = TaskRepository.new memory_storage
  end

  it 'first identity should be 1' do

    result = @task_repository.next_id

    expect(result).to eq(1)
  end

  it 'should add a Task' do
    task = Task.new 1, 'Task Description'

    @task_repository.store task

    expect(@task_repository.next_id).to eq(2)
  end

  it 'should add several tasks' do

    @task_repository.store Task.new(1, 'Task Description')
    @task_repository.store Task.new(2, 'Another Task')
    @task_repository.store Task.new(3, 'Third Task')

    expect(@task_repository.next_id).to eq(4)
  end

  it 'should find all tasks stored' do
    examples = [
      Task.new(1, 'Task Description'),
      Task.new(2, 'Another Task'),
      Task.new(3, 'Third Task')
    ].each { |task| @task_repository.store task }

    tasks = @task_repository.find_all

    expect(tasks.count).to eq(3)
    expect(tasks[1]).to eq(examples[0])
    expect(tasks[2]).to eq(examples[1])
    expect(tasks[3]).to eq(examples[2])
  end

  it 'should retrieve a task by id' do
    examples = [
      Task.new(1, 'Task Description'),
      Task.new(2, 'Another Task'),
      Task.new(3, 'Third Task')
    ].each { |task| @task_repository.store task }

    task = @task_repository.retrieve 1

    expect(task).to eq(examples[0])
  end
end