class CreatePullRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :pull_requests do |t|
      t.string :html_url
      t.integer :number

      t.timestamps
    end
  end
end
