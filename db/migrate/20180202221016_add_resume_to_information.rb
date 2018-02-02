class AddResumeToInformation < ActiveRecord::Migration[5.0]
  def change
    add_column :information, :resume, :string
  end
end
