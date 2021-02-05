module FruitBasket

  def get_balance(fruit_id)
    balance = self.balances.find_or_initialize_by(:fruit_id => fruit_id)
    if balance.new_record?
      fruit = Fruit.find(fruit_id)
      print fruit
      balance.owner_id = fruit.owner.nil? ? nil : fruit.owner.id
      balance.owner_type = fruit.owner.nil? ? 'Society' : fruit.owner.type
      balance.save
    end
    
    return balance
  end


  def get_fruit_amount(fruit_id)
    balance = self.get_balance(fruit_id)
    if balance
      return balance.amount
    end
    return 0
  end


  def given_fruit_amount(fruit_id, t_start=nil, t_end=nil)
    target = self.transactions.where(:giver_id => self.id, :giver_type => self.type, :fruit_id => fruit_id)
    final_target = limit_target(target, t_start, t_end)
    return final_target.map(&:amount).sum
  end

  
  def received_fruit_amount(fruit_id, t_start=nil, t_end=nil)
    target = Transaction.where(:receiver_id => self.id, :receiver_type => self.type, :fruit_id => fruit_id)
    final_target = limit_target(target, t_start, t_end)
    return final_target.map(&:amount).sum
  end


  def has_enough_fruit?(fruit_id, amount)
    return self.get_fruit_amount(fruit_id) >= amount
  end


  def limit_target(target, t_start=nil, t_end=nil)
    if t_start
      target = target.where('created_at >= ?', t_start)
    end

    if t_end
      target = target.where('created_at <= ?', t_end)
    end

    return target
  end


  ##
  # Gives fruit to receiving epicenter
  # Creates a transaction record, which updates the fruit balance for both giver and receiver
  def give_fruit_to(receiver, fruit_id, amount)
    return Transaction.make_fruit_transaction(
      fruit_id=fruit_id, amount=amount, 
      giver_id=self.id, giver_type=self.type,
      receiver_id=receiver.id, receiver_type=receiver.type
    )
  end

  

end

