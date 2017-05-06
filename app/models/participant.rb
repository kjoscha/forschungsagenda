class Participant < ActiveRecord::Base
  validates_confirmation_of :email, on: :create

  validates :sex, :first_name, :last_name, :email, :organisation, :address, :postal_code, :city, :country, :accepted_data_storage, presence: true
  validates :do_1330_workshop, :fr_1015_workshop, presence: true, on: :update
  validates :do_opening, :do_lunch, :do_dinner, :fr_lunch, inclusion: { in: [ true, false ] }, on: :update

  validates :first_name, length: { minimum: 2 }
  validates :last_name, length: { minimum: 2 }
  validates :organisation, length: { minimum: 2 }
  validates :postal_code, length: { minimum: 2 }
  validates :city, length: { minimum: 3 }
  validates :country, length: { minimum: 3 }
  validates :address, length: { minimum: 5 }

  validates :postal_code, numericality: {only_integer: true}
  validates :email,
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :telephone,
    format: { with: /\A((?![a-zA-Z]).){3,20}\z/ }, if: 'telephone.present?'

  mount_uploader :portrait, PortraitUploader

  validate :unique_email

  def unique_email
    if Participant.completed.map(&:email).include? email
      errors[:base] << 'Email bereits angemeldet!'
    end
  end

  def self.completed
    Participant.all.find_all { |p| p.complete }
  end

  def complete
    true unless [
      first_name,
      last_name,
      email,
      organisation,
      address,
      postal_code,
      city,
      country,
      accepted_data_storage,
      do_1330_workshop,
      fr_1015_workshop,
      do_opening,
      do_lunch,
      do_dinner,
      fr_lunch,
    ].include?(nil)
  end
end
