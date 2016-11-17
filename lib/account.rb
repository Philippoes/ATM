require 'date'

class Account
  attr_accessor :funds, :account_status, :owner
  attr_reader :pin_code, :exp_date

  STANDARD_VALIDITY_YRS = 5

  def initialize(attrs = {})
    @funds = 1000
    set_pin_code
    set_exp_date
    set_account_status_to_active
    set_owner(attrs[:owner])
  end

  def deactivate
    @account_status = :deactivated
  end

  private

  def set_account_status_to_active
    @account_status = :active
  end

  def set_pin_code
    @pin_code = rand(1000..9999)
  end

  def set_exp_date
    @exp_date = Date.today.next_year(STANDARD_VALIDITY_YRS).strftime('%m/%y')
  end

  def set_owner(owner)
    owner == nil ? missing_owner : @owner = owner
  end

  def missing_owner
    raise 'An account owner is required'
  end
end
