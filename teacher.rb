require_relative 'person'

class Teacher < Person
  def initialize(name, age, specialization)
    super(name, age)
    @specialization = specialization
  end

  def can_use_service?
    true
  end
end
