#ifndef WakBattle_Damage_h
#define WakBattle_Damage_h

#include <map>
#include <Army.h>
#include <UnitClass.h>

///Damage is represented by the weighting by which it is distributed and the amount of damage
class Damage {
public:
	///A damage amount split and applied to classes
	class DistributedDamage {
	public:
		DistributedDamage(const Army& army, bool attacker, double damageFactor);
		DistributedDamage(const Damage& damage);
		DistributedDamage(const DistributedDamage& other);
		void apply(Army& army, bool isDefender);
		double damageSum() const;
		double getDamage(UnitClass::IdType classType) const;
		void add(const DistributedDamage& other);
		std::map<UnitClass::IdType, double> damage;
	};
	///Creates the damage that the given army can produce
	///@param army the army for which the damage is callculated
	///@param attacker if true the army has attacker bonus
	///@param damageFactor all damage values will be multiplied by this factor
	Damage(const Army& army, bool attacker, double damageFactor);
	///Copy constructor
	Damage(const Damage& damage);
	///Standard constructor
	///@note the damage values will not be initialized
	Damage();
	
	///Normalizes the weights
	void normalizeWeights();
	///Returns true if the damage == 0.0
	bool isNull() const;
	///Applies the damage to an army, after this the army looses units based on this damage
	Damage apply(Army& army, bool isDefender) const;
	///Returns a new damage whos damage value has been multiplied by the given factor
	///@param factor the factor
	///@return
	Damage split(double factor) const;
	///Returns true if it is possible, that this Damage can destory units in the given army (based on isNull, and the weighting) 
	bool canDamage(const Army& army) const;
	
	///The damage value
	double damage;
	///The weighting
	std::map<UnitClass::IdType, double> weight;
};	

template<class OStream>
OStream& operator<<(OStream& out, const Damage& damage) {
	out<<" Damage ( damage="<<damage.damage<<", weighting={ ";
	bool first = true;
    std::map<UnitClass::IdType, double>::const_iterator it;
	for (it = damage.weight.begin(); it != damage.weight.end(); it++) {
		out<<(first?"":", ")<<it->first->name<<" => "<<it->second;
		first = false;
	}
	out<<" } )";
    return out;
}

template<class OStream>
OStream& operator<<(OStream& out, const Damage::DistributedDamage& damage) {
	out<<" DistributedDamage ( ";
	bool first = true;
    std::map<UnitClass::IdType, double>::const_iterator it;
	for (it = damage.damage.begin(); it != damage.damage.end(); it++) {
		out<<(first?"":", ")<<it->first->name<<" => "<<it->second;
		first = false;
	}
	out<<" } )";
    return out;
}

#endif
