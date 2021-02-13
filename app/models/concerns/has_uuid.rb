# frozen_string_literal: true

module HasUuid
  extend ActiveSupport::Concern

  included do
    # postgres convert uuid to downcase
    # rails validates a content of the uuid type, set it to nil if its value is invalid
    validates :uuid, uniqueness: { case_sensitive: false }
    validates :uuid, presence: true

    after_initialize :initialize_uuid
  end

  private

  def initialize_uuid
    self.uuid ||= Digest::UUID.uuid_v4
  end
end
