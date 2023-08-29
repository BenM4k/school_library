require_relative 'person'

class Student < Person
  attr_accessor :classroom

  def initialize(name, age, classroom)
    super(name, age)
    @classroom = classroom
    # classroom.student.push(self) unless classroom.student.include?(self)
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  # def classroom=(classroom)
  #   @classroom = classroom
  #   classroom.student.push(self) unless classroom.student.include?(self)
  # end
end
