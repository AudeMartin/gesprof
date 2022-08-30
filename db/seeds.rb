

Assignment.destroy_all
Teacher.destroy_all
School.destroy_all
Area.destroy_all
User.destroy_all


# Managers
puts "********Start seeding Manager*********************"
puts "----Create a new manager"
new_manager = User.new(
  email: Faker::Internet.email,
  password: 'secret',
  role: 1
)
puts "-----Store new manager => #{new_manager.email}----"
new_manager.save!
puts "********Ending seeding Manager********************"
puts "================================================================================="

# Area
puts "*****************Start seeding areas****************"
puts "----Create new area----"
new_area = Area.new(
  name:'bordeaux',
  user_id: new_manager.id
)
puts "----Store new area => #{new_area.name}----"
new_area.save!
puts "*********Ending seeding area:#{new_area.name}************"

puts "================================================================================="

# Schools credentials
puts "********Start seeding schools credentials*********"
10.times do
  puts "----Create a new user----"
  new_user = User.new(
    email: Faker::Internet.email,
    password: 'secret',
    role: 2
  )
  puts "-----Store new user => #{new_user.email}----"
  new_user.save!

  # School info
  puts "----Create a new school----"
  new_school = School.new(
    name:Faker::Company.name,
    address:Faker::Address.full_address,
    classes_number: rand(5..20),
    user_id: new_user.id,
    area_id: new_area.id
  )
  puts "----Store new school => #{new_school.name} to director:#{new_user.email}----"
  new_school.save!
end
puts "*********Ending seeding schools credentials*********"
puts "================================================================================="

# Teachers
puts "********Start seeding teachers*********"
30.times do
  puts "----Create a new teacher----"
  new_teacher = Teacher.new(
    name: Faker::Internet.username,
    school_id: School.all.sample.id,
    email: Faker::Internet.email,
    phone_number:Faker::PhoneNumber.phone_number_with_country_code
  )
  puts "-----Store new teacher => #{new_teacher.name}----"
  new_teacher.save!
end

# Assignments
puts "********Start seeding Assignments*********"
20.times do
  new_assignment = Assignment.new(
    school_id: School.all.sample.id,
    date: Date.today,
    teacher_id: Teacher.all.sample.id,
    teacher_message: Faker::Marketing.buzzwords,
    area_message: Faker::Marketing.buzzwords,
    progress: rand(1..4)
  )
  puts "-----Store new assignment => #{new_assignment}----"
  new_assignment.save!
end

puts "$$$$$$$$$$$$$$----Seed successfully donne----$$$$$$$$$$$$$"
