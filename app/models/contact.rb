class Contact < ActiveRecord::Base
  # Used for Newsletter Sign up and Free Ebook
  validates :name, :email, presence: true
  validates_format_of :email, :with => Devise::email_regexp
  validates_length_of :name, :maximum => 100
  validates_length_of :email, :maximum => 120
end
