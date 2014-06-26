Fabricator(:category) do
  label { Faker::Lorem.words(5).join(" ") }
end