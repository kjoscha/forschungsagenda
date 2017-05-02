class Participant < ActiveRecord::Base
  validates_confirmation_of :email

  validates :sex, :first_name, :last_name, :email, :organisation, :address, :postal_code, :city, :country, presence: true

  validates :first_name, length: { minimum: 2 }
  validates :last_name, length: { minimum: 2 }
  validates :organisation, length: { minimum: 2 }
  validates :postal_code, length: { minimum: 2 }
  validates :city, length: { minimum: 3 }
  validates :country, length: { minimum: 3 }
  validates :address, length: { minimum: 5 }

  validates :email,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
    uniqueness: true
  validates :telephone,
    format: { with: /\A((?![a-zA-Z]).){3,20}\z/ }, if: 'telephone.present?'
end
