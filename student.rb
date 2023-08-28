require_relative 'person'

class Student < Person
  attr_reader :classroom

  def initialize(id, age, name, classroom)
    super(id, name, age)
    @classroom = classroom
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  def belongs_to?(classroom)
    @classroom = classroom
  end
end
