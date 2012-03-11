#ifndef WakBattle_Army_h
#define WakBattle_Army_h

#include <UnitType.h>
#include <set>

///An army is a collection of units.
class Army {
public:
	///Creates an army that contains the given number of units of that type and a name.
	///@note the name of this army will be ""
	///@param name the name of the army
	///@param numUnits the map specifies what number of units of a certain type are present in the army.
	Army(const std::string& name, const std::map<UnitType::IdType, size_t>& numUnits);
	///Creates an army that contains the given number of units of that type.
	///@note the name of this army will be ""
	///@param numUnits the map specifies what number of units of a certain type are present in the army.
	Army(const std::map<UnitType::IdType, size_t>& numUnits);
	
	///Creates an army with no units and the given name
	///@param name the name of the army
	Army(const std::string& name);
	///Copyconstructor
	///@param army the army that is beeing copied
	Army(const Army& other);
	///Creates an empyt Army and
	Army();
	
	///Returns if there are more than 0 units in this army
	bool hasUnits() const;
	///Returns the number of units in this army
	///@return the number of units
	size_t getNumUnits() const;
	///Returns the number of units of the given type that are present in this army.
	///@param type the type of unit
	///@return the number of units of the type
	size_t getNumUnits(UnitType::IdType type) const;
	///Sets the number of units of the given type
	///@param type the type
	///@param num the number
	void setNumUnits(UnitType::IdType type, size_t num);
	///Returns true if there are more than 0 units of the given class in this army.
	///@param c the class
	///@return 
	bool hasUnits(UnitClass::IdType c) const;
	///Returns a list of number of units per UnitClass
	///@param re the resulting numbers of units per class
	void getNumberOfUnitsPerClass(std::map<UnitClass::IdType, size_t>& re) const;
	///Returns a list of all the UnitClasses that are present in this army
	///@param re the result
	void getClasses(std::set<UnitClass::IdType>& re) const;
	
	///The number of units in this army
	std::map<UnitType::IdType, size_t> numUnits;
	///The name of the army
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
