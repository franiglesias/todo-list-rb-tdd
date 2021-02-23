class GetTaskListHandler
  def initialize(task_repository)
    @task_repository = task_repository
  end

  def execute
    tasks = @task_repository.find_all
    return tasks unless block_given?

    representations = []
    tasks.each do |key, task|
      representations << yield(task)
    end

    representations
  end
end