#ifndef WakBattle_UnitType_h
#define WakBattle_UnitType_h

#include <map>
#include <vector>
#include <string>
#include <UnitClass.h>

///A type of a unit.
class UnitType {
public:
	///Creates a unit that is not valid.
	///@note this is mainly so that containers of classes can be created.
	///@post !valid()
	UnitType();
	///Creates a UnitType.
	///@param name the name of the type
	///@param damage the amount of damage that this unit type deals per unit
	///@param criticalDamage the amount of extra damage that is beeing dealt by a unit if a critical hit happens
	///@param criticalProbability the probability for a unit of this type to execute a critical strike
	///@param attackerBonusDamage the additional amount of damage that a unit of this type deals if it is in an attacking force
	///@param hitpoints the amount of healthpoints that each unit of this type has
	///@param defenderBonusHitpoints the additional amount of hitpoints that a unit of this type gets if it is in a defending force
	///@param unitClass the class of this unit type
	///@param damageDistribution the distribution by which the damage is applied to the enemy units based on their class
	///@pre
	///@post valid()
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
	///Creates an UnitType that has no damage distribution.
	///@note If the unit should deal damage you have to add damageDistribution values afterwords. Otherwise there will be no damage dealt to anyone.
	///@post valid()
	///@param name the name of the type
	///@param damage the amount of damage that this unit type deals per unit
	///@param criticalDamage the amount of extra damage that is beeing dealt by a unit if a critical hit happens
	///@param criticalProbability the probability for a unit of this type to execute a critical strike
	///@param attackerBonusDamage the additional amount of damage that a unit of this type deals if it is in an attacking force
	///@param hitpoints the amount of healthpoints that each unit of this type has
	///@param defenderBonusHitpoints the additional amount of hitpoints that a unit of this type gets if it is in a defending force
	///@param unitClass the class of this unit type
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
	
	///Returns true if this UnitType has been correctly initialized, and hitpoints that are >0.0 und a class
	bool valid() const;
	
	///Returns true if this type of unit can damage all the given classes based on the damage distribution
	bool containsAllClasses(const std::vector<UnitClass::IdType>& classes) const;
	///Sets the damage distribution weight for the given UnitClass 
	void setDamageDistribution(UnitClass::IdType type, double weight);
	///Returns the damage distribution weight for the given UnitClass
	double getDamageDistribution(UnitClass::IdType type)const ;
	//bool containsAllClasses(const std::vector<UnitClass*> classes) const;
	
	///name the name of the type
	std::string name;
	
	///damage the amount of damage that this unit type deals per unit
	double damage;
	///criticalDamage the amount of extra damage that is beeing dealt by a unit if a critical hit happens
	double criticalDamage;
	///criticalProbability the probability for a unit of this type to execute a critical strike
	double criticalProbability;
	///attackerBonusDamage the additional amount of damage that a unit of this type deals if it is in an attacking force
	double attackerBonusDamage;
	
	///hitpoints the amount of healthpoints that each unit of this type has
	double hitpoints;
	///defenderBonusHitpoints the additional amount of hitpoints that a unit of this type gets if it is in a defending force
	double defenderBonusHitpoints;
	
	///unitClass the class of this unit type
	UnitClass::IdType unitClass;
	///damageDistribution the distribution by which the damage is applied to the enemy units based on their class
	std::map<UnitClass::IdType, double> damageDistribution;
	
};

#endif
