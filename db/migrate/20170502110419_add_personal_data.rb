class AddPersonalData < ActiveRecord::Migration
  def change
    add_column :participants, :sex, :string
    add_column :participants, :title, :string
    add_column :participants, :first_name, :string
    add_column :participants, :last_name, :string
    add_column :participants, :organisation, :string
    add_column :participants, :address, :string
    add_column :participants, :postal_code, :integer
    add_column :participants, :city, :string
    add_column :participants, :country, :string
    add_column :participants, :email, :string
    add_column :participants, :telephone, :string
    add_column :participants, :accepted_data_storage, :boolean
  end
end
