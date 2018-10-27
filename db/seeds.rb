# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create new circle movement
Fruit.new(:name => 'Kroner', :owner_type => 'Society').save(validate: false)
Movement.new(:id => 0, :slug => 'new_circle_movement', :name => 'New Circle Movement').save(validate: false)

# create fruit and 2 memberships
m = Movement.first
fruit = m.create_fruit(:name => "Waterdrops", :monthly_decay => 0.1)
m.memberships.create(:name => "Engagement 1", :fee => 108, :gain => 108)
m.memberships.create(:name => "Engagement 2", :fee => 216, :gain => 216)

# create Tinkuy
t = Tribe.find_or_create_by(:mother_id => 0, :slug => 'tinkuy', :name => 'Tinkuy')
t.create_fruit(:name => 'Blommer', :monthly_decay => 0.1)
t.memberships.create(:name => "Basis", :fee => 100, :gain => 100)
t.memberships.create(:name => "Komplet", :fee => 200, :gain => 200)

# create users
users = User.create([{ name: 'Egon Olsen' }, { name: 'Benny'}, { name: 'Yvonne'}])
for user in users
    f = user.build_fruit
    f.name = "#{user.name}'s fruit"
    f.monthly_decay = 0.1
    f.save
    # user.mother_id = 0
    user.data = { prop1: 'Some property', prop2: 'Some other property'}
    user.save
end

# give some fruits to users
for user in users
  Fruit.where.not(:name => 'Kroner').map(&:id).sample(2).each do |f_id|
    f = Fruit.find(f_id)
    Balance.create([{ holder_id: user.id, holder_type: user.type, owner_id: f.owner.id, owner_type: f.owner.type, fruit_id: f_id, amount: 1000}])
  end
  user.balances.create(:owner_id => fruit.owner.id, :owner_type => fruit.owner.type, :fruit_id => fruit.id, :amount => 300)
end

