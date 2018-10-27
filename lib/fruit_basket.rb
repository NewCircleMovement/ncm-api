module FruitBasket
  
  def fruit_balance(fruit_id)
    balance = self.balances.find_by(:fruit_id => fruit_id)
    if balance
      return balance.amount
    end
    return 0
  end


  def can_apply?(epicenter, membership)
    # TODO: check if there is enought fruit and if supply is ok
    if epicenter.membership_fee_fruit.owner_id == nil
      return true
    else
      return self.has_enough_fruit?(epicenter.membership_fee_fruit, membership.fee)
    end
  end


  def has_enough_fruit?(fruit_id, amount)
    return self.fruit_balance(fruit_id) >= amount
  end


  def balance(fruit_id)
    balance = Balance.find_or_initialize_by(:holder_id => self.id, :holder_type => self.class.name, :fruit_id => fruit_id)
    if balance.new_record?
      fruit = Fruit.find(fruit_id)
      balance.owner_id = fruit.owner.id
      balance.owner_type = fruit.owner.type
      balance.save
    end
    return balance
  end

  # def balances
  #   return Balance.where(:holder_id => self.holder_id, :holder_type => self.class.name)
  # end


  def give_fruit_to(receiver, fruit_id, amount)
    transaction_record = {
      :giver_id => self.id, :giver_type => self.type,
      :receiver_id => receiver.id, :receiver_type => receiver.type,
      :fruit_id => fruit_id, :amount => amount
    }

    Transaction.create(transaction_record)
  end

end


transaction_record = {
      :giver_id => 1, :giver_type => "User",
      :receiver_id => 1, :receiver_type => "Tribe",
      :fruit_id => 2, :amount => 100
    }