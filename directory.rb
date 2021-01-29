@students = []

MONTHS = ["January", "February", "March", "April", "May", "June",
"July", "August", "September", "October", "November", "December"]


def input_student
  puts "Please enter the names of the students and their cohort"
  puts "To finish, just hit return twice"

  MONTHS.each_with_index { |month, index| puts "#{index + 1}. #{month}" }

  name = STDIN.gets.chomp
  month_number = STDIN.gets.strip # using other method than `chomp`
  cohort = MONTHS[month_number.to_i - 1]

  while !name.empty? do
    students_insert(name, cohort) # refactored code to use a method - DRY
    puts "Now we have #{@students.count} students"
    name = STDIN.gets.chomp
    if !name.empty?
      puts "Enter cohort month number"
      month_number = STDIN.gets.chomp
      cohort = MONTHS[month_number.to_i - 1]
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
  puts "Enter a file name to save the current student list to"
  File.open(STDIN.gets.chomp,"w") do |file| # using a code block to access the file - no need to close file
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
    puts "The students list was saved to #{File.basename(file)}"
  end
end

def students_insert(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def load_students(filename = nil)
  if !filename.nil?
    file = File.open(filename,"r")
  else
    puts "Enter a file name to load"
    file = File.open(STDIN.gets.chomp,"r")
    puts "You are now in file #{File.basename(file)}"
  end
  @students.clear
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    students_insert(name, cohort)
  end
  file.close
end

def try_load_students
  filename = ARGV.first
  filename = "students.csv" if filename.nil?
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
  menu = ["1. Input the students", "2. Show the students", "3. Save list to file", "4. Load list from file", "9. Exit"]
  menu.each { |action| puts action }
end

def interactive_menu
  try_load_students
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

interactive_menu
