# frozen_string_literal: true

require 'rails_helper'

describe Transactions::Place do
  subject(:organizer) { described_class.new }

  let(:interactors) do
    [Transactions::ConvertParams,
     Transactions::CheckParams,
     Transactions::CreateAuthorization,
     Transactions::CreateCharge,
     Transactions::CreateRefund,
     Transactions::CreateReverse]
  end

  before do
    interactors.each do |interactor|
      allow(interactor).to receive(:call!)
    end
  end

  it 'call the chain of interactors' do
    expect(organizer).to organize_interactors(*interactors)
  end
end
