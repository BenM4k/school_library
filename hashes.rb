%w[book classroom
   person rental student
   teacher].each { |file| require_relative file }
require 'json'
class Hashes
  def hash_student(student)
    { name: student.age, age: student.name, id: student.id }
  end

  def hash_teacher(teacher)
    { name: teacher.name, age: teacher.age, specialization: teacher.specialization }
  end

  def hash_book(book)
    { title: book.title, author: book.author }
  end

  def hash_rental(rental)
    {
      date: rental.date,
      book_title: rental.book.title,
      book_author: rental.book.author,
      person_id: rental.person.id,
      person_name: rental.person.name
    }
  end
end

class Savers
  def save_student(file, list)
    json_data = list.map { |student| hash_student(student) }.to_json
    File.write(file, json_data)
  end

  def save_teacher(file, list)
    json_data = list.map { |teacher| hash_teacher(teacher) }.to_json
    File.write(file, json_data)
  end

  def save_book(file, list)
    json_data = list.map { |book| hash_book(book) }.to_json
    File.write(file, json_data)
  end

  def save_rental(file, list)
    json_data = list.map { |rental| hash_rental(rental) }.to_json
    File.write(file, json_data)
  end
end

class Readers
  def read_students(_students)
    return unless File.exist?('students.json')

    json_file = File.read('students.json')
    JSON.parse(json_file).map do |hash|
      student = Student.new(hash['name'], hash['age'], 'class A')
      student.id = hash['id']
      student
    end
  end

  def read_teachers(_teachers)
    return unless File.exist?('teachers.json')

    json_file = File.read('teachers.json')
    JSON.parse(json_file).map do |hash|
      Teacher.new(hash['age'], hash['name'], hash['specialization'])
    end
  end

  def read_books(shelf)
    if File.exist?('books.json')

      json_file = File.read('books.json')
      shelf = JSON.parse(json_file).map { |hash| Book.new(hash['title'], hash['author']) }
    end
    shelf
  end

  def read_rentals(rentals, group)
    puts group
    return unless File.exist?('rentals.json')

    json_file = File.read('rentals.json')
    rentals = JSON.parse(json_file).map do |hash|
      Book.new(hash['book_title'], hash['book_author'])
      current_person = nil
      group.each do |person|
        next unless person.name == hash['person_name']

        current_person = person
      end
      # Rental.new(hash['date'], book, current_person)
    end
    puts rentals
  end
end
