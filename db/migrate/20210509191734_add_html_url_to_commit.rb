class AddHtmlUrlToCommit < ActiveRecord::Migration[6.1]
  def change
    add_column :commits, :html_url, :string
  end
end
