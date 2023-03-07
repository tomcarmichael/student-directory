students = [
  {name: "Dr. Hannibal Lecter", cohort: :novmeber},
  {name: "Darth Vader", cohort: :novmeber},
  {name: "Nurse Ratched", cohort: :novmeber},
  {name: "Michael Corleone", cohort: :novmeber},
  {name: "Alex DeLarge", cohort: :novmeber},
  {name: "The Wicked Witch of the West", cohort: :novmeber},
  {name: "Terminator", cohort: :novmeber},
  {name: "Freddy Krueger", cohort: :novmeber},
  {name: "The Joker", cohort: :novmeber},
  {name: "Joffrey Baratheon", cohort: :novmeber},
  {name: "Norman Bates", cohort: :novmeber},
  ]

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print(students)
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(names)
  puts "Overall, we have #{names.count} great students"
end

print_header
print(students)
print_footer(students)