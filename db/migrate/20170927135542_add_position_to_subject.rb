class AddPositionToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :position, :integer
    add_column :subjects, :visible, :boolean, default: :false
  end
end
