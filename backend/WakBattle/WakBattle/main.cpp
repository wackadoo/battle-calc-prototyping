#include <iostream>
#include <BattleCalculator.h>

int main (int argc, const char * argv[])
{
	using namespace std;
	map<string, UnitClass> classes;
	classes["infantry"] = UnitClass("infantry");
	classes["archer"] = UnitClass("archer");
	classes["cavalry"] = UnitClass("cavalry");
	
	map<string, UnitType> types;
	{
		std::map<UnitClass::IdType, double> damageDistribution;
		damageDistribution[classes["infantry"].getId()] = 0.45;
		damageDistribution[classes["archer"].getId()] = 0.1;
		damageDistribution[classes["cavalry"].getId()] = 0.45;
		
		types[string("infantry1")] = UnitType(
			string("infantry1"), 
			15.0, //damage
			40.0, //criticalDamage
			0.0, //criticalProbability
			10.0, //attackerBonusDamage
			40.0, //hitpoints
			10.0, //defenderBonusHitpoints 
			&(classes["infantry"]), //class
			damageDistribution
		); //damage Distribution
	}
	
	
	BattleCalculator bc(1.0);
	
	std::vector<Force> forces;
	{
		std::vector<Army> armies;
		{
			Army army = Army(std::map<UnitType::IdType, size_t>());
			army.numUnits[types[string("infantry1")].getId()] = 10;
			armies.push_back(army);
		}
		forces.push_back(
			Force(
				armies, //armies
				false,  //isDefender
				false   //isAttacker
			)
		);
	}
	{
		std::vector<Army> armies;
		{
			Army army = Army(std::map<UnitType::IdType, size_t>());
			army.numUnits[types[string("infantry1")].getId()] = 10;
			armies.push_back(army);
		}
		forces.push_back(
			Force(
				armies, //armies
				false,  //isDefender
				false   //isAttacker
			)
		);
	}
	bool fightDone = false;
	while(!fightDone) {
		cout<<"Before: "<<endl;
		{
			std::vector<Force>::const_iterator it;
			for (it = forces.begin(); it != forces.end(); it++) {
				cout<<"\t"<<(&*it)<<" "<<(*it)<<std::endl;
			}
		}
		cout<<endl;
		cout<<"Calculation:"<<std::endl;
		fightDone = bc.callculateOneTick(forces);
		
		
		cout<<"After: "<<endl;
		{
			std::vector<Force>::const_iterator it;
			for (it = forces.begin(); it != forces.end(); it++) {
				cout<<"\t"<<(&*it)<<" "<<(*it)<<std::endl;
			}
		}
	}
	
    return 0;
}

