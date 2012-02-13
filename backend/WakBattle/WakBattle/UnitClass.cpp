#include <UnitClass.h>

UnitClass::UnitClass() :name("") {}
UnitClass::UnitClass(const std::string& name) : name(name) {}

bool UnitClass::valid() const {
	return name.compare("") != 0;
}