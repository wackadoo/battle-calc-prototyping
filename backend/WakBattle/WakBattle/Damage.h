#ifndef WakBattle_Damage_h
#define WakBattle_Damage_h

#include <map>
#include <Army.h>
#include <UnitClass.h>

class Damage {
public:
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
	Damage(const Army& army, bool attacker, double damageFactor);
	Damage(const Damage& damage);
	Damage();
	
	void normalizeWeights();
	bool isNull() const;
	Damage apply(Army& army, bool isDefender) const;
	Damage split(double factor) const;
	//void add(const Damage& other);
	//void setAllDamageValues(double value);
	bool canDamage(const Army& army) const;
	
	double damage;
	//std::map<UnitClass::IdType, double> damage;
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
