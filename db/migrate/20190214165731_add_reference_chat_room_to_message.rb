class AddReferenceChatRoomToMessage < ActiveRecord::Migration[5.2]
  def change
    add_reference :messages, :room, foreign_key: { to_table: :chat_rooms }
    add_reference :chat_rooms, :sender, foreign_key: { to_table: :users }
    add_reference :chat_rooms, :recipient, foreign_key: { to_table: :users }
  end
end
