# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportRecords::Users do
  subject(:object) { described_class.new(params) }

  let(:importer) { instance_spy('ImportRecords::UsersImporter') }
  let(:params) do
    { path: 'path', unique_by: :email, klass: Admin, headers: %i[email password] }
  end

  before do
    allow(ImportRecords::UsersImporter).to receive(:new).and_return(importer)
  end

  it '#import' do
    object.import

    expect(ImportRecords::UsersImporter).to have_received(:new).with(params)
    expect(importer).to have_received(:fetch)
    expect(importer).to have_received(:save)
  end
end
