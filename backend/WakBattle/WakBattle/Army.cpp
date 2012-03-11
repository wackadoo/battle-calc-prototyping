#include <Army.h>

Army::Army(const std::string& name, const std::map<UnitType::IdType, size_t>& numUnits) : numUnits(numUnits), name(name) {}
Army::Army(const std::map<UnitType::IdType, size_t>& numUnits) : numUnits(numUnits), name("") {}
Army::Army(const Army& other) : numUnits(other.numUnits), name(other.name) {}
Army::Army(const std::string& name): numUnits(), name(name) {

}
Army::Army() : numUnits(), name("") {}

bool Army::hasUnits() const {
	std::map<UnitType::IdType, size_t>::const_iterator uIt;
	for (uIt = numUnits.begin(); uIt != numUnits.end(); uIt++) {
		if (uIt->second > 0) {
			return true;
		}
	}
	return false;
}
bool Army::hasUnits(UnitClass::IdType c) const {
	std::map<UnitType::IdType, size_t>::const_iterator uIt;
	for (uIt = numUnits.begin(); uIt != numUnits.end(); uIt++) {
		if (uIt->second > 0 && uIt->first->unitClass == c) {
			return true;
		}
	}
	return false;
}
size_t Army::getNumUnits() const {
	size_t s = 0;
	std::map<const UnitType*, size_t>::const_iterator uIt;
	for (uIt = numUnits.begin(); uIt != numUnits.end(); uIt++) {
		s += uIt->second;
	}
	return s;
}
size_t Army::getNumUnits(UnitType::IdType type) const {
	std::map<UnitType::IdType, size_t>::const_iterator it = numUnits.find(type);
	if (it != numUnits.end()) return it->second;
	return 0;
}
void Army::setNumUnits(UnitType::IdType type, size_t num) {
	numUnits[type] = num;
}
void Army::getNumberOfUnitsPerClass(std::map<UnitClass::IdType, size_t>& re) const {
	std::map<UnitType::IdType, size_t>::const_iterator it;
	for (it = numUnits.begin(); it != numUnits.end(); it++) {
		//add to number of units for this class
		if (re.find(it->first->unitClass) == re.end()) {
			re[it->first->unitClass] = it->second;
		} else {
			re[it->first->unitClass] += it->second;
		}
	}
}

void Army::getClasses(std::set<UnitClass::IdType>& re) const {
	std::map<UnitType::IdType, size_t>::const_iterator it;
	for (it = numUnits.begin(); it != numUnits.end(); it++) {
		//add to list of classes
		re.insert(it->first->unitClass);
	}
}
