ORGANIZATIONS = [
  Faker::University.name,
  Faker::University.name,
  Faker::University.name,
  Faker::University.name,
]

12.times do
  Participant.create(
    sex: ['Herr', 'Frau'].sample,
    title: ['Dr.', 'Prof.', nil].sample,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    organisation: ORGANIZATIONS.sample,
    address: Faker::Address.street_address,
    postal_code: Faker::Address.zip,
    city: Faker::Address.city,
    country: Faker::Address.country,
    email: Faker::Internet.email,
    telephone: [nil, Faker::PhoneNumber.cell_phone].sample,
    accepted_data_storage: true,
  )
end
