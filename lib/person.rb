class Person
  attr_accessor :name

  def initialize(attrs = {})
    @name = attrs[:name]
    if @name == nil
      raise 'A name is required'
    end
  end
end
