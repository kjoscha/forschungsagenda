class Participant < ActiveRecord::Base
  validates_confirmation_of :email

  validates :first_name,
    presence: true,
    length: { minimum: 3 }
  validates :email,
    presence: true,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
    uniqueness: true
  validates :telephone,
    format: { with: /\A((?![a-zA-Z]).){3,20}\z/ }, if: 'telephone.present?'
end
