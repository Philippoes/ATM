require './lib/atm.rb'

describe Atm do
  let(:account) { instance_double('Account') }

  before do
    allow(account).to receive(:funds).and_return(150)
    allow(account).to receive (:funds=)
  end

  it 'has 1000$ on initialize' do
    expect(subject.funds).to eq 1000
  end

  it 'should be able to withdraw' do
    subject.withdraw(50, account)
    expect(subject.funds).to eq 950
  end

  it 'rejects withdrawal if account has insufficient funds' do
    expected_output = { status: true, message: 'insufficient funds', date: Date.today }
    expect(subject.withdraw(155, account)).to eq expected_output
  end

  it 'will allow withdrawal if account has enough funds' do
    expected_output = { status: true, message: 'success', date: Date.today, amount: 50 }
    expect(subject.withdraw(50, account)).to eq expected_output
  end

  it 'rejects withdrawal if ATM has insufficient funds' do
    subject.funds = 50
    expected_output = { status: false, message: 'insufficient funds in ATM', date: Date.today}
    expect(subject.withdraw(100, account)). to eq expected_output
  end
end
