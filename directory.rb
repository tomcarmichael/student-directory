@students = [] # an empty array accessible to all methods

def interactive_menu
  loop do
    print_menu
    selection = gets.chomp
    # 3. do what the user has asked
    process(selection)
  end
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
    load_students
  when "9"
    exit # this will cause the program to terminate
  else
    puts "I don't know what you meant, try again"
  end
end

def print_menu
  # 1. print the menu and ask the user what to do
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" # 9 because we'll be adding more items
  # 2. read the input and save it into a variable
end

def show_students
  print_header
  print_students_list
  print_footer
end
        
def input_students
  puts "Please enter the names of the students, and their cohort month"
  puts "To finish, just hit return twice"
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    puts "Enter cohort month"
    cohort = gets.delete("\n").to_sym
    cohort = :november if cohort.empty?
    @students << {name: name, cohort: cohort}
    puts @students.length == 1 ? "Now we have 1 student" : "Now we have #{@students.count} students"
    # get another name from the user
    name = gets.chomp
  end
end

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def print_students_list
  grouped_students = @students.group_by do |student| 
    student.delete(:cohort)
  end.transform_values do |names|
    names.map { |names| names[:name] }
  end
  grouped_students.each do |k, v|
    puts k.to_s + ":"
    puts v
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students".center(50)
end

interactive_menu

