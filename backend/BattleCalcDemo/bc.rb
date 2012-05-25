require 'sinatra'
require 'awe_native_extensions'
require 'haml'
require './rules'

def get_category_id(symb)
	@rules.unit_categories.each {
		|c|
		if (c[:symbolic_id] == symb)
			return c[:id]
		end
	}	
	raise "category not found"
end

def get_category_name(id)
	@rules.unit_categories.each {
		|c|
		if (c[:id] == id)
			return c[:name][:en_US]
		end
	}	
	raise "category not found"
end

def copy_battle(battle)
	result = Battle::Battle.new
	result.seed = battle.seed
	puts "categories:"
	(0...battle.numUnitCategories).each {
		|ci|
		category = Battle::UnitCategory.new(battle.getUnitCategory(ci).categoryId)
		category.test = battle.getUnitCategory(ci).test
		result.addUnitCategory(category)
	}
	(0...battle.numFactions).each {
		|fi|
		oldFaction = battle.getFaction(fi)
		faction = Battle::Faction.new
		result.addFaction(faction)
		(0...oldFaction.numArmies).each {
			|ai|
			oldArmy = oldFaction.getArmy(ai)
			army = Battle::Army.new(oldArmy.playerId)
			faction.addArmy(army)
			(0...oldArmy.numUnits).each {
				|ui|
				unit = oldArmy.getUnit(ui)
				puts unit.baseDamage
				unit_copy = Battle::Unit.new(unit)
				army.addUnit(unit_copy)
			}
		}
	}
	result
end

def reset_battle_vars(battle)
	(0...battle.numFactions).each {
		|fi|
		faction = battle.getFaction(fi)
		(0...faction.numArmies).each {
			|ai|
			army = faction.getArmy(ai)
			(0...army.numUnits).each {
				|ui|
				unit = army.getUnit(ui)

				unit.resetDamageLogs
				unit.numUnitsAtStart -= unit.numDeaths;
				unit.numDeaths = 0
				unit.numHits = 0
				unit.numKills = 0
				unit.newXp = 0
				unit.damageTaken = 0
				unit.damageInflicted = 0 
			}
		}
	}
end

def get_type_name(id)
	@rules.unit_types.each{
		|type|
		return type[:name][:en_US] if type[:id] == id
	} 
end

def parse_battle(params)
	#puts params
	params = {} if params.nil?
	battle = Battle::Battle.new
	#categories
	@rules.unit_categories.each {
		|c|
		category = Battle::UnitCategory.new(c[:id])

		if c[:target_priorities][:test_type] == :no_test
			test = Battle::NoTest.new
			c[:target_priorities][:results][0].each {
				|i|
				test.pushCategoryToPriority(i)
			}
			category.test = test
		elsif c[:target_priorities][:test_type] == :line_size_test
			test = Battle::LineSizeTest.new(c[:target_priorities][:test_category].to_i)
			c[:target_priorities][:results][0].each {
				|i|
				test.pushCategoryToPriorityOnSuccess(i)
			}
			c[:target_priorities][:results][1].each {
				|i|
				test.pushCategoryToPriorityOnFail(i)
			} 
			category.test = test
		else
			raise "unknown test"
		end
		battle.addUnitCategory(category)
	}
	

	#faction
	factions = [Battle::Faction.new, Battle::Faction.new]
	battle.addFaction(factions[0])
	battle.addFaction(factions[1])
	if (params["num_armies"].nil?)
		@armies = [[Battle::Army.new(0)],[Battle::Army.new(1)]]
		factions[0].addArmy(@armies[0][0])
		factions[1].addArmy(@armies[1][0])
		@units = [[{}],[{}]]
	else
		sum_ai = 0
		@armies = [[],[]]
		@units = [[],[]]
		(0...params["num_armies"]["0"].to_i).each {
			|ai|
			army = Battle::Army.new(sum_ai)
			@armies[0].push(army)
			factions[0].addArmy(army);
			@units[0].push({});
			sum_ai += 1
		}
		(0...params["num_armies"]["1"].to_i).each {
			|ai|
			army = Battle::Army.new(sum_ai)
			@armies[1].push(army)
			factions[1].addArmy(army);
			@units[1].push({});
			sum_ai += 1
		}
	end 

	#faction 1 army 1.1
	@rules.unit_types.each {
		|type|
		(0...@units.length).each{
			|fi|
			force = @units[fi]
			forceParams = {}
			forceParams = params[fi.to_s] unless params[fi.to_s].nil?
			#puts forceParams
			(0...force.length).each{
				|ai|
				army = force[ai]
				armyParams = {}
				#puts 
				armyParams = forceParams[ai.to_s] unless forceParams[ai.to_s].nil?
				unitsParams = {}
				#puts "type[id]"
				#puts type[:id]
				#puts "armyParams.nil?"
				#puts armyParams.nil?
				unitsParams = armyParams[type[:id].to_s] unless armyParams[type[:id].to_s].nil?
				#puts unitsParams
				unit = Battle::Unit.new
				#puts unit.methods

				army[type[:id]]  = unit
				unit.numUnitsAtStart = 0
				unit.numUnitsAtStart = unitsParams["numUnitsAtStart"].to_i unless unitsParams["numUnitsAtStart"].nil?

				unit.unitTypeId = type[:id]
				unit.unitCategoryId = type[:category]
				
				unit.baseDamage = type[:attack]
				unit.baseDamage = unitsParams["baseDamage"].to_f unless unitsParams["baseDamage"].nil?
				unit.criticalDamage = type[:critical_hit_damage]
				unit.criticalDamage = unitsParams["criticalDamage"].to_f unless unitsParams["criticalDamage"].nil?
				unit.criticalProbability = type[:critical_hit_chance]
				unit.criticalProbability = unitsParams["criticalProbability"].to_f unless unitsParams["criticalProbability"].nil?
				
				unit.initiative = type[:initiative]
				unit.initiative = unitsParams["initiative"].to_i unless unitsParams["initiative"].nil?

				#unit.effectiveness = type[:effectiveness]
				#unit.effectiveness = unitsParams["effectiveness"].to_i unless unitsParams["effectiveness"].nil?
				type[:effectiveness].each {
					|s,e|
					cat_id = get_category_id(s)
					unit.setEffectivenessFor(cat_id, e)
					if (!unitsParams["effectiveness"].nil? && !unitsParams["effectiveness"][cat_id.to_s].nil?) 
						unit.setEffectivenessFor(cat_id, unitsParams["effectiveness"][cat_id.to_s].to_f)
					end

				}

				unit.hitpoints = type[:hitpoints]
				unit.hitpoints = unitsParams["hitpoints"].to_f unless unitsParams["hitpoints"].nil?
				unit.armor = type[:armor]
				unit.armor = unitsParams["armor"].to_f unless unitsParams["armor"].nil?
				#unit.xpFactorPerSet = 1.0 #TODO not implemented in the XML

				@armies[fi][ai].addUnit(unit)
			}
		}
	}

	battle
end

def handle_request(params)
	GC.disable
	@rules = GameRules.the_rules
	battle = parse_battle(params["units"])
	puts "BATTLE VALID?"
	puts battle.isValid
	#puts @rules.unit_categories

	@num_rounds = 18
	@num_rounds = params["num_rounds"].to_i unless params["num_rounds"].nil?
	@rounds = []

	unless params["units"].nil?
		bc = Battle::BattleCalculator.new
		@rounds.push(battle)
		#puts @rounds
		(1..@num_rounds).each {
			|i|
			currBattle = copy_battle(@rounds[i-1])
			reset_battle_vars(currBattle)
			#currBattle.seed = rand(0..2147483646)
			bc.callculateOneTick(currBattle)
			@rounds.push(currBattle)
		}

	end

	GC.enable
	haml :index, :format => :html5
end

set :public_folder, File.dirname(__FILE__)

get '/' do
	handle_request(params)
end
post '/' do
	handle_request(params)
end
