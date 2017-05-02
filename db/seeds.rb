12.times do
  Participant.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    organisation: Faker::University.name,
    email: Faker::Internet.email,
    telephone: Faker::PhoneNumber.cell_phone
  )
end
