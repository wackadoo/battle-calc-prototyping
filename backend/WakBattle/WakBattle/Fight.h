#ifndef WakBattle_Fight_h
#define WakBattle_Fight_h

#include <vector>
#include <string>
#include <Force.h>

///Represents a fight in which multple forces are fighting
///@note this is mainly for swig
class Fight {
public:
	Fight();
	Fight(const Fight& other);
	
	size_t size() const;
	Force& getForce(size_t i);
	const Force& getForce(size_t i) const;
	void addForce(const Force& force);
	
	std::string toString() const;
	
	///The forces that are fighting
	std::vector<Force> forces;
};

#endif
