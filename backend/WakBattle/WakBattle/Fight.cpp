#include <Fight.h>

#include <sstream>

Fight::Fight() {

}

Fight::Fight(const Fight& other) : forces(other.forces) {

}

size_t Fight::size() const {
	return forces.size();
}
Force& Fight::getForce(size_t i) {
	return forces[i];
}
const Force& Fight::getForce(size_t i) const {
	return forces[i];
}
void Fight::addForce(const Force& force) {
	forces.push_back(force);
}

std::string Fight::toString() const {
	std::stringstream sstr;
	std::vector<Force>::const_iterator it;
	for (it = forces.begin(); it != forces.end(); it++) {
		sstr<<"\t"<<(*it)<<"\n";
	}
	return sstr.str();
}