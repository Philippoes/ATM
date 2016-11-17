class Person
  attr_accessor :name, :cash, :account

  def initialize(attrs = {})
    set_name(attrs[:name])
    @cash = 0
  end

  def set_name(name)
    name == nil ? missing_name : @name = name
  end

  def missing_name
    raise 'A name is required'
  end

  def create_account
    @account = Account.new({owner: self})
  end

  def deposit(amount, pin_code, account, atm)
    # # case
    # # when incorrect_pin?(pin_code, account) then
    # #   { status: false, message: 'wrong pin', date: Date.today }
    # else
      perform_deposit(amount, account, atm)
    # end
  end

  def perform_deposit(amount, acount, atm)
    @cash -= amount
    account.funds += amount
    atm.funds += amount
    #{ status: true, message: 'successful deposit', date: Date.today, amount: amount, bills: add_bills(amount) }
  end

  # def incorrect_pin?
  #   pin_code != account.pin_code
  # end
end
