require 'sinatra'
require 'awe_native_extensions'
require 'haml'

def parse_classes(params)
  return {} if params.nil?
  re = Hash.new
  params.each {|x| re[x["name"]] = Battle::UnitClass.new(x["name"]) unless (!x.has_key?("name") || x["name"].empty?) }
  re
end

def get_type_float_field_setters
  re = Hash.new
  dummy = Battle::UnitType.new
  Battle::UnitType.instance_methods.reject{ 
    |x| 
    !(x.to_s.end_with?("=") && x.to_s.size > 3 && dummy.send(x.to_s[0...-1]).kind_of?(Float))
  }.each{
    |x|
    re[x.to_s[0...-1]] = x
  }
  re
end

def parse_fight(params, types)
  re = Battle::Fight.new
  
  f1 = Battle::Force.new
  f1.isAttacker = true
  a1 = Battle::Army.new
  a1.name = "Army1"
  if params.kind_of?(Hash) && params["0"].kind_of?(Hash) && params["0"]["Army1"].kind_of?(Hash)
    puts "fooo"
    params["0"]["Army1"].each {
      |k,v|
      puts "#{k} => #{v}"
      a1.setNumUnits(types[k].getId, v.to_i)
    }
  end
  f1.addArmy(a1)
  re.addForce(f1)
  
  f2 = Battle::Force.new
  f2.isDefender = true
  a2 = Battle::Army.new
  a2.name = "Army2"
  if params.kind_of?(Hash) && params["1"].kind_of?(Hash) && params["1"]["Army2"].kind_of?(Hash)
    params["1"]["Army2"].each {
      |k,v|
      puts "#{k} => #{v}"
      a2.setNumUnits(types[k].getId, v.to_i)
    }
  end
  f2.addArmy(a2)
  re.addForce(f2)
  
  re
end

def parse_types(params, float_field_setters, classes)
  return {} if params.nil?
  dummy = Battle::UnitType.new
  re = Hash.new
  params.each {
    |k,v|
    if !(v["name"].nil? || v["name"].empty?)
      re[v["name"]] = Battle::UnitType.new 
      re[v["name"]].name = v["name"]
      re[v["name"]].unitClass = classes[v["unitClass"]].getId
      float_field_setters.each {
        |k2,v2|
        re[v["name"]].send(v2, v[k2].to_f) if v.has_key? k2
      }
      
      v["weight"].each {
        |k2,v2|
        re[v["name"]].setDamageDistribution(classes[k2].getId, v2.to_f)
      } if v["weight"].kind_of?(Hash)
    end
  }
  re
end

get '/' do
  puts params
  @classes = parse_classes(params["classes"])
  @type_float_fields = get_type_float_field_setters
  @types = parse_types(params["types"], @type_float_fields, @classes)
  @fight = parse_fight(params["forces"], @types)
  
  @fight_log = "";
  bc = Battle::BattleCalculator.new(1.0)
  fight_done = false
  @fight_after = Battle::Fight.new(@fight)

  while !fight_done do
    @fight_log += "before tick\n"
    @fight_log += @fight_after.toString+"\n"
    fight_done = bc.callculateOneTick(@fight_after)
    @fight_log += "after tick"+"\n"
    @fight_log += @fight_after.toString+"\n"
  end
  
	#erb (:index, {:foo => {:d => "sup"}})
	haml :index, :format => :html5
end