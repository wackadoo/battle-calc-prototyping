require './bc'

infantry = Bc::UnitClass.new("infantry")
archer = Bc::UnitClass.new("archer")
cavalry = Bc::UnitClass.new("cavalry")

puts infantry.getName.to_s
puts infantry.getId
puts [infantry.getId => 0.45]

infantery1dmgdistr = {infantry.getId => 0.45, archer.getId => 0.1, cavalry.getId => 0.45 }
infantry1 = Bc::UnitType.new(
			"infantry1", #name
			15.0, #damage
			40.0, #criticalDamage
			0.0,  #criticalProbability
			10.0, #attackerBonusDamage
			40.0, #hitpoints
			10.0, #defenderBonusHitpoints 
			infantry.getId, #class
		)
infantry1.setDamageDistribution(infantry.getId, 0.45)
infantry1.setDamageDistribution(archer.getId, 0.1)
infantry1.setDamageDistribution(cavalry.getId, 0.45)

army1 = Bc::Army.new("army1")
army1.setNumUnits(infantry1.getId, 10)

force1 = Bc::Force.new
force1.addArmy(army1)

army2 = Bc::Army.new("army2")
army2.setNumUnits(infantry1.getId, 10)

force2 = Bc::Force.new
force2.addArmy(army2)

fight = Bc::Fight.new
fight.addForce(force1)
fight.addForce(force2)

bc = Bc::BattleCalculator.new(1.0)

fightDone = false

while !fightDone do
puts "before"
puts fight.toString
fightDone = bc.callculateOneTick(fight)
puts "after"
puts fight.toString
end
