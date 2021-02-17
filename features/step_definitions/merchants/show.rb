# frozen_string_literal: true

Given 'the Admin is on the merchant show page' do
  sign_in(:admin, create(:admin))

  @merchant = create(:merchant)

  visit("/merchants/#{@merchant.id}/")
end

When 'the Admin clicks the edit button' do
  click_link('Edit')
end

Then 'the Admin is gone to an merchant customization page' do
  expect(page).to have_content('Merchant customization')
end

And 'the Admin changes an email' do
  fill_in 'merchant_customization[email]', with: 'test@mail.com'
end

And 'the Admin clicks on update button' do
  click_on('Update')
end

Then 'the Admin is gone to show merchant page' do
  expect(page).to have_content('Information about the merchant')
end
