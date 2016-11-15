require 'byebug'

class Atm
  attr_accessor :funds

  def initialize
    @funds = 1000
  end

  def withdraw(amount, pin_code, exp_date, account)
    case
    when card_expired?(account.exp_date)
      { status: false, message: 'card expired', date: Date.today }
    when incorrect_pin?(pin_code, account.pin_code)
      { status: false, message: 'wrong pin', date: Date.today }
    when insufficient_funds_in_account?(amount, account) then
      { status: false, message: 'insufficient funds', date: Date.today }
    when insufficient_funds_in_atm?(amount)
      { status: false, message: 'insufficient funds in ATM', date: Date.today }
    else
      perform_transaction(amount, account)
    end
  end

  private

  def card_expired?(exp_date)
    Date.strptime(exp_date, '%m/%y') < Date.today
  end

  def incorrect_pin?(pin_code, account_pin)
    pin_code != account_pin
  end

  def insufficient_funds_in_account?(amount, account)
    amount > account.funds
  end

  def insufficient_funds_in_atm?(amount)
    @funds < amount
  end

  def perform_transaction(amount, account)
      @funds -= amount
      account.funds -= amount
      { status: true, message: 'success', date: Date.today, amount: amount }
    end
  end
