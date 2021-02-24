require 'rspec'

require_relative '../../src/domain/task'

describe 'Task' do

  it 'should be incomplete on creation' do
    task = Task.new 1, 'Task Description'
    expect(task.completed).to be_falsey
  end

  it 'should be able to be completed' do
    task = Task.new 1, 'Task Description'
    task.mark_completed
    expect(task.completed).to be_truthy
  end
end