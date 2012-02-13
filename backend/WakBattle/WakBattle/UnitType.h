#ifndef WakBattle_UnitType_h
#define WakBattle_UnitType_h

#include <map>
#include <vector>
#include <string>
#include <UnitClass.h>

class UnitType {
public:
	UnitType();
	UnitType(
		const std::string& name,
		double damage,
		double criticalDamage,
		double criticalProbability,
		double attackerBonusDamage,
			 
		double hitpoints,
		double defenderBonusHitpoints,
			 
		UnitClass::IdType unitClass,
		const std::map<UnitClass::IdType, double>& damageDistribution
	);
	UnitType(
		const std::string& name,
		double damage,
		double criticalDamage,
		double criticalProbability,
		double attackerBonusDamage,
			 
		double hitpoints,
		double defenderBonusHitpoints,
			 
		UnitClass::IdType unitClass
	);
	
	typedef const UnitType* IdType;
	inline IdType getId() const { return this; }
	
	bool valid() const;
	bool containsAllClasses(const std::vector<UnitClass::IdType>& classes) const;
	void setDamageDistribution(UnitClass::IdType type, double weight);
	double getDamageDistribution(UnitClass::IdType type)const ;
	//bool containsAllClasses(const std::vector<UnitClass*> classes) const;
	
	std::string name;
	
	double damage;
	double criticalDamage;
	double criticalProbability;
	double attackerBonusDamage;
	
	double hitpoints;
	double defenderBonusHitpoints;
	
	UnitClass::IdType unitClass;
	std::map<UnitClass::IdType, double> damageDistribution;
	
};

#endif
