# frozen_string_literal: true

module ImportRecords
  class BaseImporter
    BUNCH_LIMIT = 1_000

    def initialize(params)
      @params = params.symbolize_keys
      @records = []
    end

    def fetch
      raise NotImplementedError
    end

    def save
      records.each_slice(BUNCH_LIMIT) do |items|
        # insert_all skips validations, for validations could be used activerecord-import
        params[:klass].insert_all(items, unique_by: params[:unique_by])
      end
    end

    protected

    attr_reader :params, :records

    def convert_to_hash(row)
      Hash[params[:headers].zip(row)]
    end
  end
end
