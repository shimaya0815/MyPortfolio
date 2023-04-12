class RenameColumnsInBooks < ActiveRecord::Migration[5.2]
  def change
    rename_column :books, :book_name, :title
    rename_column :books, :caption, :body
  end
end
