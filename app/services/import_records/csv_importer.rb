# frozen_string_literal: true

require 'csv'

module ImportRecords
  class CsvImporter < BaseImporter
    def fetch
      open_csv.each do |row|
        records << prepare(convert_to_hash(row))
      end
    end

    protected

    def prepare(record_params)
      current_time = Time.current

      record_params.merge(created_at: current_time, updated_at: current_time)
    end

    def open_csv
      CSV.open(params[:path], headers: false, col_sep: ';')
    end
  end
end
