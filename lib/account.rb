class Account
  attr_accessor :funds, :account_status
  attr_reader :pin_code, :exp_date

  def initialize
    @funds = 1000
    @pin_code = rand(1000..9999)
    @exp_date = '12/18'
    @account_status = :Active
  end
end
