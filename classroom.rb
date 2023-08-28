class Classroom
  attr_accessor :label

  def initialize(label)
    @label = label
    @students = []
  end

  def many?(student)
    @students.push(student)
    student.belongs_to = self
  end
end
