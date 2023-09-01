require 'json'
%w[book classroom nameable
   person rental student
   teacher].each { |file| require_relative file }

class App
  def initialize
    @all_students = []
    @all_teachers = []
    @all_books = []
    @all_rentals = []
    read_lists
  end

  def list_all_books(container = [])
    if container.empty?
      puts 'No books available'
    else
      banner('All available books')
      container.each do |book|
        puts "Title: #{book.title}, Author: #{book.author}"
      end
    end
  end

  def list_all_people(students, teachers)
    banner('All available people')
    if students.length.positive? || teachers.length.positive?
      students.each do |student|
        puts "[student] Name: #{student.name}, ID: #{student.id} ,Age: #{student.age}"
      end
      teachers.each do |teacher|
        puts "[Teacher] Name: #{teacher.name}, ID: #{teacher.id}, Age: #{teacher.age}"
      end
    else
      puts 'No person to display'
    end
  end

  def create_person
    banner('Create a person')
    print 'Do you want to create a student (1) or a teacher (2)? [input the number] >> '
    choice = gets.chomp.to_i
    case choice
    when 1
      create_student(@all_students)
    when 2
      create_teacher(@all_teachers)
    else
      puts 'Invalid input'
    end
  end

  def create_student(classroom)
    puts 'Create a student'
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Has parent permission? [y/n]'
    gets.chomp
    new_classroom = Classroom.new('Class A')
    student = Student.new(age, name, new_classroom.label)
    classroom.push(student)
    puts 'Person created successfully'
  end

  def create_teacher(classroom)
    puts 'Create a teacher'
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    spec = gets.chomp
    teacher = Teacher.new(age, name, spec)
    classroom.push(teacher)
    puts classroom
    puts 'Person created successfully'
  end

  def create_book(shelf)
    banner('Create a book')
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    puts book
    shelf.push(book)
    puts 'Book created successfully'
  end

  def create_rental(container, shelf, group)
    banner('Create a rental')
    if shelf.empty?
      puts 'No books to display'
    else
      puts 'Select a book from the following list by number '
      shelf.each_with_index { |book, i| puts "#{i}) Title: #{book.title}, Author: #{book.author} \n" }
      book_choice = gets.chomp.to_i
      selected_book = shelf[book_choice]
      puts 'Select a person from the following list by number (not id)'
      group.each_with_index { |person, i| puts "#{i}) Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" }
      person_choice = gets.chomp.to_i
      selected_person = group[person_choice]
      print 'Date: '
      date = gets.chomp
      rental = Rental.new(date, selected_book, selected_person)
      container.push(rental)
      puts 'Rental created successfully'
    end
  end

  def list_all_rentals(container)
    banner('All available rentals')
    if container.empty?
      puts 'No rentals available'
    else
      print 'ID of the person: '
      person_id = gets.chomp.to_i
      puts 'Rentals: '
      container.each do |rental|
        if rental.person.id == person_id
          puts "Date: #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}"
        end
      end
    end
  end

  def banner(title)
    puts ''.center(50, '*')
    puts '**' << ''.center(46) << '**'
    puts '**' << title.center(46) << '**'
    puts '**' << ''.center(46) << '**'
    puts ''.center(50, '*')
  end

  def save_json(file, list)
    puts list
    puts file
    json_data = list.map(&:to_hash).to_json
    File.write(file, json_data)
  end

  def save_lists
    save_json('books.json', @all_books)
    save_json('students.json', @all_students)
    save_json('teachers.json', @all_teachers)
    save_json('rentals.json', @all_rentals)
  end

  def read_lists
    read_books
    read_rentals
    read_students
    read_teachers
  end

  def read_students
    return unless File.exist?('students.json')

    json_file = File.read('students.json')
    @all_students = JSON.parse(json_file).map { |hash| Student.new(hash['date'], hash['book'], hash['person']) }
  end

  def read_teachers
    return unless File.exist?('teachers.json')

    json_file = File.read('teachers.json')
    @all_teachers = JSON.parse(json_file).map do |hash|
      Teacher.new(hash['age'], hash['name'], hash['specialization'])
    end
  end

  def read_books
    return unless File.exist?('books.json')

    json_file = File.read('books.json')
    @all_books = JSON.parse(json_file).map { |hash| Book.new(hash['title'], hash['author']) }
  end

  def read_rentals
    return unless File.exist?('rentals.json')

    json_file = File.read('rentals.json')
    @all_rentals = JSON.parse(json_file).map { |hash| Rental.new(hash['age'], hash['name'], hash['specialization']) }
  end

  def header
    banner('Welcome to SCHOOL LIBRARY App')
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books '
    puts '2 - List all people '
    puts '3 - Create a person '
    puts '4 - Create a book '
    puts '5 - Create a rental '
    puts '6 - List all rentals for a given person id '
    puts '7 - Exit '
  end

  def run(choice)
    case choice
    when 1 then list_all_books()
    when 2 then list_all_people(@all_students, @all_teachers)
    when 3 then create_person
    when 4 then create_book(@all_books)
    when 5 then create_rental(@all_rentals, @all_books, @all_students + @all_teachers)
    when 6 then list_all_rentals(@all_rentals)
    else puts 'Invalid entry'
    end
  end
end
