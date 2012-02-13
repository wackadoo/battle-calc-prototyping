#include <BattleCalculator.h>

#include <set>
#include <cmath>
#include <cstdlib>
#include <cassert>
#include <util/Random.h>
#include <Damage.h>

#include <iostream>

BattleCalculator::BattleCalculator(double damageFactor) : damageFactor(damageFactor) {}

bool BattleCalculator::callculateOneTick(Fight& fight) const {
	return callculateOneTick(fight.forces);
}

bool BattleCalculator::callculateOneTick(std::vector<Force>& forces) const {
	//generate combined armies
	std::map<Force*,Army> combinedArmies;
	{
		std::vector<Force>::iterator it;
		for (it = forces.begin(); it != forces.end(); it++) {
			if (it->hasUnits()) {
				combinedArmies[&(*it)] = it->combinedArmy();
			}
		}
	}
	
	//Is there even a fight here
	if (combinedArmies.size() <= 1) {
		return true;
	}
	
	//callculate the damage for the forces
	std::cout<<"\tForces generated Damages:"<<std::endl;
	std::map<Force*, Damage> damage;
	{
		std::map<Force*, Army>::const_iterator it;
		for (it = combinedArmies.begin(); it != combinedArmies.end(); it++) {
			damage[it->first] = Damage(it->second, it->first->isAttacker, damageFactor);
			std::cout<<"\t\t"<<it->first<<" => "<<damage[it->first]<<std::endl;
		}
	}
	std::cout<<std::endl;
	
	//check if there is the possibility for damage
	bool damageLeft = false;
	{
		std::map<Force*, Damage>::const_iterator it;
		for (it = damage.begin(); it != damage.end(); it++) {
			std::map<Force*,Army>::const_iterator it2;
			for (it2 = combinedArmies.begin(); it2 != combinedArmies.end(); it2++) {
				if (it->first != it2->first && it->second.canDamage(it2->second)) {
					damageLeft = true;
					break;
				}
			}
			if (damageLeft) break;
		}
	}
	
	//if the armies cant damage each other the fight is over
	if (!damageLeft) return true;
	
	//start the loop that applies damage as long as it can apply the damage
	while (damageLeft) {
		
		//get the amount of enemy units per force
		size_t allUnitsNum = 0;
		std::map<Force*, size_t> armySize;
		{
			std::map<Force*, Army>::const_iterator it;
			for (it = combinedArmies.begin(); it != combinedArmies.end(); it++) {
				armySize[it->first] = it->second.getNumUnits();
				allUnitsNum += it->second.getNumUnits();
			}
		}
		
		//split the damage up between the enemy forces
		std::map<Force*, std::vector<std::pair<Force*, Damage> > > dmgDistribution; 
		{
			std::map<Force*, Damage>::const_iterator it;
			for (it = damage.begin(); it != damage.end(); it++) {
				dmgDistribution[it->first] = std::vector<std::pair<Force*, Damage> >();
			}
		}
		std::cout<<"\tSplitting up damage to enemy forces:"<<std::endl;
		{
			std::map<Force*, Damage>::const_iterator it;
			for (it = damage.begin(); it != damage.end(); it++) {
				size_t enemySize = allUnitsNum - armySize[it->first];
				{
					std::cout<<"\t\t"<<it->first<<" damage"<<std::endl;
					std::cout<<"\t\t\t"<<it->second<<std::endl;
					std::cout<<"\t\tsplit up to {"<<std::endl;
					std::map<Force*, size_t>::const_iterator itSize;
					for (itSize = armySize.begin(); itSize != armySize.end(); itSize++) {
						if (itSize->first != it->first) {
							//split the damage
							Damage d = it->second.split(double(armySize[itSize->first])/double(enemySize));
							dmgDistribution[itSize->first].push_back(std::pair<Force*,Damage>(it->first, d));
							std::cout<<"\t\t\t"<<itSize->first<<" => "<<d<<std::endl;
						}
					}
					std::cout<<"\t\t}"<<std::endl;
				}
			}
		}
		std::cout<<std::endl;
		//set damage to 0
		{
			std::map<Force*, Damage>::iterator it;
			for (it = damage.begin(); it != damage.end(); it++) {
				it->second.damage = 0.0;
			}
		}
		//apply the damage
		{
			std::map<Force*, std::vector<std::pair<Force*, Damage> > >::iterator it;
			for (it = dmgDistribution.begin(); it != dmgDistribution.end(); it++) {
				Army& army = combinedArmies[it->first];
				std::vector<std::pair<Force*, Damage> >::iterator it2;
				for (it2 = it->second.begin(); it2 != it->second.end(); it2++) {
					//apply damage
					Damage rest = it2->second.apply(army, it->first->isDefender);
					//write the rest back
					damage[it2->first].damage += rest.damage;
				}
			}
		}
		//check if there is still damage to deal
		damageLeft = false;
		{
			std::map<Force*, Damage>::const_iterator it;
			for (it = damage.begin(); it != damage.end(); it++) {
				std::map<Force*,Army>::const_iterator it2;
				for (it2 = combinedArmies.begin(); it2 != combinedArmies.end(); it2++) {
					if (it->first != it2->first && it->second.canDamage(it2->second)) {
						damageLeft = true;
						break;
					}
				}
				if (damageLeft) break;
			}
		}
	}
	
	//write back the lost units
	//--> per force
	//  --> unit type
	//   --> split to real armies
	{
		std::vector<Force>::iterator forceIt;
		for (forceIt = forces.begin(); forceIt != forces.end(); forceIt++) {
		
			Army oldCombinedArmy = forceIt->combinedArmy();
			Army& currentCombinedArmy = combinedArmies[&*forceIt];
			
			//iterate throught the types of units
			std::map<UnitType::IdType, size_t>::const_iterator unitIt;
			for (unitIt = oldCombinedArmy.numUnits.begin(); unitIt != oldCombinedArmy.numUnits.end(); unitIt++) {
			
				UnitType::IdType unitType = unitIt->first;
			
				size_t numOld = unitIt->second;
				size_t numNow = currentCombinedArmy.numUnits[unitType];
				assert(numOld >= numNow);
				
				//if there are units lost of this type split the losses up
				if (numNow < numOld) {
					size_t numLost = numOld - numNow;
					size_t numRemoved = 0;
					//iterate through armies and distribute the losses
					{
						std::vector<Army>::iterator armyIt;
						for (armyIt = forceIt->armies.begin(); armyIt != forceIt->armies.end(); armyIt++) {
							size_t armyNumOfType = armyIt->getNumUnits(unitType);
							if (armyNumOfType > 0) {
								double factor = double(armyNumOfType)/double(numOld);
								size_t armyNumLost = std::floor(double(numLost)*factor);
								assert(armyIt->numUnits[unitType] >= armyNumLost);
								numRemoved += armyNumLost;
								armyIt->numUnits[unitType] -= armyNumLost;
							}
						}
					}
					//randomly distribute the rest
					while (numRemoved < numLost) {
						//get a list of the armies that still have units of that type
						std::vector<Army*> armiesLeft;
						std::vector<Army>::iterator armyIt;
						for (armyIt = forceIt->armies.begin(); armyIt != forceIt->armies.end(); armyIt++) {
							if (armyIt->getNumUnits(unitType) > 0) {
								armiesLeft.push_back(&*armyIt);
							}
						}
						//draw a random army and remove a unit
						armiesLeft[BattleCalculator::random(0, armiesLeft.size()-1)]->numUnits[unitIt->first] -= 1;
						numRemoved++;
					}
				}
			}
		}
		
	}
	
	//check if there is still a fight here
	{
		//check if there are more than a force left here
		{
			size_t numActiveForces = 0;
			std::map<Force*, Army>::const_iterator it;
			for (it = combinedArmies.begin(); it != combinedArmies.end(); it++) {
				if (it->second.hasUnits()) numActiveForces++;
				if (numActiveForces > 1) break;
			}
			if (numActiveForces < 2) return true;
		}
		//calculate the damage for the next fighting round
		std::map<Force*, Army>::const_iterator it;
		for (it = combinedArmies.begin(); it != combinedArmies.end(); it++) {
			Damage d(it->second, it->first->isAttacker, damageFactor);
			std::map<Force*,Army>::const_iterator it2;
			for (it2 = combinedArmies.begin(); it2 != combinedArmies.end(); it2++) {
				if (it->first != it2->first && d.canDamage(it2->second)) return false;
			}
		}
		return true;
	}
}

double BattleCalculator::random() {
	return (double(rand()) / double(RAND_MAX));
}
bool BattleCalculator::random(double probability) {
	assert(probability >= 0.0 && probability <= 1.0);
	return (BattleCalculator::random()) < probability;
}
double BattleCalculator::random01(double probability) {
	return BattleCalculator::random(probability)?1.0:0.0;
}
size_t BattleCalculator::random(size_t start, size_t end) {
	assert(start <= end);
	return start + size_t(round(BattleCalculator::random()*(double(end-start))));
}
