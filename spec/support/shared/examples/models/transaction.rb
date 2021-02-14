# frozen_string_literal: true

shared_examples 'models transaction' do
  describe 'Validations' do
    it 'validates status' do
      expect(subject).to validate_presence_of(:status)
    end
  end
end
