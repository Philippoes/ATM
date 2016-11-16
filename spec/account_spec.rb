require './lib/account.rb'

describe Account do
  let(:person) { instance_double('Person', name: 'Philip') }
  subject { described_class.new({owner: person}) }

  it 'should have a 4 digit pin_code' do
    pin_code_length = Math.log10(subject.pin_code).to_i + 1
    expect(pin_code_length).to eq 4
  end

  it 'should have an expiry date on initialize' do
    expected_date = Date.today.next_year(5).strftime("%m/%y")
    expect(subject.exp_date).to eq expected_date
  end

  it 'is expected to have :active status on initialize' do
    expect(subject.account_status).to eq :active
  end

  it 'deactivates account using Instance method' do
    subject.deactivate
    expect(subject.account_status).to eq :deactivated
  end
  #because deactivating account using class method would deactivate all future accounts?

  it 'is expected to have an owner' do
    expect(subject.owner).to eq person
  end

  it 'is expected to raise error if no owner is set' do
    expect { described_class.new }.to raise_error 'An account owner is required'
  end
end
