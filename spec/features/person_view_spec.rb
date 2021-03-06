require 'rails_helper'

describe 'the person view', type: :feature do
  let(:person) {Person.create(first_name: 'John', last_name: 'Smith')}

  describe 'phone numbers', type: :feature do
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

    it 'has a link to add a new phone number' do
      expect(page).to have_link('Add phone number', href: new_phone_number_path(person_id: person.id))
    end

    it 'it adds a new phone number' do
      page.click_link('Add phone number')
      page.fill_in('Number', with: '555-1919')
      page.click_button('Create Phone number')

      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-1919')
    end

    it 'has links to edit phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end

    it 'edits a phone number' do
      phone = person.phone_numbers.first
      old_number = phone.number

      first(:link, 'edit phone number').click
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-9191')
      expect(page).not_to have_content(old_number)
    end

    it 'has links to delete phone numbers' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('delete phone number', href: phone_number_path(phone))
      end
    end

    it 'deletes a phone number' do
      phone  = person.phone_numbers.first
      old_number = phone.number

      first(:link, 'delete phone number').click
      expect(current_path).to eq(person_path(person))
      expect(page).not_to have_content(old_number)
    end
  end

  describe 'email addresses', type: :feature do
    before(:each) do
      person.email_addresses.create!(address: 'you@example.com', person_id: person.id)
      person.email_addresses.create!(address: 'me@example.com', person_id: person.id)

      visit person_path(person)
    end

    it 'has a list item for each email address' do
      person.email_addresses.each do |email|
        expect(page).to have_selector('li', text: email.address)
      end
    end

    it 'has an add email address link' do
      expect(page).to have_link('Add email address', href: new_email_address_path(person_id: person.id))
    end

    it 'adds email address' do
      page.click_link('Add email address')
      fill_in('Address', with: 'add_email@example.com')
      click_button('Create Email address')

      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('add_email@example.com')
    end

    it 'has an edit email address link' do
      person.email_addresses.each do |email|
        expect(page).to have_link('edit email address', href: edit_email_address_path(email))
      end
    end

    it 'edits email address' do
      first(:link, 'edit email address').click
      fill_in('Address', with: 'revised_email@example.com')
      click_button('Update Email address')

      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('revised_email@example.com')
    end

    it 'has an delete email address link' do
      person.email_addresses.each do |email|
        expect(page).to have_link('delete email address', href: email_address_path(email))
      end
    end
  end

end


