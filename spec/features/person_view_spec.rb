require 'rails_helper'

describe 'the person view', type: :feature do
  let(:person) {Person.create(first_name: 'John', last_name: 'Smith')}

  before(:each) do
    person.phone_numbers.create!(number: '555-1234')
    person.phone_numbers.create!(number: '555-2873')
    visit person_path(person)
  end

  it 'shows the phone numbers' do
    person.phone_numbers.each do |phone|
      expect(page).to have_content(phone.number)
    end
  end
end
