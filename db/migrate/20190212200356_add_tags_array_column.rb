class AddTagsArrayColumn < ActiveRecord::Migration[5.2]
  def up
    add_column :notes, :tags, :string, array: true, default: []
  end

  def down
    remove_column :notes, :tags
  end
end
