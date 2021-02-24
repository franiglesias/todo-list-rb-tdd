class MarkTaskCompletedHandler
  def initialize(task_repository)

    @task_repository = task_repository
  end

  def execute(task_id)
    task = @task_repository.retrieve task_id
    task.mark_completed

    @task_repository.store task
  end
end