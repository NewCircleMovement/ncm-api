require 'json'

namespace :seed do 

  task :data => :environment do

    puts "Create NewCircleMovement"
    mother = Movement.find_by(id: 1)
    if not mother
      mother = Movement.new(mother_id: 1, slug: 'new_circle_movement', name: 'New Circle Movement')
      mother.save(validate: false)
    end

    if not mother.fruit
      Fruit.find_or_create_by(owner_id: mother.id, owner_type: mother.class.name, name: 'Waterdrops', monthly_decay: 0.1)
    end

    if not mother.memberships.present?
      mother.memberships.find_or_create_by(name: "Engagement 1", fee: 108, gain: 108, rhythm: 'month')
      mother.memberships.find_or_create_by(name: "Engagement 2", fee: 156, gain: 156, rhythm: 'month')
      mother.memberships.find_or_create_by(name: "Engagement 3", fee: 216, gain: 216, rhythm: 'month')
    end

    puts "Create tinkuy Tribe"
    tinkuy = mother.tribes.find_or_create_by(slug: 'tinkuy', name: 'tinkuy')
    fruit = Fruit.find_or_create_by(owner_id: tinkuy.id, owner_type: 'Tribe', monthly_decay: 0.1)

    if not tinkuy.memberships.present?
      tinkuy.memberships.find_or_create_by(name: "Support", fee: 108, gain: 100, rhythm: 'month')
      tinkuy.memberships.find_or_create_by(name: "Basic", fee: 216, gain: 200, rhythm: 'month')
      tinkuy.memberships.find_or_create_by(name: "Complete", fee: 432, gain: 400, rhythm: 'month')
    end

    user1 = User.find_or_create_by(name: 'Egon Olsen')
    user1_fruit = Fruit.find_or_create_by(name: 'egons frugt', owner_id: user1.id, owner_type: 'Tribe', monthly_decay: 0.1)

    user2 = User.find_or_create_by(name: 'Børge')
    user2_fruit = Fruit.find_or_create_by(name: 'Børges frugt', owner_id: user2.id, owner_type: 'Tribe', monthly_decay: 0.05)

  end

end

namespace :test do

  task :this => :environment do

    user1 = User.find_by(:name => 'Egon Olsen')
    user2 = User.find_by(:name => 'Børge')

    user1.give_fruit_to(user2, user2.fruit.id, 500)
    
  end
end