class LeadershipJob < ActiveRecord::Base
  validates :guid, uniqueness: true

  paginates_per 10

  default_scope { order(pub_date: :desc) }
end
