99.times do
  name = Faker::Name.name
  email = (Faker::Internet.email).downcase
  password = 'password'
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end

users = User.order(:created_at).take(5)
50.times do 
	content = Faker::Lorem.sentence(5)
	users.each{|user| user.microposts.create!(content: content)}
end
