require 'json'
require 'pry'
%w[book classroom hashes nameable
   person rental student
   teacher].each { |file| require_relative file }

class Listers
  def initialize
    @banner = Display.new
  end

  def list_all_books(container = [])
    if container.empty?
      puts 'No books available'
    else
      @banner.banner('All available books')
      container.each do |book|
        puts "Title: #{book.title}, Author: #{book.author}"
      end
    end
  end

  def list_all_people(students, teachers)
    @banner.banner('All available people')
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

  def list_all_rentals(container)
    @banner.banner('All available rentals')
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
end

class Library
  attr_accessor :books, :students, :teachers, :rentals

  def initialize
    @students = []
    @teachers = []
    @books = []
    @rentals = []
  end

  def read_lists
    hashes = Hashes.new
    @all_books = hashes.read_books(@all_books)
    @all_students = hashes.read_students(@all_students)
    @all_teachers = hashes.read_teachers(@all_teachers)
    # @all_rentals = hashes.read_rentals(@all_rentals, @all_students + @all_teachers)
  end

  def save_lists
    hashes = Hashes.new
    hashes.save_book('books.json', @all_books)
    hashes.save_student('students.json', @all_students)
    hashes.save_teacher('teachers.json', @all_teachers)
    hashes.save_rental('rentals.json', @all_rentals)
  end
end

class Display
  def banner(title)
    puts ''.center(50, '*')
    puts '**' << ''.center(46) << '**'
    puts '**' << title.center(46) << '**'
    puts '**' << ''.center(46) << '**'
    puts ''.center(50, '*')
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
end

class Create
  def initialize
    @banner = Display.new
  end

  def student?(classroom)
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

  def person?(students, teachers)
    @banner.banner('Create a person')
    print 'Do you want to create a student (1) or a teacher (2)? [input the number] >> '
    choice = gets.chomp.to_i
    case choice
    when 1
      student?(students)
    when 2
      teacher?(teachers)
    else
      puts 'Invalid input'
    end
  end

  def teacher?(classroom)
    puts 'Create a teacher'
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    spec = gets.chomp
    teacher = Teacher.new(age, name, spec)
    classroom.push(teacher)
    puts 'Person created successfully'
  end

  def book?(shelf)
    @banner.banner('Create a book')
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    shelf.push(book)
    puts 'Book created successfully'
  end

  def rental?(container, shelf, group)
    @banner.banner('Create a rental')
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
end

class App
  attr_accessor :library, :create, :lister
  def initialize
    @library = Library.new
    @create = Create.new
    @lister = Listers.new
  end

  def run(choice)
    case choice
    when 1 then lister.list_all_books(library.books)
    when 2 then lister.list_all_people(library.students, library.teachers)
    when 3 then create.person?(library.students, library.teachers)
    when 4 then create.book?(library.books)
    when 5 then create.rental(library.rentals, library.books, library.students + library.teachers)
    when 6 then lister.list_all_rentals(library.rentals)
    else puts 'Invalid entry'
    end
  end
end