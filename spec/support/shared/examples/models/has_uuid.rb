# frozen_string_literal: true

shared_examples 'models has uuid' do
  let(:factory_name) { described_class.to_s.underscore.tr('/', '_') }

  describe 'Validations' do
    it 'validates presence of uuid' do
      expect(subject).to validate_presence_of(:uuid)
    end

    it 'validates uniqueness of uuid' do
      expect(build(factory_name)).to validate_uniqueness_of(:uuid).case_insensitive
    end
  end

  describe 'Callbacks' do
    describe 'initialization uuid' do
      context 'if uuid is set' do
        let(:object) { described_class.new(uuid: uuid) }
        let(:uuid) { Digest::UUID.uuid_v4 }

        it { expect(object.uuid).to eq(uuid) }
      end

      context "if uuid isn't set" do
        let(:object) { described_class.new }

        it { expect(object.uuid).to be_present }
      end
    end
  end
end
