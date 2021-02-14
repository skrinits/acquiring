# frozen_string_literal: true

module ImportRecords
  class CsvRecords < Objects
    def create_importer
      CsvImporter.new(params)
    end
  end
end
