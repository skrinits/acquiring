# frozen_string_literal: true

if Rails.env.development?
  Linters.configure do |config|
    config.custom_linters = {
      brakeman: {
        command: 'brakeman --quiet --skip-libs -f json',
        parse_output: lambda { |output|
          JSON.parse(output)['scan_info']['security_warnings']
        }
      }
    }
  end
end
