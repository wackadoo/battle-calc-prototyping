#ifndef WakBattle_UnitClass_h
#define WakBattle_UnitClass_h

#include <string>

class UnitClass {
public:
	UnitClass();
	///@pre name != ""
	UnitClass(const std::string& name);
	
	typedef const UnitClass* IdType;
	inline IdType getId() const { return this; }
	
	bool valid() const;
	
	std::string name;
};

#endif
