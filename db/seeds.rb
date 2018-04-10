100.times do

  name = Faker::Name.name
  email = (Faker::Internet.email).downcase
  password = 'password'
  User.create!(name: name, email: email, password: password, password_confirmation: password)

end