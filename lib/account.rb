require 'date'

class Account
  attr_accessor :funds, :account_status, :owner
  attr_reader :pin_code, :exp_date

  STANDARD_VALIDITY_YRS = 5

  def initialize(attrs = {})
    @funds = 1000
    @pin_code = set_pin_code
    @exp_date = set_exp_date
    @account_status = :active
    set_owner(attrs[:owner])
  end

  def set_pin_code
    rand(1000..9999)
  end

  def set_exp_date
    Date.today.next_year(STANDARD_VALIDITY_YRS).strftime('%m/%y')
  end

  def deactivate
    @account_status = :deactivated
  end

  private

  def set_owner(attrs)
    attrs == nil ? missing_owner : @owner = attrs
  end

  def missing_owner
    raise 'An account owner is required'
  end
end
