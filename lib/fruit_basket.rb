module FruitBasket

  def has_enough_fruit?(fruit_id, amount)
    balance = self.fruit_balances.find_by(:fruit_id => fruit_id)
    if balance
      return balance.amount >= amount
    end

    return false
  end

end