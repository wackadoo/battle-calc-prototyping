#ifndef WakBattle_BattleCalculator_h
#define WakBattle_BattleCalculator_h

#include <Force.h>
#include <Army.h>
#include <map>
#include <Fight.h>

class BattleCalculator {
public:
	BattleCalculator(double damageFactor);
	
	bool callculateOneTick(Fight& fight) const;
	///@param forces fighting forces
	///@return returns if the fight is over
	bool callculateOneTick(std::vector<Force>& forces) const;
	
	double damageFactor;
	
private:
	
	static double random();
	static bool random(double probability);
	static double random01(double probability);
	static size_t random(size_t start, size_t end);
};

#endif
