class Account
  attr_accessor :funds, :account_status
  attr_reader :pin_code, :exp_date

  STANDARD_VALIDITY_YRS = 5
  
  def initialize
    @funds = 1000
    @pin_code = set_pin_code
    @exp_date = set_exp_date
    @account_status = :Active
  end

  private

  def set_pin_code
    rand(1000..9999)
  end

  def set_exp_date
    Date.today.next_year(STANDARD_VALIDITY_YRS).strftime('%m/%y')
  end
end
