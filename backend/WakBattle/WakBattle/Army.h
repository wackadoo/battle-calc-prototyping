#ifndef WakBattle_Army_h
#define WakBattle_Army_h

#include <UnitType.h>
#include <set>

class Army {
public:
	Army(const std::map<UnitType::IdType, size_t>& numUnits);
	Army(const Army& other);
	Army(const std::string& name);
	Army();
	
	bool hasUnits() const;
	size_t getNumUnits() const;
	size_t getNumUnits(UnitType::IdType type) const;
	void setNumUnits(UnitType::IdType type, size_t num);
	bool hasUnits(UnitClass::IdType c) const;
	void getNumberOfUnitsPerClass(std::map<UnitClass::IdType, size_t>& re) const;
	void getClasses(std::set<UnitClass::IdType>& re) const;
	
	void generateDamage(std::map<UnitType::IdType, double>& damage) const;
	
	std::map<UnitType::IdType, size_t> numUnits;
	std::string name;
};

template<class OStream>
OStream& operator<<(OStream& out, const Army& army) {
	out<<"Army name="<<army.name<<" ( ";
	bool first = true;
    std::map<UnitType::IdType, size_t>::const_iterator it;
	for (it = army.numUnits.begin(); it != army.numUnits.end(); it++) {
		out<<(first?"":", ")<<it->first->name<<"="<<it->second;
	}
	out<<" )";
    return out;
}

#endif
