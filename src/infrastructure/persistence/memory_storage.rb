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
end