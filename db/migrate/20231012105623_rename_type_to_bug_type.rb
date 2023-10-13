class RenameTypeToBugType < ActiveRecord::Migration[7.0]
  def change
    rename_column :bugs, :type, :bug_type
  end
end
