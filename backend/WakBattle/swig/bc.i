%module bc

%include std_string.i
%include std_vector.i
%include std_map.i

 %{
 /* Includes the header in the wrapper code */
 #include "../WakBattle/UnitClass.h"
 #include "../WakBattle/UnitType.h"
 #include "../WakBattle/Army.h"
 #include "../WakBattle/Force.h"
 #include "../WakBattle/Fight.h"
 #include "../WakBattle/BattleCalculator.h"
 #include "../WakBattle/util/Random.h"
 %}
 
 /* Parse the header file to generate wrappers */
 %include "../WakBattle/UnitClass.h"
 %include "../WakBattle/UnitType.h"
 %include "../WakBattle/Army.h"
 %include "../WakBattle/Force.h"
 %include "../WakBattle/Fight.h"
 %include "../WakBattle/BattleCalculator.h"
 %include "../WakBattle/util/Random.h"

#namespace std {
#   %template(MapUnitClassSize) map<::UnitClass::IdType,size_t>; 
#   %template(MapUnitTypeSize) map<::UnitType::IdType,size_t>;
# };