class TaskRepository
  def initialize(storage)
    @storage = storage
  end

  def next_id
    @storage.next_id
  end

  def store(task)
    @storage.store task
  end
end