class Person
  attr_accessor :name, :cash, :account

  def initialize(attrs = {})
    @name = attrs[:name]
    @cash = 0
    if @name == nil
      raise 'A name is required'
    end
  end

  def create_account
    @account = Account.new({owner: self})
  end
end
