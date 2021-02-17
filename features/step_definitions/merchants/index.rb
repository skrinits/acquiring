# frozen_string_literal: true

Given 'the Admin is on the merchants index page' do
  sign_in(:admin, create(:admin))

  @merchant = create(:merchant)

  visit('/merchants/')
end

When 'the Admin clicks on an name' do
  click_link(@merchant.name)
end

Then 'the Admin is gone to an show merchant page' do
  expect(page).to have_content('Information about the merchant')
end
