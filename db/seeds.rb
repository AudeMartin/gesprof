require "json"
require "open-uri"
require 'faker'

# API to retrive all schools in 33 info except number of classes
url = "https://data.education.gouv.fr/api/records/1.0/search/?dataset=fr-en-annuaire-education&q=&rows=1500&facet=identifiant_de_l_etablissement&facet=nom_etablissement&facet=type_etablissement&facet=statut_public_prive&facet=code_postal&facet=code_commune&facet=nom_commune&facet=code_departement&facet=code_academie&facet=code_region&facet=ecole_maternelle&facet=ecole_elementaire&facet=voie_generale&facet=voie_technologique&facet=voie_professionnelle&facet=restauration&facet=hebergement&facet=ulis&facet=apprentissage&facet=segpa&facet=section_arts&facet=section_cinema&facet=section_theatre&facet=section_sport&facet=section_internationale&facet=section_europeenne&facet=lycee_agricole&facet=lycee_militaire&facet=lycee_des_metiers&facet=post_bac&facet=appartenance_education_prioritaire&facet=greta&facet=type_contrat_prive&facet=libelle_departement&facet=libelle_academie&facet=libelle_region&facet=nom_circonscription&facet=precision_localisation&facet=etat&facet=ministere_tutelle&facet=multi_uai&facet=rpi_concentre&facet=rpi_disperse&facet=code_nature&facet=libelle_nature&facet=code_type_contrat_prive&facet=pial&refine.type_etablissement=Ecole&refine.code_departement=033&refine.statut_public_prive=Public"
schools_serialized = URI.open(url).read
list = JSON.parse(schools_serialized)
@schools = list["records"]

# API to retrive all number of classes by school in 33
url2 = "https://data.education.gouv.fr/api/records/1.0/search/?dataset=fr-en-ecoles-effectifs-nb_classes&q=&sort=tri&facet=rentree_scolaire&facet=region_academique&facet=academie&facet=departement&facet=commune&facet=numero_ecole&facet=denomination_principale&facet=patronyme&facet=secteur&facet=rep&facet=rep_plus&facet=code_postal&refine.departement=GIRONDE&refine.rentree_scolaire=2021"
schools_serialized2 = URI.open(url2).read
list2 = JSON.parse(schools_serialized2)
@schools_classes = list2["records"]

# INITIAL SEEDING

# puts "deleting previous users"
# User.destroy_all
# puts "ended destroying users"

# puts "deleting previous areas"
# Area.destroy_all
# puts "ended destroying areas"

# DAILY SEEDING

# puts "deleting previous assignments"
# Assignment.destroy_all
# puts "ended destroying assignments"

# INITIAL SEEDING

# puts "deleting previous teachers"
# Teacher.destroy_all
# puts "ended destroying teachers"

# puts "deleting previous schools"
# School.destroy_all
# puts "ended destroying schools"

# puts "start seeding users"
# @schools.each do |school|
#   email = school["fields"]["mail"]
#   user = User.new(email: email, password: "secret", role: 2)
#   if user.valid?
#     user.save
#     puts "Seeding #{user.email}"
#   end
# end
# puts "finished seeding users"

# puts "start seeding areas"
# @schools.each do |school|
#   name = school["fields"]["nom_circonscription"]
#   user = User.create!(email: Faker::Internet.email, password: "secret", role: 1)
#   area = Area.new(name: name, user: user)
#   if area.valid?
#     area.save
#     puts "seeding #{area.name}"
#   else
#     user.destroy
#     area.destroy
#   end
# end
# puts "finished seeding areas"

# puts "start seeding schools"
# @schools.each do |school|
#   name = school["fields"]["nom_etablissement"]
#   address = "#{school['fields']['adresse_1']}, #{school['fields']['code_postal']} #{school['fields']['nom_commune']}"
#   lat = school["fields"]["latitude"]
#   long = school["fields"]["longitude"]
#   # retrive area
#   area_name = school["fields"]["nom_circonscription"]
#   area = Area.find_by(name: area_name)
#   # retrive user
#   email = school["fields"]["mail"]
#   if email
#     user = User.find_by(email: email.downcase)
#   else
#     user = User.create!(email: Faker::Internet.email, password: "secret", role: 2)
#   end
#   # retrieve nb_classes
#   reference = school["fields"]["identifiant_de_l_etablissement"]
#   @schools_classes.each do |el|
#     @classes_nb = el["fields"]["nombre_total_classes"].to_i if el["fields"]["numero_ecole"] == reference
#   end
#   class_nb = @classes_nb || (school["fields"]["nombre_d_eleves"].to_f / 27).round
#   new_school = School.create!(name: name, address: address, area: area, user: user, classes_number: class_nb, latitude: lat, longitude: long)
#   puts "seeding #{new_school.name}"
# end
# puts "finished seeding schools"

# DAILY SEEDING

# Assignment.where(date: Date.today).destroy_all
# puts "Destroyed assignments for today"

# @areas = Area.all
# @areas.each do |area|
#   # puts "Start seeding teachers for #{area.name}"
#   # 20.times do
#   #   name = Faker::Name.name
#   #   school = School.where(area: area).sample
#   #   email = Faker::Internet.email
#   #   phone_number = Faker::PhoneNumber.cell_phone_in_e164
#   #   Teacher.create!(name: name, school: school, email: email, phone_number: phone_number)
#   # end
#   # puts "Ended seeding teachers for #{area.name}"

#   puts "Start seeding assignments for #{area.name}"
#   rand(15..35).times do
#     school = School.where(area: area).sample
#     teacher_message = Faker::Lorem.paragraph(sentence_count: 2)
#     Assignment.create!(school: school, date: Date.today, teacher_message: teacher_message, area_message: teacher_message, progress: 1)
#   end
#   puts "Ended seeding assignments for #{area.name}"
# end

# seed test

# area = Area.find(26)
# start_date = Date.parse("05-09-2021")
# end_date = Date.parse("30-06-2022")
# (start_date..end_date).each_with_index do |date, index|
#   Assignment.where(date: date).destroy_all
#   puts "Destroyed assignments for #{date}"
#   if (index % 7 != 0) && (index % 6 != 0)
#     x = rand(15..35)
#     puts "Seed #{x} assignments for #{area.name} at #{date}"
#     if x <= 20
#       x.times do
#         school = School.where(area: area).sample
#         Assignment.create!(school: school, date: date, progress: 2)
#       end
#     else
#       20.times do
#         school = School.where(area: area).sample
#         Assignment.create!(school: school, date: date, progress: 2)
#       end
#       (x-20).times do
#         school = School.where(area: area).sample
#         Assignment.create!(school: school, date: date, progress: 3)
#       end
#     end
#     puts "Ended seed of #{x} assignments for #{area.name} at #{date}"
#   end
# end

# seed heroku

area = Area.find(7)
# start_date = Date.parse("05-09-2021")
# end_date = Date.parse("30-06-2022")
# (start_date..end_date).each_with_index do |date, index|
#   Assignment.where(date: date).destroy_all
#   puts "Destroyed assignments for #{date}"
#   if (index % 7 != 0) && (index % 6 != 0)
#     x = rand(15..35)
#     puts "Seed #{x} assignments for #{area.name} at #{date}"
#     if x <= 20
#       x.times do
#         school = School.where(area: area).sample
#         Assignment.create!(school: school, date: date, progress: 2)
#       end
#     else
#       20.times do
#         school = School.where(area: area).sample
#         Assignment.create!(school: school, date: date, progress: 2)
#       end
#       (x-20).times do
#         school = School.where(area: area).sample
#         Assignment.create!(school: school, date: date, progress: 3)
#       end
#     end
#     puts "Ended seed of #{x} assignments for #{area.name} at #{date}"
#   end
# end

sch = area.schools
sch.each do |s|
  s.teachers.destroy_all
end
puts "nb of teachers for #{area.name}: #{area.teachers.size} "
puts "Start seeding teachers for #{area.name}"
names = ["Anne-Cécile Mechin", "Baptiste Josse", "Benjamin Liet", "Charles Pernet", "Christopher Tavares", "Florent Braure", "Florian Carriere", "Humbert Monnot", "Jonathan Serafini", "Julie Raynal", "Kevin Abergel", "Madhi Lamriben", "Marc Delesalle", "Marc-Antoine Baguet", "Marceau Tassin", "Melanie Couronne", "Rayane Nordine", "Romain Jumeau", "Sylvain Galtier", "Valentine Ecrepont"]
names.each do |teacher|
    name = teacher
    school = School.where(area: area).sample
    email = "michaud.louis.lm@gmail.com"
    phone_number = Faker::PhoneNumber.cell_phone_in_e164
    Teacher.create!(name: name, school: school, email: email, phone_number: phone_number)
  end
  puts "Ended seeding teachers for #{area.name}"
puts "nb of teachers for #{area.name}: #{area.teachers.size} "
