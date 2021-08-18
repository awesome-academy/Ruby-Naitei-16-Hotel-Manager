if User.count.zero?
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
end

# Generate rooms
max = Settings.seed.room_types.max
max.times do |n|
  rand = Random.rand(max)
  rooms = []
  rand.times do |m|
    rooms << {room_number: "#{n+1}0#{m+1}", description: Settings.seed.lorem}
  end

  room_type = RoomType.create!(
    name: Settings.seed.room_types.name[n],
    cost: 100.0*(n+1),
    bed_num: n+1,
    air_conditioner: rand(2) > 0,
    description: Settings.seed.room_types.description[n],
    rooms_attributes: rooms
  )

  rand.times do |m|
    room_type.images.attach(
      io: File.open(Rails.root.join(Settings.src.assets_path + Settings.seed.room_types.image[m])),
      filename: Settings.seed.room_types.image[m]
    )
  end
end
