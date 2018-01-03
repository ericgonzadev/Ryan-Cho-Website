class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.string :link
      t.string :video_source
      t.string :work_type
      t.string :thumbnail
      t.integer :order

      t.timestamps
    end
  end
end
