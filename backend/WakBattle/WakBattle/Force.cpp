#include <Force.h>

#include <sstream>

Force::Force() : armies(), isDefender(false), isAttacker(false) {}

Force::Force(const Force& other) : armies(other.armies), isDefender(other.isDefender), isAttacker(other.isAttacker) {}

Force::Force(const std::vector<Army>& armies, bool isDefender, bool isAttacker) : armies(armies), isDefender(isDefender), isAttacker(isAttacker) {}

Army Force::combinedArmy() const {
	std::map<UnitType::IdType, size_t> units;
	std::vector<Army>::const_iterator it;
	for (it = armies.begin(); it != armies.end(); it++) {
		std::map<UnitType::IdType, size_t>::const_iterator uIt;
		for (uIt = it->numUnits.begin(); uIt != it->numUnits.end(); uIt++) {
			if (units.find(uIt->first) != units.end()) {
				units[uIt->first] += uIt->second;
			} else {
				units[uIt->first] = uIt->second;
			}
		}
	}
	return Army(units);
}
bool Force::hasUnits() const {
	std::vector<Army>::const_iterator it;
	for (it = armies.begin(); it != armies.end(); it++) {
		if (it->hasUnits()) {
			return true;
		}
	}
	return false;
}
size_t Force::numArmies() const {
	return armies.size();
}
Army& Force::getArmy(size_t i) {
	return armies[i];
}
const Army& Force::getArmy(size_t i) const {
	return armies[i];
}
void Force::addArmy(const Army& army) {
	armies.push_back(army);
}

std::string Force::toString() const {
	std::stringstream sstr;
	sstr<<(*this);
	return sstr.str();
}