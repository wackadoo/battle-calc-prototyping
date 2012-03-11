#include <UnitClass.h>

#include <cassert>

UnitClass::UnitClass() :name("") {
	assert(!valid());
}
UnitClass::UnitClass(const std::string& name) : name(name) {
	assert(valid());
}

bool UnitClass::valid() const {
	return name.compare("") != 0;
}