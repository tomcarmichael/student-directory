require "csv"
@students = [] # an empty array accessible to all methods

def interactive_menu
  loop do
    print_menu
    selection = STDIN.gets.chomp
    # do what the user has asked
    process(selection)
  end
end


def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to a file"
  puts "4. Load the list from a file"
  puts "9. Exit"
end


def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    puts "Enter a filename"
    filename = gets.chomp
    load_students(filename)
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end


def print_success_message
  puts "Success!"
end
  

def add_to_students_array(name, cohort="november")
  # Takes a name and a cohort month as strings
  cohort = cohort.delete("\n").to_sym
  @students << {name: name, cohort: cohort}
end


def load_students(filename="students.csv")
  if File.exist?(filename)
    # resets the array so we dont duplicate student data if we load more than once
    @students = []
    CSV.foreach(filename) do |row|
        name, cohort =row
        add_to_students_array(name, cohort)
    end
    print_success_message
  else
    puts "File not found"
  end
end


def load_students_on_startup
  filename = ARGV.first # first argument from the command line
  if filename.nil? # load students.csv if no filename given
    load_students
    puts "Loaded #{@students.count} from students.csv"
  elsif File.exist?(filename) # if a file of the given name exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist"
    exit
  end
end


def print_input_instructions
  puts "Please enter the names of the students, and their cohort month"
  puts "To finish, just hit return twice"
end


def print_students_length
  puts @students.length == 1 ? "Now we have 1 student" : "Now we have #{@students.count} students"
end

def input_students
  print_input_instructions
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    puts "Enter cohort month"
    cohort = STDIN.gets
    add_to_students_array(name, cohort)
    print_students_length
    # get another name from the user
    name = STDIN.gets.chomp
  end
end


def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end


def print_students_list
  @students.sort_by { |hash| hash[:cohort] }.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end


def print_footer
  puts "Overall, we have #{@students.count} great students".center(50)
end


def show_students
  print_header
  print_students_list
  print_footer
end
  
       
def save_students
  puts "Enter filename"
  filename = gets.chomp
  # open the file for writing
  file = File.open(filename, "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  print_success_message
end


load_students_on_startup
interactive_menu