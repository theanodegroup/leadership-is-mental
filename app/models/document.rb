class Document < ActiveRecord::Base
  mount_uploader :doc, DocumentUploader
end
