class CreateCommits < ActiveRecord::Migration[6.1]
  def change
    create_table :commits do |t|
      t.references :pull_request, null: true, foreign_key: true
      t.string :sha

      t.timestamps
    end
  end
end
