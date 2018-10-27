# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Movement.find_or_create_by(:id => 0, :slug => 'new_circle_movement', :name => 'New Circle Movement')

Tribe.find_or_create_by(:slug => 'tinkuy', :name => 'Tinkuy')

users = User.create([{ name: 'Egon Olsen' }, { name: 'Benny'}, { name: 'Yvonne'}])

for user in users
    f = user.build_fruit
    f.name = "#{user.name}'s fruit"
    f.monthly_decay = 0.1
    f.save
    user.data = { prop1: 'Some property', prop2: 'Some other property'}
    user.save
end

for user in users
  Fruit.all.map(&:id).sample(2).each do |f_id|
    f = Fruit.find(f_id)
    Balance.create([{ holder_id: user.id, holder_type: user.type, owner_id: f.owner.id, owner_type: f.owner.type, fruit_id: f_id, amount: 1000}])
  end
end

