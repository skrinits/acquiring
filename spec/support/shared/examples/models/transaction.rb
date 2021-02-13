# frozen_string_literal: true

shared_examples 'models transaction' do
  describe 'Validations' do
    it 'validates amount' do
      expect(subject).to validate_numericality_of(:amount).is_greater_than(0)
    end

    it 'validates customer_email' do
      expect(subject).to validate_presence_of(:customer_email)
    end

    it 'validates status' do
      expect(subject).to validate_presence_of(:status)
    end
  end
end
