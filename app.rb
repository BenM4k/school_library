%w[book classroom nameable
   person rental student
   teacher].each { |file| require_relative file }

class App
  def initialize()
    @all_students = []
    @all_teachers = []
    @all_books = []
    @all_rentals = []
  end

  def list_all_books
    if @all_books.empty?
      puts 'No books available'
    else
      banner('All available books')
      @all_books.each do |book|
        puts "Title: #{book.title}, Author: #{book.author}"
      end
    end
  end

  def list_all_people
    banner('All available people')
    if @all_students.length.positive? || @all_teachers.length.positive?
      @all_students.each do |student|
        puts "[student] Name: #{student.name}, ID: #{student.id} ,Age: #{student.age}"
      end
      @all_teachers.each do |teacher|
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
      create_student
    when 2
      create_teacher
    else
      puts 'Invalid input'
    end
  end

  def create_student
    puts 'Create a student'
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Has parent permission? [y/n]'
    gets.chomp
    classroom = Classroom.new('Class A')
    student = Student.new(age, name, classroom.label)
    @all_students.push(student)
    puts 'Person created successfully'
  end

  def create_teacher
    puts 'Create a teacher'
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    spec = gets.chomp
    teacher = Teacher.new(age, name, spec)
    @all_teachers.push(teacher)
    puts 'Person created successfully'
  end

  def create_book
    banner('Create a book')
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    book = Book.new(title, author)
    puts book
    @all_books.push(book)
    puts 'Book created successfully'
  end

  def create_rental
    banner('Create a rental')
    if @all_books.empty?
      puts 'No books to display'
    else
      puts 'Select a book from the following list by number '
      @all_books.each_with_index { |book, i| puts "#{i}) Title: #{book.title}, Author: #{book.author} \n" }
      book_choice = gets.chomp.to_i
      selected_book = @all_books[book_choice]
      puts 'Select a person from the following list by number (not id)'
      persons = @all_students + @all_teachers
      persons.each_with_index { |person, i| puts "#{i}) Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" }
      person_choice = gets.chomp.to_i
      selected_person = persons[person_choice]
      print 'Date: '
      date = gets.chomp
      rental = Rental.new(date, selected_book, selected_person)
      @all_rentals.push(rental)
      puts 'Rental created successfully'
    end
  end

  def list_all_rentals
    banner('All available rentals')
    if @all_rentals.empty?
      puts 'No rentals available'
    else
      print 'ID of the person: '
      person_id = gets.chomp.to_i
      puts 'Rentals: '
      @all_rentals.each do |rental|
        if rental.person.id == person_id
          puts "Date: #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}"
        end
      end
    end
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

  def banner(title)
    puts ''.center(50, '*')
    puts '**' << ''.center(46) << '**'
    puts '**' << title.center(46) << '**'
    puts '**' << ''.center(46) << '**'
    puts ''.center(50, '*')
  end
end
