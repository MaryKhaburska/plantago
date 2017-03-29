# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# New database
DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

User.create(name: "admin", email: "admin@example.com", password: "password", role: :admin)
User.create(name: "expert", email: "expert@example.com", password: "password", role: :expert)
User.create(name: "newbie", email: "newbie@example.com", password: "password")

5.times do 
  User.create(name: FFaker::NameUA.name,
              email: FFaker::Internet.email,
              password: "password",
              current_sign_in_ip: FFaker::Internet.ip_v4_address)
end

10.times do
  Apparat.create(name: FFaker::BaconIpsum.word,
                 product_type: FFaker::BaconIpsum.word,
                 serial_number: FFaker::SSNSE.ssn,
                 company: FFaker::BaconIpsum.word,
                 contact: FFaker::BaconIpsum.word,
                 ip_address: FFaker::Internet.ip_v4_address,
                 description: FFaker::LoremUA.phrase)
end
