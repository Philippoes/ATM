require 'byebug'
require 'date'

class Atm
  attr_accessor :funds

  def initialize
    @funds = 1000
  end

  def withdraw(amount, pin_code, account)
    case
    when account_disabled?(account.account_status) then
      { status: false, message: 'account disabled', date: Date.today }
    when card_expired?(account.exp_date) then
      { status: false, message: 'card expired', date: Date.today }
    when incorrect_pin?(pin_code, account.pin_code) then
      { status: false, message: 'wrong pin', date: Date.today }
    when insufficient_funds_in_account?(amount, account) then
      { status: false, message: 'insufficient funds', date: Date.today }
    when insufficient_funds_in_atm?(amount) then
      { status: false, message: 'insufficient funds in ATM', date: Date.today }
    else
      perform_transaction(amount, account)
    end
  end

  private

  def account_disabled?(account_status)
    account_status != :active
  end

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
