require './lib/account.rb'

describe Account do

  it 'should have a 4 digit pin_code' do
    pin_code_length = Math.log10(subject.pin_code).to_i + 1
    expect(pin_code_length).to eq 4
  end
end
