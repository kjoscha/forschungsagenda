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

  # before_create :overwrite_not_completed

  # validate :email_not_used_or_not_complete, on: :create

  def email_not_used_or_not_complete
    if Participant.completed.map(&:email).include? email
      errors[:email] << 'Error'
    end
  end

  def overwrite_not_completed
    existing_entry = Participant.find_by(email: email)
    existing_entry.delete if existing_entry && !existing_entry.complete
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

  def do_1330_workshop_name
    do_1330_workshops[do_1330_workshop]
  end

  def fr_1015_workshop_name
    fr_1015_workshops[fr_1015_workshop]
  end

  def do_1330_workshops
    {
      1 => 'Workshop I: Sektorenkopplung Energie & Verkehr',
      2 => 'Workshop II: Zusammenspiel von Logistik und Personenverkehr',
      3 => 'Workshop III: Smart Data – Digitale Präsenz und realer Raum',
      4 => 'Workshop IV: Formate und Methoden umsetzungsorientierter Forschung'
    }
  end

  def fr_1015_workshops
    {
      1 => 'Workshop I: Start-up meets Wissenschaft',
      2 => 'Workshop II: Internationale Perspektive zur Forschung im Bereich nachhaltiger Mobilität',
      3 => 'Workshop III: Weitere Agendaprozesse im Bereich Mobilität',
      4 => 'Workshop IV: Industrie 4.0 meets Mobilität 4.0: Wie 3D-Druck die Mobilität revolutioniert'
    }
  end
end
