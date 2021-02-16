# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TransactionView do
  subject(:view) { described_class.new(transaction, view_context) }

  let(:transaction) { create(:transaction_authorization) }
  let(:view_context) { instance_spy('ActionView::Base') }

  describe '#history' do
    let(:expected_result) do
      "type: Authorization status: APPROVED amount: #{transaction.amount} created_at: 15.02.2021"
    end

    before { allow(view_context).to receive(:l).and_return('15.02.2021') }

    it do
      expect(view.history).to eq(expected_result)
    end
  end
end
