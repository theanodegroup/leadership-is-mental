class CreateLeadershipJobs < ActiveRecord::Migration
  def change
    create_table :leadership_jobs do |t|
      t.string :title
      t.text :description
      t.string :link
      t.date :pub_date
      t.text :source
      t.string :guid

      t.timestamps null: false
    end
  end
end
