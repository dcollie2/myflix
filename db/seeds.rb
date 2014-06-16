# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Categories
Category.create([{ label: 'Comedy'}, { label: 'Science Fiction'}, { label: 'Horrifying Unfunny Spoof'}])
3.times do
  Video.create(title: 'Family Guy', description: "This is a video about a guy.", small_cover_url: "family_guy.jpg", large_cover_url: "monk_large.jpg", category_id: 1)
  Video.create(title: 'Futurama', description: "This is a video about the future.", small_cover_url: "futurama.jpg", large_cover_url: "monk_large.jpg", category_id: 1)
  Video.create(title: 'Monk', description: "This is a video about a monk.", small_cover_url: "monk.jpg", large_cover_url: "monk_large.jpg", category_id: 2)
  Video.create(title: 'South Park', description: "This is a video about a park in the south.", small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg", category_id: 2)
  Video.create(title: 'Family Guy', description: "This is a video about a guy.", small_cover_url: "family_guy.jpg", large_cover_url: "monk_large.jpg", category_id: 2)
  Video.create(title: 'Futurama', description: "This is a video about the future.", small_cover_url: "futurama.jpg", large_cover_url: "monk_large.jpg", category_id: 3)
  Video.create(title: 'Monk', description: "This is a video about a monk.", small_cover_url: "monk.jpg", large_cover_url: "monk_large.jpg", category_id: 3)
  Video.create(title: 'South Park', description: "This is a video about a park in the south.", small_cover_url: "south_park.jpg", large_cover_url: "monk_large.jpg", category_id: 3)
  User.create([{ email: 'ralph@test.com', full_name: "Ralph Cramden", password: "test"}, { email: 'fred@test.com', full_name: "Fred Cramden", password: "test"}, { email: 'ed@test.com', full_name: "Ed Cramden", password: "test"}, ])
  3.times do
end