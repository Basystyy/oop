module Manufacturer

  def manufacturer(name)
    self.manufacturer = name
  end

  def view_manufacturer
    self.manufacturer
  end

  protected
  attr_accessor :manufacturer

end