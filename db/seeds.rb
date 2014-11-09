# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


PeopleSubject.create!(first_name:  "John",
             last_name: "Doe",
             external_link:              "http://www.liacs.nl")

10.times do |n|
  first_name  = Faker::Name.name
  last_name  = Faker::Name.name
  external_link = "http://www.liacs.nl"  
  PeopleSubject.create!(first_name:  first_name,
               last_name: last_name,
               external_link: external_link)
end


people_subjects = PeopleSubject.order(:created_at).take(10)
5.times do
  content = Faker::Lorem.sentence(5)
  people_subjects.each { |people_subject| people_subject.people_comments.create!(content: content) }
end