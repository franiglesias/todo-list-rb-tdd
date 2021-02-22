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

    @task_repository.store Task.new(@task_repository.next_id, 'Task Description')
    @task_repository.store Task.new(@task_repository.next_id, 'Another Task')
    @task_repository.store Task.new(@task_repository.next_id, 'Third Task')

    expect(@task_repository.next_id).to eq(4)
  end
end