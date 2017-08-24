class AddEbookToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :ebook, :boolean
  end
end
