# frozen_string_literal: true

Given 'the Admin is on the transactions index page' do
  sign_in(:admin, create(:admin))

  @transaction = create(:transaction_authorization)

  visit('/transactions/')
end

When 'the Admin clicks on an uuid' do
  click_link(@transaction.uuid)
end

Then 'the Admin is gone to an show transaction page' do
  expect(page).to have_content('Information about the transaction')
end
