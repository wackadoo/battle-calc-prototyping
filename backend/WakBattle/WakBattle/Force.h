#ifndef WakBattle_Force_h
#define WakBattle_Force_h

#include <vector>
#include <string>
#include <Army.h>

///A force is a list of armies of players that are allied.
class Force {
public:
	///Creates an force an empty force.
	///The resulting force is not an an attacker or defender.
	Force();
	///Copyconstructor
	///@param force the force that is beeing copied
	Force(const Force& force);
	///Constructor
	///@param armies the armies that are in the force. This vector will be copied
	///@param isDefender marks if the armies in this force gets defending modifiers during a fight
	///@param isAttacker marks if the armies in this force gets attacking modifiers during a fight
	Force(const std::vector<Army>& armies, bool isDefender, bool isAttacker);
	
	///Returns an army that contains all the units of the armies of this force
	///@return the combined army
	Army combinedArmy() const;
	///Returns if the force contains units.
	///@return true if there are armies present that still have units
	bool hasUnits() const;
	
	///Returns the number of armies that are members of this force.
	///@note this is for swing
	///@return the number of armies
	size_t numArmies() const;
	///Returns a reference to the army at the i-th position.
	///@note this is for swing
	///@param i the position
	///@return reference to the army
	Army& getArmy(size_t i);
	///Returns a const reference to the army at the i-th position.
	///@note this method is for swing
	///@param i the position
	///@return const reference to the army
	const Army& getArmy(size_t i) const;
	///Adds an army to the force
	///@note this method is for swing 
	///@param army the army that will be added.
	void addArmy(const Army& army);
	
	
	std::string toString() const;
	
	///The armies of this force
	std::vector<Army> armies;
	///Specifies if the force is currently a defender and gets defender modifiers during a fight.
	bool isDefender;
	///Specifies if the force is currently an attacker and gets attacker modifiers during a fight.
	bool isAttacker;
};

template<class OStream>
OStream& operator<<(OStream& out, const Force& force) {
	out<<"Force { ";
	bool first = true;
    std::vector<Army>::const_iterator it;
	for (it = force.armies.begin(); it != force.armies.end(); it++) {
		out<<(first?"":", ")<<(*it);
		first = false;
	}
	out<<" }";
    return out;
}

#endif
