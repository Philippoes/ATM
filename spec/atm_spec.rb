require './lib/atm.rb'

describe Atm do
  let(:account) { instance_double('Account') }

  before do
    allow(account).to receive(:funds).and_return(100)
    allow(account).to receive (:funds=)
  end

  it 'has 1000$ on initialize' do
    expect(subject.funds).to eq 1000
  end

  it 'should be able to withdraw' do
    subject.withdraw(50, account)
    expect(subject.funds).to eq 950
  end

  it 'will allow withdrawal if account has enough funds' do
    expected_output = { status: true, message: 'success', date: Date.today, amount: 50 }
    expect(subject.withdraw(50, account)).to eq expected_output
  end
end
