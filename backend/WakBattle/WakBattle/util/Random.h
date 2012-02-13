#ifndef WakBattle_util_Random_h
#define WakBattle_util_Random_h

#include <cstdlib>

namespace util {
class Random {
public:
	static double random();
	static bool random(double probability);
	static double random01(double probability);
	static size_t random(size_t start, size_t end);
};
} //namespace util
#endif
