class CreateLeadershipJobs < ActiveRecord::Migration
  def change
    create_table :leadership_jobs do |t|
      t.string :title
      t.text :description
      t.string :link
      t.string :pubdate

      t.timestamps null: false
    end
  end
end
