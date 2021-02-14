# frozen_string_literal: true

require 'rails_helper'

Rails.application.load_tasks

describe 'import_records' do
  describe 'admins' do
    it_behaves_like(
      'tasks import_records', 'admins', Admin, %i[email password], ImportRecords::Users, :email
    )
  end

  describe 'merchants' do
    it_behaves_like(
      'tasks import_records', 'merchants', Merchant,
      %i[name email description status password], ImportRecords::Users, :email
    )
  end
end
