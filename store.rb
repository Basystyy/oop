module Store
  def find(name)
    all.select { |object| object.name == name }
  end

  def add_object(name)
    @store ||= []
    @store << name
  end

  def all
    @store ||= []
    @store
  end
end