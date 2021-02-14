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
