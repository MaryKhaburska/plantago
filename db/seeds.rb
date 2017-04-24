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

User.create(name: "admin", email: "admin@example.com", password: "password", admin: true)
User.create(name: "Ivan", email: "ivan@example.com", password: "password")
# User.create(name: "Stepan", email: "stepan@example.com", password: "password")

Company.create(name: "Samsung")
# Company.create(name: "LG")
# Company.create(name: "Goldstar")
# Company.create(name: "Saturn")

Apparat.create(name: "main server", ip_address: "192.168.0.2", company_id: 1, description: "belongs to Samsung")
Apparat.create(name: "usual comp", ip_address: "192.168.0.111",  company_id: 1, description: "belongs to Samsung")

# Apparat.create(name: "main server", ip_address: "192.168.0.2",  company_id: 2, description: "belongs to LG")
# Apparat.create(name: "ussual comp", ip_address: "192.168.0.111",  company_id: 2, description: "belongs to LG")

# Apparat.create(name: "main server", ip_address: "192.168.0.1",  company_id: 3, description: "belongs to Goldstar")
# Apparat.create(name: "usual comp", ip_address: "192.168.0.111",  company_id: 3, description: "belongs to Goldstar")

# Apparat.create(name: "main server", ip_address: "192.168.0.1",  company_id: 4, description: "belongs to Saturn")
# Apparat.create(name: "usual comp", ip_address: "192.168.0.111",  company_id: 4, description: "belongs to Saturn")

# Add different permissions for use-apparat and user-company
# Ivan = User.find_by(name: "Ivan")
# Stepan = User.find_by(name: "Stepan")

# Ivan.apparats_permits.create(apparat_id: 1)
# Ivan.apparats_permits.create(apparat_id: 3)
# Ivan.apparats_permits.create(apparat_id: 5)
# Ivan.companies_permits.create(company_id: 2)
# Ivan.companies_permits.create(company_id: 4)

# Stepan.apparats_permits.create(apparat_id: 2, role: "expert")
# Stepan.apparats_permits.create(apparat_id: 4, role: "expert")
# Stepan.apparats_permits.create(apparat_id: 6, role: "expert")
# Stepan.companies_permits.create(company_id: 1, role: "expert")
# Stepan.companies_permits.create(company_id: 3, role: "expert")
