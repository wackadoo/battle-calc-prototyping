#ifndef WakBattle_BattleCalculator_h
#define WakBattle_BattleCalculator_h

#include <Force.h>
#include <Army.h>
#include <map>
#include <Fight.h>

///Class to callculate a Fight.
class BattleCalculator {
public:
	///Creates a BattleCalculator.
	///@param damageFactor all the damageValues during a fight will be multiplied by this factor
	BattleCalculator(double damageFactor = 1.0);
	
	///Callculate one tick of a fight
	///@param fight the fight
	///@return returns true if the fight is over
	bool callculateOneTick(Fight& fight) const;
	///Callculate one tick of a fight
	///@param forces fighting forces
	///@return returns true if the fight is over
	bool callculateOneTick(std::vector<Force>& forces) const;
	
	///All the damageValues during a fight will be multiplied by this factor.
	///This helps to control the number of ticks needed until a fight is over (bigger = faster, smaller = slower).
	double damageFactor;
	
private:
	
	static double random();
	static bool random(double probability);
	static double random01(double probability);
	static size_t random(size_t start, size_t end);
};

#endif
