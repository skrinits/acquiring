# frozen_string_literal: true

namespace :import_records do
  desc 'Import admins'
  task :admins, [:path] => :environment do |_task, args|
    raise ArgumentError, 'path can\'t be blank' if args[:path].blank?

    ImportRecords::Users.new(
      path: args[:path], unique_by: :email, klass: Admin, headers: %i[email password]
    ).import
  end

  desc 'Import merchants'
  task :merchants, [:path] => :environment do |_task, args|
    raise ArgumentError, 'path can\'t be blank' if args[:path].blank?

    ImportRecords::Users.new(
      path: args[:path], unique_by: :email, klass: Merchant, headers: %i[name email description status password]
    ).import
  end
end
