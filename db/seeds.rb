DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

def sample_type 
  [:phones, :computer_laptop, :server, :thin_client, :router, :switch, 
   :printer_scanner_mfp, :internet_settings, :other_information].sample
end

User.create(name: "admin",  email: "admin@example.com",  password: "password", admin: true)
User.create(name: "Ivan",   email: "ivan@example.com",   password: "password")
User.create(name: "Stepan", email: "stepan@example.com", password: "password")

Company.create(name:        "Samsung",
               phone:       FFaker::PhoneNumber.phone_number,
               description: FFaker::Lorem.paragraphs)

10.times do
  company = Company.create(name:        FFaker::Company.name,
                           phone:       FFaker::PhoneNumber.phone_number,
                           description: FFaker::LoremUA.paragraph)
  company.contacts.create(name:    FFaker::NameUA.name,
                          phone:   FFaker::PhoneNumber.phone_number,
                          default: true)
  4.times do
    company.contacts.create(name:   FFaker::NameUA.name,
                            phone:  FFaker::PhoneNumber.phone_number)
  end
  10.times do
    company.apparats.create(name:         FFaker::Product.product,
                           product_type:  sample_type,
                           serial_number: FFaker::SSN.ssn,
                           ip_address:    FFaker::Internet.ip_v4_address,
                           description:   FFaker::LoremUA.paragraph)
  end
end

