require 'date'

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
    account_does_not_exist(account) ? generate_missing_account_error :
    incorrect_pin?(pin_code, account) ? generate_error_message('wrong pin') :
    perform_deposit(amount, account, atm)
  end

  def withdraw(amount, pin_code, account, atm)
   response = atm.withdraw(amount, pin_code, account)
   response[:status] == true ? increase_cash(response) : response
  end

  private

  def increase_cash(response)
    @cash += response[:amount]
  end

  def perform_deposit(amount, acount, atm)
    deduct_cash_from_person(amount)
    add_funds_to_account(amount, account)
    generate_success_message(amount)
  end

  def deduct_cash_from_person(amount)
    @cash -= amount
  end

  def add_funds_to_account(amount, account)
    account.funds += amount
  end

  def generate_error_message(message)
    { status: false, message: message, date: Date.today }
  end

  def generate_success_message(amount)
    { status: true, message: 'successful deposit', date: Date.today, amount: amount }
  end

  def incorrect_pin?(pin_code, account)
    pin_code != account.pin_code
  end

  def account_does_not_exist(account)
    account == nil
  end

  def generate_missing_account_error
    raise RuntimeError, 'No account present'
  end
end
