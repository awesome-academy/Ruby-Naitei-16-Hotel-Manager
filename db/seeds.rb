# Create a main sample user.
User.create!(name: Settings.user.admin.name,
             email: Settings.user.admin.email,
             password: Settings.user.admin.password,
             password_confirmation: Settings.user.admin.password,
             role: 1,
             activated: true,
             activated_at: Time.zone.now)

# Generate a bunch of additional staffs.
10.times do |n|
  name = Faker::Name.name
  email = "staff-#{n+1}@railstutorial.org"
  User.create!(name: name,
               email: email,
               password: Settings.user.faker.password,
               password_confirmation: Settings.user.faker.password,
               role: 0,
               activated: true,
               activated_at: Time.zone.now)
end

# Generate a bunch of additional customers.
10.times do |n|
  name = Faker::Name.name
  email = "customer-#{n+1}@railstutorial.org"
  User.create!(name: name,
               email: email,
               password: Settings.user.faker.password,
               password_confirmation: Settings.user.faker.password,
               role: -1,
               activated: true,
               activated_at: Time.zone.now)
end
