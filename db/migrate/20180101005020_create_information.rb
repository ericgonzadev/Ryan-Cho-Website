class CreateInformation < ActiveRecord::Migration[5.0]
  def change
    create_table :information do |t|
      t.string :name
      t.string :headline
      t.string :headline_description
      t.text :about_me
      t.text :contact_description
      t.string :quote
      t.string :facebook
      t.string :twitter
      t.string :instagram
      t.string :linkedin
      t.string :vimeo
      t.string :youtube

      t.timestamps
    end
  end
end
