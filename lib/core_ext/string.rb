class String

  def is_integer?
    Integer(self) != nil rescue false
  end

  def is_float?
    Float(self) != nil rescue false
  end
  
end