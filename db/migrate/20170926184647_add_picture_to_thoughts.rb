class AddPictureToThoughts < ActiveRecord::Migration[5.1]
  def change
    add_column :thoughts, :picture, :string
  end
end
