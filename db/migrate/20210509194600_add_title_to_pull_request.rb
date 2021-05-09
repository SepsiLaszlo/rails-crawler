class AddTitleToPullRequest < ActiveRecord::Migration[6.1]
  def change
    add_column :pull_requests, :title, :string
  end
end
