#ifndef WakBattle_BattleLog_h
#define WakBattle_BattleLog_h

#include <map>
#include <Force.h>

class BattleLog {
public:
	class UnitsKilled {
	public:
		UnitsKilled();
		std::map<UnitType::IdType, size_t> unitsKilled;
	};
	BattleLog();
	
	std::map<Force*, Army> before;
	std::map<Force*, Army> after;
	
	//std::map<
};

#endif
