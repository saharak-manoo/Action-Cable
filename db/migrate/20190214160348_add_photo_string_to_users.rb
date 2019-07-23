class AddPhotoStringToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :photo, :string, default: "http://placehold.it/200x200&text=UserPhoto"
  end
end
