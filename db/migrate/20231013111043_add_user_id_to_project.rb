class AddUserIdToProject < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :uid, :integer
  end
end
