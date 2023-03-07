def interactive_menu
  # create an empty array
  students = []
  loop do
    # 1. print the menu and ask the user what to do
    puts "1. Input the students"
    puts "2. Show the students"
    puts "9. Exit" # 9 because we'll be adding more items
    # 2. read the input and save it into a variable
    selection = gets.chomp
    # 3. do what the user has asked
    case selection
      when "1"
        students = input_students
        
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    puts "Enter cohort month"
    cohort = gets.delete("\n").to_sym
    cohort = :november if cohort.empty?
    students << {name: name, cohort: cohort}
    puts students.length == 1 ? "Now we have 1 student" : "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy".center(50)
  puts "-------------".center(50)
end

def print(students)
  grouped_students = students.group_by do |student| 
    student.delete(:cohort)
  end.transform_values do |names|
    names.map { |names| names[:name] }
  end
  grouped_students.each do |k, v|
    puts k.to_s + ":"
    puts v
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students".center(50)
end

students = input_students
print_header
print(students)
print_footer(students)