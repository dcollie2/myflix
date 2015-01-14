Fabricator(:user) do
  full_name { Faker::Name.name }
  email { Faker::Internet.safe_email }
  password { Faker::Internet.password }
end