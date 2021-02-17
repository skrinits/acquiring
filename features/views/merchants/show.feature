Feature: Merchant show page
  Scenario: the Admin wants to edit some fields
  Given the Admin is on the merchant show page
  When the Admin clicks the edit button
  Then the Admin is gone to an merchant customization page
  And the Admin changes an email
  And the Admin clicks on update button
  Then the Admin is gone to show merchant page
