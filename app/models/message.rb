class Message < ActiveRecord::Base
  validates :name, :email, :content, presence: true
  validates_format_of :email, :with => Devise::email_regexp
  validates_length_of :name, :maximum => 100
  validates_length_of :email, :maximum => 120
  validates_length_of :content, :maximum => 500
  validates_length_of :phone, :maximum => 15

  # Format Validations
  validates :content, format: {
    with: /\A[a-zA-Z0-9!#$%&*()-_:";'?\/,.\s]*\z/,
    message: "Only alphanumeric characters, whitespace and !#$%&*()-_:\";'/,.]*$ are allowed."
  }

  validates :phone, format: {
    with: /\A[0-9()-+ ]*\z/,
    message: "Only numeric characters, space, parantheses, plus sign and hyphen are allowed."
  }
end
