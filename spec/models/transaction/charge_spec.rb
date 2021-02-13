# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction::Charge do
  it_behaves_like 'models has uuid'
  it_behaves_like 'models transaction'
end
