# Run linters
`rake linters:run_all`

# Import admins and merchants
## Admins
1. a csv file should be without headers
2. the header order: email;password
3. the column separator is a semicolomn
4. `rake import_records:admins[path_to_file]`

## Merchants
1. a csv file should be without headers
2. the header order: name;email;description;status;password
3. the column separator is a semicolomn
4. `rake import_records:merchants[path_to_file]`

# Installation background deleting old transactions
`whenever -i -s 'environment=your_environment'`

# Accepting payments using XML/ JSON API
1. send a post request to /api/v1/transactions with basic authentication
2. basic authentication creditials for develop environment: name=name password=password
3. format requests in /spec/fixtures/files

# UI
1. For filling database: rake db:seed
2. login and password for the admin: admin@mail.ru/password

# Feature tests
1. for running: `cucumber`
2. tests is placed in ./features
