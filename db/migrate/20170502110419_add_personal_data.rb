class AddPersonalData < ActiveRecord::Migration
  def change
    add_column :participants, :sex, :string, null: false
    add_column :participants, :title, :string
    add_column :participants, :first_name, :string, null: false
    add_column :participants, :last_name, :string, null: false
    add_column :participants, :organisation, :string, null: false
    add_column :participants, :address, :string, null: false
    add_column :participants, :postal_code, :integer, null: false
    add_column :participants, :city, :string, null: false
    add_column :participants, :country, :string, null: false
    add_column :participants, :email, :string, null: false
    add_column :participants, :telephone, :string
    add_column :participants, :accepted_data_storage, :boolean, null: false
  end
end
