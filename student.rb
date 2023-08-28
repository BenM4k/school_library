require_relative 'person'

class Student < Person
  def initialize(id, age, name, classroom)
    super(id, name, age)
    @classroom = classroom
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end
