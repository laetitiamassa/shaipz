module Round

  def self.included(base)
    base.extend(ClassMethods)
  end

  def round_to_thousands (amount)
    (amount/1000).to_i * 1000
  end
end
