# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 

## Kroner fruit
Fruit.new(:name => 'Kroner', :owner_type => 'Society').save(validate: false)

## NCM
ncm = Movement.new(:id => 0, :slug => 'new_circle_movement', :name => 'New Circle Movement')
ncm.save(validate: false)
ncm_fruit = ncm.create_fruit(:name => "Waterdrops", :monthly_decay => 0.1)
ncm.memberships.create(:name => "Engagement 1", :fee => 108, :gain => 108)
ncm.memberships.create(:name => "Engagement 2", :fee => 156, :gain => 216)
ncm.memberships.create(:name => "Engagement 3", :fee => 216, :gain => 216)

## Tinkuy
t = Tribe.find_or_create_by(:mother_id => 0, :slug => 'tinkuy', :name => 'Tinkuy')
t.create_fruit(:name => 'Blommer', :monthly_decay => 0.1)
t.memberships.create(:name => "Basis", :fee => 100, :gain => 100)
t.memberships.create(:name => "Komplet", :fee => 200, :gain => 200)

# create users

for user in users
    user_fruit = user.build_fruit
    user_fruit.name = "#{user.name}'s fruit"
    user_fruit.monthly_decay = 0.1
    user_fruit.save
    
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
  user.balances.create(:owner_id => ncm_fruit.owner.id, :owner_type => ncm_fruit.owner.type, :fruit_id => ncm_fruit.id, :amount => 300)
end

