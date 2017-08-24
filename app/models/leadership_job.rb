class LeadershipJob < ActiveRecord::Base
  validates :guid, uniqueness: true

  default_scope { order(pub_date: :desc) }
end
