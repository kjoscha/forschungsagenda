class AddFurtherAttributes < ActiveRecord::Migration
  def change
    add_column :participants, :division, :string
    add_column :participants, :projects, :string
    add_column :participants, :position, :string
    add_column :participants, :group, :string
    add_column :participants, :custom_group, :string
    add_column :participants, :do_opening, :boolean
    add_column :participants, :do_lunch, :boolean
    add_column :participants, :do_1330_workshop, :integer
    add_column :participants, :do_dinner, :boolean
    add_column :participants, :fr_1015_workshop, :integer
    add_column :participants, :fr_lunch, :boolean
    add_column :participants, :focus, :string
    add_column :participants, :transport, :string
    add_column :participants, :measure, :string
    add_column :participants, :slogan, :string
  end
end
