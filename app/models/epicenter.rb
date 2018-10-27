class Epicenter < ActiveRecord::Base
    self.abstract_class = true

    include FruitBasket

    has_one :fruit, as: :owner, :dependent => :destroy
    has_many :balances, as: :holder
    has_many :transactions, as: :giver

    def type
        return self.class.name
    end
    

end
