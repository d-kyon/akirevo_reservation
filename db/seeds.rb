# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def create_seminar(hash)
  seminar = Seminar.new(hash)
  # member.skip_confirmation!
  seminar.save
end

for i in 1..30 do
  date1=Time.local(2019,6,i,7,0,0,0).to_s
  date2=Time.local(2019,6,i,15,30,0,0).to_s
  create_seminar({title: '初回無料講座', date: date1, address: 'ラトゥール会議室', max: 2})
  create_seminar({title: '初回無料講座', date: date2, address: 'ラトゥール会議室', max: 2})
end
