class Person
  attr_accessor :name, :cash, :account

  def initialize(attrs = {})
    set_name(attrs[:name])
    @cash = 0
  end

  def set_name(attrs)
    attrs == nil ? missing_name : @name = attrs
  end

  def missing_name
    raise 'A name is required'
  end

  def create_account
    @account = Account.new({owner: self})
  end
end
