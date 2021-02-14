# frozen_string_literal: true

module ImportRecords
  class Users < Objects
    def create_importer
      UsersImporter.new(params)
    end
  end
end
