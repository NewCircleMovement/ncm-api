require 'json'

namespace :seed do 

  task :data => :environment do

    tinkuy = Center.find_or_create_by(slug: 'tinkuy', name: 'tinkuy')
    fruit = Fruit.find_or_create_by(owner_id: tinkuy.id, owner_type: 'Epicenter')

    user1 = User.find_or_create_by(name: 'Egon Olsen')
    user1_fruit = Fruit.find_or_create_by(name: 'egons frugt', owner_id: user1.id, owner_type: 'Epicenter', monthly_decay: 0.1)

    user2 = User.find_or_create_by(name: 'Børge')
    user2_fruit = Fruit.find_or_create_by(name: 'Børges frugt', owner_id: user2.id, owner_type: 'Epicenter', monthly_decay: 0.05)

  end

end

namespace :test do

  task :this => :environment do

    user1 = User.find_by(:name => 'Egon Olsen')
    user2 = User.find_by(:name => 'Børge')

    user1.give_fruit_to(user2, user2.fruit.id, 500)
    
  end
end