class ModifyMembers1 < ActiveRecord::Migration
  def change
    add_column :members, :hashed_password, :stirng
  end
end
