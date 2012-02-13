#include <Damage.h>

#include <cmath>
#include <util/Random.h>
#include <cassert>

#include <iostream>

Damage::DistributedDamage::DistributedDamage(const Army& army, bool attacker, double damageFactor) {
	std::map<const UnitType*, size_t>::const_iterator it;
	for (it = army.numUnits.begin(); it != army.numUnits.end(); it++) {
		//base damage
		double damageValue = double(it->second)*it->first->damage;
		//add the critical damage
		double numCritical = double(it->second)*it->first->criticalProbability;
		damageValue += (
							std::floor(numCritical)+
							util::Random::random01(numCritical-std::floor(numCritical))
						)*it->first->criticalDamage;
		//add attacker damage
		if (attacker) {
			damageValue += it->first->attackerBonusDamage*double(it->second);
		}
		
		//multiply by damagefactor
		damageValue *= damageFactor;
		
		//set the distributed damage
		{
			std::map<const UnitClass*, double>::const_iterator it2;
			for (it2 = it->first->damageDistribution.begin(); it2 != it->first->damageDistribution.end(); it2++) {
				if (this->damage.find(it2->first) == this->damage.end()) {
					this->damage[it2->first] = damageValue*it2->second;
				} else {
					this->damage[it2->first] += damageValue*it2->second;
				}
			}
		}
	}
}
Damage::DistributedDamage::DistributedDamage(const Damage& damage) {
	Damage d(damage);
	d.normalizeWeights();
	std::map<UnitClass::IdType, double>::const_iterator it;
	for (it = d.weight.begin(); it != d.weight.end(); it++) {
		this->damage[it->first] = it->second * damage.damage;
	}
}
Damage::DistributedDamage::DistributedDamage(const DistributedDamage& other) : damage(other.damage) {}

void Damage::DistributedDamage::apply(Army& army, bool isDefender) {
	std::map<UnitClass::IdType, size_t> numUnitsOfClass;
	army.getNumberOfUnitsPerClass(numUnitsOfClass);
	
	{
		std::map<UnitType::IdType, size_t>::iterator it;
		for (it = army.numUnits.begin(); it != army.numUnits.end(); it++) {
			if (it->second > 0) {
				//callculate damage
				double w = double(it->second) / double(numUnitsOfClass[it->first->unitClass]);
				double currentDamage = w*getDamage(it->first->unitClass);
				//callculate how many units die
				double healthPerUnit = it->first->hitpoints + (isDefender?it->first->defenderBonusHitpoints:0.0);
				//kills all
				if (currentDamage >= healthPerUnit*double(it->second)) {
					this->damage[it->first->unitClass] -= healthPerUnit*double(it->second);
					it->second = 0;
				//kills a part
				} else if (currentDamage > 0) {
					assert(healthPerUnit*double(it->second) > 0.0);
					double num = currentDamage/(healthPerUnit);
					assert(double(it->second) >= num);
					assert(num >= 0);
					it->second -= (size_t)(std::floor(num));
					assert(it->second >= 0);
					std::cout<<"probability for extra lost = "<<num-std::floor(num)<<std::endl;
					if (util::Random::random(num-std::floor(num))) {
						it->second -= 1;
					}
					assert(it->second >= 0);
					this->damage[it->first->unitClass] -= currentDamage;
					if (this->damage[it->first->unitClass] < 0.0) {
						this->damage[it->first->unitClass] = 0.0;
					}
				}
			}
		}
	}
}
double Damage::DistributedDamage::damageSum() const {
	double sum = 0.0;
	std::map<UnitClass::IdType, double>::const_iterator it;
	for( it = this->damage.begin(); it != this->damage.end(); it++) {
		sum += it->second;
	}
	return sum;
}
double Damage::DistributedDamage::getDamage(UnitClass::IdType classType) const {
	std::map<UnitClass::IdType, double>::const_iterator it = this->damage.find(classType);
	if (it != this->damage.end()) return it->second;
	return 0.0;
}

void Damage::DistributedDamage::add(const DistributedDamage& other) {
	std::map<UnitClass::IdType, double>::const_iterator it;
	for (it = other.damage.begin(); it != other.damage.end(); it++) {
		std::map<UnitClass::IdType, double>::iterator it2 = damage.find(it->first);
		if (it2 != damage.end()) {
			it2->second += it->second;
		} else {
			damage[it->first] = it->second;
		}
	}
}


Damage::Damage(const Army& army, bool attacker, double damageFactor) {

	//calculate the damage that the army generates
	DistributedDamage distDamage(army, attacker, damageFactor);
	
	//set the damage
	this->damage = distDamage.damageSum();
	
	//callculate the weighting
	{
		std::map<const UnitClass*, double>::const_iterator it;
		for (it = distDamage.damage.begin(); it != distDamage.damage.end(); it++) {
			weight[it->first] = it->second/this->damage;
		}
	}
}
Damage::Damage(const Damage& other) : damage(other.damage), weight(other.weight) {}
Damage::Damage() {}

void Damage::normalizeWeights() {
	double sum = 0.0;
	{
		std::map<const UnitClass*, double>::const_iterator it;
		for (it = weight.begin(); it != weight.end(); it++) {
			sum += it->second;
		}
	}
	if (sum != 1.0 && sum > 0.0) {
		std::map<const UnitClass*, double>::iterator it;
		for (it = weight.begin(); it != weight.end(); it++) {
			it->second /= sum;
		}
	}
}
bool Damage::isNull() const {
	return damage == 0.0;
}
Damage Damage::apply(Army& army, bool isDefender) const {
	
	//Damage copy for local opartions
	Damage d(*this);
	while (d.canDamage(army)) {
		//check if for every damage /weight combination there are units
		{
			std::map<const UnitClass*, double>::iterator it;
			for (it = d.weight.begin(); it != d.weight.end(); it++) {
				if (!army.hasUnits(it->first)) {
					it->second = 0.0;
				}
			}
		}
		std::cout<<"\t\tAfter weight shift:"<<std::endl;
		std::cout<<"\t\t\t"<<d<<std::endl;
		
		//callculate the actual damage per class based on these weights
		DistributedDamage distDamage(d);
		std::cout<<"\t\tCalculated damage:"<<std::endl;
		std::cout<<"\t\t\t"<<distDamage<<std::endl;
		
		//apply the damage
		std::cout<<"\t\tArmy before applying damage:"<<std::endl;
		std::cout<<"\t\t\t"<<army<<std::endl;
		distDamage.apply(army, isDefender);
		std::cout<<"\t\tArmy after applying damage:"<<std::endl;
		std::cout<<"\t\t\t"<<army<<std::endl;
		distDamage.apply(army, isDefender);
		d.damage = distDamage.damageSum();
		
	}
	Damage d2(*this);
	d2.damage = d.damage;
	return d2;
}
Damage Damage::split(double factor) const {
	Damage d(*this);
	d.damage *= factor;
	return d;
}

/*void Damage::add(const Damage& other) {
	std::map<const UnitClass*, double>::const_iterator it;
	for (it = other.damage.begin(); it != other.damage.end(); it++) {
		std::map<const UnitClass*, double>::iterator it2 = damage.find(it->first);
		if (it2 == damage.end()) {
			damage[it->first] = it->second;
		} else {
			it2->second += it->second;
		}
	}
}*/

/*void Damage::setAllDamageValues(double value) {
	std::map<const UnitClass*, double>::iterator it;
	for (it = damage.begin(); it != damage.end(); it++) {
		it->second = value;
	}
}*/
		   
bool Damage::canDamage(const Army& army) const {
	if (this->isNull()) return false;
	std::map<const UnitClass*, double>::const_iterator it;
	for (it = weight.begin(); it != weight.end(); it++) {
		if (army.hasUnits(it->first)) {
			return true;
		}
	}
	return false;
}