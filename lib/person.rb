class Person
  attr_accessor :name, :cash, :account

  def initialize(attrs = {})
    @name = attrs[:name]
    @cash = 0
    @account = create_account
    if @name == nil
      raise 'A name is required'
    end
  end

  def create_account
    Account.new({owner: self})
  end
end
