class Epicenter < ActiveRecord::Base
  self.abstract_class = true

  include FruitBasket

  has_one :fruit, as: :owner, :dependent => :destroy
  
  has_many :balances, as: :holder
  has_many :transactions, as: :giver

  has_many :events, as: :owner
  has_many :memberships, as: :owner
  has_many :membershipcards, as: :owner, :dependent => :destroy
    

  def type
    return self.class.name
  end


  ##
  # Determins if an epicenter can apply for a membership
  # Everyone can apply to 'new circle movement' (fruit = kroner)
  # Otherwise we need to check if the user has enough of the relevant fruit
  #
  # @param [membership] to apply for
  #
  def can_apply_for?(membership)
    if membership.owner.mother_id == nil
      return true
    else
      fruit = membership.owner.membership_fee_fruit
      return self.has_enough_fruit?(fruit.id, membership.fee)
    end
  end


  ##
  # Gives an applicant a membership to an Epicenter
  # Upon successful fruit transaction (through FruitBasket) applicant receives a membershipcard for the membership
  #
  # @param [applicant] e.g. User, Tribe, Movement (applying for Epicenter membership)
  # @param [membership], the Epicenter membership in question
  #
  def give_membership_to(applicant, membership)
    applicant.give_fruit_to(self, self.membership_fee_fruit.id, membership.fee)
    card = applicant.membershipcards.find_or_initialize_by(:epicenter => self, :membership_id => membership.id)
    card.active = true
    if card.save
      return true
    else
      return false
    end
  end

    
  def membership_fee_fruit
    case self.class.name
    when "Movement"
      if self.mother == nil or self.mother == self
        return Fruit.find_by(:owner_id => nil, :owner_type => 'Society')
      else
        return self.mother.fruit
      end
    when "Tribe"
      return self.mother.fruit
    when "Event"
      return self.mother.fruit
    when "User"
      return Movement.find(0).fruit
    end
  end
          
    
end
