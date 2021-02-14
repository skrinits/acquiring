# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImportRecords::UsersImporter do
  subject(:importer) { described_class.new(params) }

  let(:params) { { path: path, unique_by: unique_by, klass: klass, headers: headers } }
  let(:path) { File.join(fixture_path, 'files', 'admins.csv') }
  let(:unique_by) { :email }
  let(:klass) { Admin }
  let(:headers) { %i[email password] }
  let(:records) { importer.instance_variable_get('@records') }
  let(:expected_keys) { %i[email created_at updated_at encrypted_password] }

  before { allow(klass).to receive(:insert_all) }

  it '#fetch' do
    importer.fetch

    expect(records.count).to eq(1)
    expect(records.first.compact).to include(*expected_keys)
  end

  it '#save' do
    importer.fetch

    importer.save

    expect(klass).to have_received(:insert_all).with(records, unique_by: unique_by)
  end
end
