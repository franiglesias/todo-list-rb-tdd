class MemoryStorage
  def initialize
    @objects = {}
  end

  def next_id
    @objects.count + 1
  end

  def store(object)
    @objects.store object.id, object
  end

  def find_all
    @objects
  end

  def retrieve(object_id)
    @objects[object_id]
  end
end