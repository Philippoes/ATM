require './lib/person.rb'
require './lib/atm.rb'
require './lib/account.rb'

describe Person do
subject { described_class.new(name: 'Philip', cash: 200) }

  it 'is expected to have :name on initialize' do
    expect(subject.name).not_to be nil
  end

  it 'is expected to raise error if no name is set' do
    expect { described_class.new }.to raise_error 'A name is required'
  end

  it 'is supposed to have a :cash attribute with a value of 0 on initialize' do
    expect(subject.cash).to eq 0
  end

  it 'is expected to have an :account attribute' do
    expect(subject.account).to be nil
  end

  describe 'can create an Account' do
    before { subject.create_account }
    it 'of account class' do
      expect(subject.account).to be_an_instance_of Account
    end

    it 'and be the owner of that account' do
      expect(subject.account.owner).to be subject
    end
  end

  describe 'can manage funds if account has been created' do
    let(:atm) { Atm.new }
    before { subject.create_account }

    it 'can not manage funds if no account has been created' do
      account = nil
      expect{subject.deposit(100, 9999, account, atm)}.to raise_error(RuntimeError, 'No account present')
    end

    it 'funds are added to the account upon deposit' do
      expected_output = { status: true, message: 'successful deposit', date: Date.today, amount: 100 }
      expect(subject.deposit(100, subject.account.pin_code, subject.account, atm)).to eq expected_output
    end

    it 'rejects deposit if pin is incorrect' do
    expected_output = { status: false, message: 'wrong pin', date: Date.today }
    expect(subject.deposit(100, 9999, subject.account, atm)).to eq expected_output
  end

  it 'receives cash upon atm wtihdrawal' do
    command = lambda {subject.withdraw(100, subject.account.pin_code, subject.account, atm)}
    expect(command.call).to be_truthy
  end

  it 'withdraw is expected to raise error if no ATM is passed in' do
    atm = nil
    command = lambda { subject.withdraw(100, subject.account.pin_code, subject.account, atm)}
    expect { command.call }.to raise_error(RuntimeError, 'An ATM is required')
  end
end
end
