class Account
  attr_accessor :funds, :pin_code, :exp_date, :account_status

  def initialize
    @funds = 1000
    @pin_code = 1234
    @exp_date = '12/18'
    @account_status = :Active
  end
end
