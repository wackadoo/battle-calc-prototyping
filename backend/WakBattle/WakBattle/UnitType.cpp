#include <UnitType.h>

#include <cassert>

UnitType::UnitType():
	name(""),
	damage(0.0),
	criticalDamage(0.0),
	criticalProbability(0.0),
	attackerBonusDamage(0.0),
	hitpoints(-1.0),
	defenderBonusHitpoints(0.0),
	unitClass(0),
	damageDistribution()
{
	assert(!valid());
}
UnitType::UnitType(
		 const std::string& name,
		 double damage,
		 double criticalDamage,
		 double criticalProbability,
		 double attackerBonusDamage,
		 
		 double hitpoints,
		 double defenderBonusHitpoints,
		 
		 const UnitClass* unitClass,
		 const std::map<const UnitClass*, double>& damageDistribution
) :
	name(name),
	damage(damage),
	criticalDamage(criticalDamage),
	criticalProbability(criticalProbability),
	attackerBonusDamage(attackerBonusDamage),
	hitpoints(hitpoints),
	defenderBonusHitpoints(defenderBonusHitpoints),
	unitClass(unitClass),
	damageDistribution(damageDistribution)
{
	assert(valid());
}

UnitType::UnitType(
		 const std::string& name,
		 double damage,
		 double criticalDamage,
		 double criticalProbability,
		 double attackerBonusDamage,
		 
		 double hitpoints,
		 double defenderBonusHitpoints,
		 
		 const UnitClass* unitClass
) :
	name(name),
	damage(damage),
	criticalDamage(criticalDamage),
	criticalProbability(criticalProbability),
	attackerBonusDamage(attackerBonusDamage),
	hitpoints(hitpoints),
	defenderBonusHitpoints(defenderBonusHitpoints),
	unitClass(unitClass),
	damageDistribution()
{
	assert(valid());
}

bool UnitType::valid() const {
	return (
		hitpoints > 0.0 &&
		unitClass != 0
	);
}
/*bool UnitType::containsAllClasses(const std::vector<UnitClass*> classes) const {
	std::vector<UnitClass*>::const_iterator it;
	for (it = classes.begin(); it != classes.end(); it++) {
		if (this->damageDistribution.find(*it) == this->damageDistribution.end()) {
			return false;
		}
	}
	return true;
}*/
bool UnitType::containsAllClasses(const std::vector<UnitClass::IdType>& classes) const {
	std::vector<UnitClass::IdType>::const_iterator it;
	for (it = classes.begin(); it != classes.end(); it++) {
		if (this->damageDistribution.find(*it) == this->damageDistribution.end()) {
			return false;
		}
	}
	return true;
}
void UnitType::setDamageDistribution(UnitClass::IdType type, double weight) {
	damageDistribution[type] = weight;
}
double UnitType::getDamageDistribution(UnitClass::IdType type) const {
	std::map<UnitClass::IdType, double>::const_iterator it = damageDistribution.find(type);
	if (it != damageDistribution.end()) return it->second;
	return 0.0;
}