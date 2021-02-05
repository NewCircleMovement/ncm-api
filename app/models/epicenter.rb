class Epicenter < ActiveRecord::Base
  self.abstract_class = true

  include FruitBasket

  has_one :fruit, as: :owner, :dependent => :destroy
  
  has_many :balances, as: :holder
  has_many :transactions_given, class_name: "Transaction", as: :giver
  has_many :transactions_received, class_name: "Transaction", as: :receiver

  has_many :events, as: :owner
  has_many :memberships, as: :owner

  # epicenters can see which memberships they belong to through membershipcards
  has_many :membershipcards, as: :owner, :dependent => :destroy
  
  # epicenters can have subscribers to their memberships through "issued cards"
  # epicenters can view which membershipcards they have issued
  has_many :issued_cards, class_name: "Membershipcard", as: :epicenter, :dependent => :destroy
  has_many :movement_subscribers, through: :issued_cards, source: :owner, source_type: 'Movement'
  has_many :tribe_subscribers, through: :issued_cards, source: :owner, source_type: 'Tribe'
  has_many :user_subscribers, through: :issued_cards, source: :owner, source_type: 'User'

  # epicenters can subscribe to memberships of other epicenters
  has_many :subscriptions, :through => :membershipcards, :source => :membership
  has_many :movement_subscriptions, through: :membershipcards, source: :epicenter, source_type: 'Movement'
  has_many :tribe_subscriptions, through: :membershipcards, source: :epicenter, source_type: 'Tribe'
  has_many :user_subscriptions, through: :membershipcards, source: :epicenter, source_type: 'User'

  def type
    return self.class.name
  end

  def all_transactions
    transactions_given + transactions_received
  end

  def self.find_epicenter(epicenter_type, epicenter_id)
    return epicenter_type.classify.constantize.find(epicenter_id)
  end

  def has_membership?(membership)
    membershipcard = self.membershipcards.find_by(:membership_id => membership.id)
    return membershipcard.active rescue false
  end

  ## TRANSACTIONS AND BALANCES

  def get_balance(fruit_id)
    return balances.find_by(:fruit_id => @fruit_id)
  end

  ## MEMBERS

  def active_cards
    return self.issued_cares.where(active: true)
  end


  ##
  # Determins if an epicenter can apply for a membership
  # Everyone can apply to 'new circle movement' (fruit = kroner)
  # Otherwise we need to check if the user has enough of the relevant fruit
  #
  # @param [membership] to apply for
  #
  def can_apply_for?(membership)
    if membership.owner.mother_id == 1
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
    if applicant.has_membership?(membership)
      return true
    end

    if self.id == self.mother_id
      # TODO: this will require a successful money transaction
    else
      applicant.give_fruit_to(self, self.membership_fee_fruit.id, membership.fee)
    end
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
