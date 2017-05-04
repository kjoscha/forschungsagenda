class AddPortraitToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :portrait, :string
  end
end
