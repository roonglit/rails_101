class AddVisibilityToRooms < ActiveRecord::Migration[7.2]
  def change
    add_column :rooms, :visibility, :integer
  end
end
