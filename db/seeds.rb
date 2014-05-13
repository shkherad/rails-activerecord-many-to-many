hw = School.create(name: "Hogwarts")

ravenclaw = House.create(name: "Ravenclaw")
grifindor = House.create(name: "Grifindor")

hw.houses << ravenclaw << grifindor
# UPDATE house WHERE id = 1 VALUES school_id = 1
# UPDATE house WHERE id = 2 VALUES school_id = 1

harry = Student.create(name: "Harry Potter")
ron = Student.create(name: "Ron")

# Updates the records for harry and ron
grifindor.students << harry << ron

dark_arts = Course.create(name: "Defense against dark arts")
poisons = Course.create(name: "Poisons")

# Inserts into the Schedule table, not altering course or students
harry.courses << dark_arts << poisons

dark_arts.students << ron
poisons.students << ron

killing_curse = Spell.create(name: "Avada Kadava")

harry.spells << killing_curse
ron.spells << killing_curse
