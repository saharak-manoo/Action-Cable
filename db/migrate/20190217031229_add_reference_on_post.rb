class AddReferenceOnPost < ActiveRecord::Migration[5.2]
  def change
    add_reference :chat_rooms, :user, foreign_key: { to_table: :users }
  end
end
