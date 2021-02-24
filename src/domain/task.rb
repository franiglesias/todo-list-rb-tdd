  class Task
    attr_reader :description, :id, :completed

    def initialize(id, description)

      @id = id
      @description = description
      @completed = false
    end

    def mark_completed
      @completed = true
    end
  end