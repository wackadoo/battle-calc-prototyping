#ifndef WakBattle_Force_h
#define WakBattle_Force_h

#include <vector>
#include <string>
#include <Army.h>

class Force {
public:
	Force();
	Force(const Force& force);
	Force(const std::vector<Army>& armies, bool isDefender, bool isAttacker);
	
	Army combinedArmy() const;
	bool hasUnits() const;
	
	size_t numArmies() const;
	Army& getArmy(size_t i);
	const Army& getArmy(size_t i) const;
	void addArmy(const Army& army);
	
	std::string toString() const;
	
	std::vector<Army> armies;
	bool isDefender;
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
