require 'json'

class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def to_hash
    { name: @name, age: @age }
  end
end

class App
  def initialize
    @people = []
    load_people_from_file
  end

  def run
    loop do
      puts "Options:"
      puts "1. Add Person"
      puts "2. List People"
      puts "3. Exit"
      print "Enter your choice: "
      choice = gets.chomp.to_i

      case choice
      when 1
        add_person
      when 2
        list_people
      when 3
        save_people_to_file
        break
      else
        puts "Invalid choice"
      end
    end
  end

  private

  def add_person
    print "Enter name: "
    name = gets.chomp
    print "Enter age: "
    age = gets.chomp.to_i

    person = Person.new(name, age)
    @people << person
    puts "Person added!"
  end

  def list_people
    puts "People List:"
    @people.each_with_index do |person, index|
      puts "#{index + 1}. Name: #{person.name}, Age: #{person.age}"
    end
  end

  def load_people_from_file
    if File.exist?('people.json')
      json_data = File.read('people.json')
      @people = JSON.parse(json_data).map { |hash| Person.new(hash['name'], hash['age']) }
    end
  end

  def save_people_to_file
    puts @people
    json_data = @people.map(&:to_hash).to_json
    File.write('people.json', json_data)
  end
end

app = App.new
app.run
