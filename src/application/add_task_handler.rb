
class AddTaskHandler
  def initialize(task_repository)

    @task_repository = task_repository
  end

  def execute(task_description)
    task_id = @task_repository.next_id
    task = Task.new task_id, task_description
    @task_repository.store(task)
  end
end