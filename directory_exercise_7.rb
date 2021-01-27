# In the input_students method the cohort value is hard-coded. How can you ask for both the name and the cohort?
# What if one of the values is empty? Can you supply a default value?
# The input will be given to you as a string? How will you convert it to a symbol? What if the user makes a typo?
def input_student
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice times"

  students = []
  months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

  puts "Full Name or quit"
  name = gets.chop
  puts "Enter cohort month number"
  months.each_with_index { |month, index| puts "#{index + 1}. #{month}" }

  month_number = gets.strip
  cohort = months[month_number.to_i - 1]
  cohort = "TBC" if cohort.empty?

  while !name.empty? do
    students << {name: name.capitalize!, cohort: cohort.to_sym}
    if students.count == 1
      puts "Now we have #{students.count} student"
    else
      puts "Now we have #{students.count} students"
    end
    puts "Full Name or quit"
    name = gets.chomp
    if !name.empty?
      puts "Enter cohort month number"
      month_number = gets.chomp
      cohort = months[month_number.to_i - 1]
      if cohort.empty? then cohort = "TBC"
      end
    end
  end
  students
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------".center(32)
end

def print(students)
  puts "Enter a month to display cohort students"
  month = gets.strip
  students.map do |person|
    if person[:cohort] == month.capitalize.to_sym
      puts "#{person[:name]} (#{person[:cohort]} cohort)"
    end
  end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students"
end

students = input_student
print_header
print(students)
print_footer(students)
