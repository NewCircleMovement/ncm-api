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

  def give_fruit_to(receiver, fruit_id, amount)
    if receiver.class == Integer
      reciver = Epicenter.find(receiver_id)
    end

    transaction_record = {
      :giver_id => self.id, :giver_type => self.type,
      :receiver_id => receiver.id, :receiver_type => receiver.type,
      :fruit_id => fruit_id, :amount => amount
    }

    Transaction.create(transaction_record)
  end

end
