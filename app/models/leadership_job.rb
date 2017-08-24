class LeadershipJob < ActiveRecord::Base
  validates :guid, uniqueness: true
end
