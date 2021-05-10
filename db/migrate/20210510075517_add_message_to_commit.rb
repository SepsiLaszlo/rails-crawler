class AddMessageToCommit < ActiveRecord::Migration[6.1]
  def change
    add_column :commits, :message, :string
  end
end
