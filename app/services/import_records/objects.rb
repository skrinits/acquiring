# frozen_string_literal: true

module ImportRecords
  class Objects
    def initialize(params)
      @params = params
    end

    # :reek:FeatureEnvy
    def import
      importer = create_importer

      importer.fetch
      importer.save
    end

    protected

    attr_reader :params

    def create_importer
      raise NotImplementedError
    end
  end
end
