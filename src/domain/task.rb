  class Task
    attr_reader :description, :id
    def initialize(id, description)

      @id = id
      @description = description
    end
  end