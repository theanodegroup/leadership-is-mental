module PhrasingHelper
  # You must implement the can_edit_phrases? method.
  # Example:
  #
  # def can_edit_phrases?
  #  current_user.is_admin?
  # end

  def can_edit_phrases?
    user_signed_in?
  end

  def phrase_lookup(key)
    PhrasingPhrase.find_by(locale: I18n.locale, key: key).try(:value)
  end

  def editable_type(phrase)
    if phrase.downcase.starts_with?('quill')
      'quill'
    else
      'text'
    end
  end
end
