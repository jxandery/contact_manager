require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) {Company.new(name: "Turing")}

  it 'is a valid company' do
    expect(company).to be_valid
  end

  it 'is invalid without a name' do
    company.name = nil
    expect(company).to_not be_valid
  end

  it 'responds with its phone numbers after its created' do
    phone_number = company.phone_numbers.build(number: '555-1212')
    expect(phone_number.number).to eq('555-1212')
  end

  it 'responds with its email addresses after its created' do
    email_address = company.email_addresses.build(address: 'what@thewhat.com')
    expect(email_address.address).to eq('what@thewhat.com')
  end
end
