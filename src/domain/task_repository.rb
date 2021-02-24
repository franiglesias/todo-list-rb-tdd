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

  def find_all
    @storage.find_all
  end

  def retrieve(task_id)
    @storage.retrieve task_id
  end
end