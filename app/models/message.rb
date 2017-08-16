class Message < ActiveRecord::Base
  validates :name, :email, :content, presence: true
  validates_format_of :email, :with => Devise::email_regexp
  validates_length_of :name, :maximum => 100
  validates_length_of :email, :maximum => 120
  validates_length_of :content, :maximum => 500
  validates :phone, format: { with: /\d{3}-\d{3}-\d{4}/, }, allow_blank: true
end
