module PhrasingHelper
  # You must implement the can_edit_phrases? method.
  # Example:
  #
  # def can_edit_phrases?
  #  current_user.is_admin?
  # end

  def can_edit_phrases?
    true
  end

  def phrase_lookup(key)
    PhrasingPhrase.find_by(locale: I18n.locale, key: key).try(:value)
  end
end
