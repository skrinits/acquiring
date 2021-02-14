# frozen_string_literal: true

module ImportRecords
  class UsersImporter < CsvImporter
    protected

    def prepare(record_params)
      result = super(record_params)

      password = result.delete(:password)

      result.merge(encrypted_password: encrypt_password(password))
    end

    private

    def encrypt_password(password)
      Admin.new(password: password).encrypted_password
    end
  end
end
