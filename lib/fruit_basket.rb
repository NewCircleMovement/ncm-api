module FruitBasket
  
  def fruit_balance(fruit_id)
    balance = self.balances.find_by(:fruit_id => fruit_id)
    if balance
      return balance.amount
    end
    return 0
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
