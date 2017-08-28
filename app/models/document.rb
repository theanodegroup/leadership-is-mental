class Document < ActiveRecord::Base
  mount_uploader :doc, DocumentUploader

  NAME_EBOOK = 'eBook'

  def self.ebook
    Document.find_by(name: NAME_EBOOK)
  end
end
