class Cargo_train < Train

  attr_reader :type
  
  def initialize(number)
    super
    @type = :cargo
  end

end