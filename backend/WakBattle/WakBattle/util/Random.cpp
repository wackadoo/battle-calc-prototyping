#include <util/Random.h>

#include <cassert>
#include <cmath>
#include <limits>

namespace util {
double Random::random() {
	return (double(arc4random()) / double(std::numeric_limits<u_int32_t>::max()));
}
bool Random::random(double probability) {
	assert(probability >= 0.0 && probability <= 1.0);
	if (probability <= 0.0) return false;
	return (Random::random()) <= probability;
}
double Random::random01(double probability) {
	return Random::random(probability)?1.0:0.0;
}
size_t Random::random(size_t start, size_t end) {
	assert(start <= end);
	return start + size_t(round(Random::random()*(double(end-start))));
}
}//namespace util
