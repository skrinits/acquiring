Feature: Transactions index page
  Scenario: the Admin wants to see an information about a transaction
  Given the Admin is on the transactions index page
  When the Admin clicks on an uuid
  Then the Admin is gone to an show transaction page
