@students = []

def input_student
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"

  months = ["January", "February", "March", "April", "May", "June",
  "July", "August", "September", "October", "November", "December"]

  name = STDIN.gets.chomp
  months.each_with_index { |month, index| puts "#{index + 1}. #{month}" }
  month_number = STDIN.gets.strip
  cohort = months[month_number.to_i - 1]

  while !name.empty? do
    students_insert(name, cohort)
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
    if !name.empty?
      puts "Enter cohort month number"
      month_number = STDIN.gets.chomp
      cohort = months[month_number.to_i - 1]
    end
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def show_student
  if @students.count > 0
    print_header
    print_student_list
    print_footer
  end
end

def save_students
  file = File.open("students.csv","w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def students_insert(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def load_students(filename = "students.csv")
  file = File.open(filename,"r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    students_insert(name, cohort)
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} students from #{filename}"
  else
    puts "Sorry #{filename} doesn't exist"
    exit
  end
end

def process(selection)
  case selection
    when "1"
      input_student
    when "2"
      show_student
    when "3"
      save_students
    when "4"
      load_students
    when "9"
      exit # exit program
    else
      puts "I didn't get that. Please try again."
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save list to student.csv"
  puts "4. Load list from student.csv"
  puts "9. Exit"
end

def interactive_menu
  try_load_students
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

interactive_menu
