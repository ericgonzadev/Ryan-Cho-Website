class AddAboutImageToInformation < ActiveRecord::Migration[5.0]
  def change
    add_column :information, :about_image, :string
  end
end
