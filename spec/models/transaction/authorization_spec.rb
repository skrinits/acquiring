# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transaction::Authorization do
  it_behaves_like 'models has uuid'
  it_behaves_like 'models transaction'
end
