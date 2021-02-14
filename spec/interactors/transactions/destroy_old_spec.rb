# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transactions::DestroyOld do
  describe '.call' do
    subject(:call) { described_class.call }

    let!(:old_transaction) do
      create(:transaction_authorization, created_at: (described_class::SAVING_PERIOD + 1.hour).ago)
    end
    let!(:new_transaction) do
      create(:transaction_authorization, created_at: (described_class::SAVING_PERIOD - 1.hour).ago)
    end

    it do
      call

      expect { old_transaction.reload }.to raise_error(ActiveRecord::RecordNotFound)
      expect { new_transaction.reload }.not_to raise_error
    end
  end
end
