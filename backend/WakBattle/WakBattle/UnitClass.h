#ifndef WakBattle_UnitClass_h
#define WakBattle_UnitClass_h

#include <string>

///A class of units.
class UnitClass {
public:
	///Creates a class that is not valid.
	///@note this is mainly so that containers of classes can be created.
	///@post !valid()
	UnitClass();
	///Creates a class with the given name.
	///@pre name != ""
	///@post valid()
	UnitClass(const std::string& name);
	
	///The type that should be used to reference the class.
	typedef const UnitClass* IdType;
	///Returns the id of this class of units.
	inline IdType getId() const { return this; }
	
	///Returns if the class was initialized correctly
	bool valid() const;
	
	///The name of the class.
	std::string name;
};

#endif
