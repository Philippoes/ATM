require './lib/person.rb'
require './lib/atm.rb'

describe Person do
subject { described_class.new(name: 'Philip') }
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
    expect(subject.account).not_to be nil
  end
end
