#ifndef WakBattle_Fight_h
#define WakBattle_Fight_h

#include <vector>
#include <string>
#include <Force.h>

class Fight {
public:
	Fight();
	Fight(const Fight& other);
	
	size_t size() const;
	Force& getForce(size_t i);
	const Force& getForce(size_t i) const;
	void addForce(const Force& force);
	
	std::string toString() const;
	
	std::vector<Force> forces;
};

#endif
