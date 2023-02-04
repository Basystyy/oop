# frozen_string_literal: true

class Wagon
  include Manufacturer

  def initialize(some)
    @_some = some
  end
end
