# frozen_string_literal: true

shared_examples 'tasks import_records' do |task_name, klass, headers, importer_klass, unique_by|
  let(:importer) { instance_spy(importer_klass.to_s) }

  before { allow(importer_klass).to receive(:new).and_return(importer) }

  after { Rake::Task["import_records:#{task_name}"].reenable }

  context 'if a path is present' do
    it do
      Rake::Task["import_records:#{task_name}"].invoke('path')

      expect(importer_klass).to have_received(:new).with(
        path: 'path', unique_by: unique_by, klass: klass, headers: headers
      )
      expect(importer).to have_received(:import)
    end
  end

  context 'if a path is absent' do
    it do
      expect { Rake::Task["import_records:#{task_name}"].invoke }.to raise_error(ArgumentError)
    end
  end
end
