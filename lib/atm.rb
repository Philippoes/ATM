require 'byebug'
require 'date'

class Atm
  attr_accessor :funds

  def initialize
    @funds = 1000
  end

  def withdraw(amount, pin_code, account)
    case
    when account_disabled?(account)
      generate_error_message('account disabled')
    when card_expired?(account)
      generate_error_message('card expired')
    when incorrect_pin?(pin_code, account)
      generate_error_message('wrong pin')
    when insufficient_funds_in_account?(amount, account)
      generate_error_message('insufficient funds')
    when insufficient_funds_in_atm?(amount)
      generate_error_message('insufficient funds in ATM')
    else
      perform_transaction(amount, account)
    end
  end

  private

  def account_disabled?(account)
    account.account_status != :active
  end

  def card_expired?(account)
    Date.strptime(account.exp_date, '%m/%y') < Date.today
  end

  def incorrect_pin?(pin_code, account)
    pin_code != account.pin_code
  end

  def insufficient_funds_in_account?(amount, account)
    amount > account.funds
  end

  def insufficient_funds_in_atm?(amount)
    @funds < amount
  end

  def perform_transaction(amount, account)
      deduct_funds_from_atm(amount)
      deduct_funds_from_account(amount, account)
      generate_success_message(amount)
  end

  def deduct_funds_from_atm(amount)
    @funds -= amount
  end

  def deduct_funds_from_account(amount, account)
    account.funds -= amount
  end

  def generate_error_message(message)
    { status: false, message: message, date: Date.today }
  end

  def generate_success_message(amount)
    { status: true, message: 'success', date: Date.today, amount: amount, bills: add_bills(amount) }
  end

  def add_bills(amount)
    denomination = [20, 10, 5]
    bills = []
    denomination.each do |denomination|
      while amount - denomination >= 0
        amount -= denomination
        bills << denomination
      end
    end
    bills
  end
end
