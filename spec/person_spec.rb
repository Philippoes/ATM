require './lib/person.rb'
require './lib/atm.rb'
require './lib/account.rb'

describe Person do
  let(:atm) { Atm.new }
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

  it 'can create an Account of Account Class and be the owner of that account' do
      subject.create_account
      expect(subject.account).to be_an_instance_of Account
      expect(subject.account.owner).to be subject
  end

  it 'can manage funds if an account has been created' do
    subject.create_account
    expected_output = { status: true, message: 'successful deposit', date: Date.today, amount: 100 }
    expect(subject.deposit(100, subject.account.pin_code, subject.account, atm)).to eq expected_output
  end

  it 'rejects deposit if pin is incorrect' do
    subject.create_account
    expected_output = { status: false, message: 'wrong pin', date: Date.today }
    expect(subject.deposit(100, 9999, subject.account, atm)).to eq expected_output
  end
end
