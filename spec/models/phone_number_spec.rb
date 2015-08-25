require 'rails_helper'

RSpec.describe PhoneNumber, type: :model do
  let(:person) {Person.create(first_name: 'Billy', last_name: 'Watson')}
  let(:phone_number) {PhoneNumber.new(number: "112233445", contact_id: person.id, contact_type: 'Person')}

  it 'is valid' do
    expect(phone_number).to be_valid
  end

  it 'is invalid without a phone number' do
    phone_number.number = nil
    expect(phone_number).to_not be_valid
  end

  it 'must have a references to a person' do
    phone_number.contact_id = nil
    expect(phone_number).to_not be_valid
  end

  it 'is associated with a person' do
    expect(phone_number).to respond_to(:contact)
  end
end
