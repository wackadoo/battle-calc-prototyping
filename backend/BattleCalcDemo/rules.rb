# encoding: utf-8  


# A module containing the game rules of a particular game instance using the
# Augmented Worlds Engine. The rules define all entities and their attributes 
# in the game.
#
# This particular file does hold the following set of rules:
# Game:    Wack-A-Doo
# Branch:  development (alpha)
# Version: 0.0.1
#
# ATTENTION: this file is auto-generated from rules/rules.xml . DO NOT EDIT 
# THIS FILE, as all your edits will be overwritten.
#
# This file is auto-generated. See the 'original' files (rules/rules.xml and 
# rules/rules.ruby.xsl) for the list of authors.
#
# All rights reserved. Copyright (C) 2012 5D Lab GmbH.



# Object holding all the configurable game rules. Comes with a version number
# in order to allow to check for recency of the rules. Contains several 
# hashes that have all the details regarding resources, units, buildings and
# sciences in this particular game.
class GameRules

  attr_accessor :version, :resource_types, :unit_types, :building_types, :science_types, :unit_categories, :building_categories
  
  def attributes 
    { 
      'version'        => version,
      'unit_categories'=> unit_categories,
      'building_categories'=> building_categories,
      'unit_types'     => unit_types,
      'resource_types' => resource_types,
      'building_types' => building_types,
      'science_types'  => science_types,  
    }
  end
  
  def initialize(attributes = {})
    attributes.each do | name, value |
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end
  

  # returns the rules-singleton containing all the present rules. Should not
  # be modified by the program. Uses conditional assignment to construct the
  # rules object on first access.
  def self.the_rules
    @the_rules ||= GameRules.new(
  
        :version => { :major => 0, 
                      :minor => 0, 
                      :build => 1, 
        },

  
  
      :unit_categories => [  # ALL UNIT CATEGORIES

        {               #   Infantry
          :id          => 0, 
          :symbolic_id => :unitcategory_infantry,
          :db_field    => :unitcategory_unitcategory_infantry,
          :name        => {
            
            :en_US => "Infantry",
  
            :de_DE => "Fußtruppen",
                
          },
          :description => {
            
            :en_US => "<p>English description here.</p>",
  
            :de_DE => "<p>Infanterie ist die Basiseinheit in jeder Truppe. Sie schützt Fernkämpfer vor direkt Angriffen und kann, wenn in ausreichender Zahl vorhanden, auch Flankenangriffe abwehren.</p>",
                
          },

          :target_priorities => {
            :test_type => :no_test,

            :results => [
              
              [
                0,
                1,
                2,
                3,
                
              ],
       
            ],
          },
        },              #   END OF Infantry
        {               #   cavalry
          :id          => 1, 
          :symbolic_id => :unitcategory_cavalry,
          :db_field    => :unitcategory_unitcategory_cavalry,
          :name        => {
            
            :en_US => "cavalry",
  
            :de_DE => "Reiter",
                
          },
          :description => {
            
            :en_US => "<p>English description here.</p>",
  
            :de_DE => "<p>Berittene Einheiten bewegen sich schnell auf dem Schlachtfeld, und sind als einzige in der Lage, die gegnerischen Fußtruppen zu umgehen und feindliche Fernkämpfer direkt anzugreifen (Flankenangriff).</p>",
                
          },

          :target_priorities => {
            :test_type => :line_size_test,

            :test_category => 0,

            :results => [
              
              [
                1,
                2,
                0,
                3,
                
              ],

              [
                1,
                0,
                2,
                3,
                
              ],
       
            ],
          },
        },              #   END OF cavalry
        {               #   Ranged Troops
          :id          => 2, 
          :symbolic_id => :unitcategory_artillery,
          :db_field    => :unitcategory_unitcategory_artillery,
          :name        => {
            
            :en_US => "Ranged Troops",
  
            :de_DE => "Fernkämpfer",
                
          },
          :description => {
            
            :en_US => "<p>English description here.</p>",
  
            :de_DE => "<p>Die Fernkämpfer schießen aus sicherer Distanz auf den Gegner, vorzugsweise auf Fußsoldaten. Im Nahkampf sind sie extrem anfällig.</p>",
                
          },

          :target_priorities => {
            :test_type => :no_test,

            :results => [
              
              [
                0,
                2,
                1,
                3,
                
              ],
       
            ],
          },
        },              #   END OF Ranged Troops
        {               #   Siege Weapons
          :id          => 3, 
          :symbolic_id => :unitcategory_siege,
          :db_field    => :unitcategory_unitcategory_siege,
          :name        => {
            
            :en_US => "Siege Weapons",
  
            :de_DE => "Belagerungsgeräte",
                
          },
          :description => {
            
            :en_US => "<p>Siege Weapons support armies in battle against settlements.</p>",
  
            :de_DE => "<p>Belagerungsgerät dient der Unterstützung im Kampf gegen Siedlungen.</p>",
                
          },

          :target_priorities => {
            :test_type => :no_test,

            :results => [
              
              [
                3,
                2,
                0,
                1,
                
              ],
       
            ],
          },
        },              #   END OF Siege Weapons
      ],                # END OF UNIT CATEGORIES

  
      :unit_types => [  # ALL UNIT TYPES

        {               #   Club Warrior
          :id          => 0, 
          :symbolic_id => :clubbers,
					:category    => 0,
          :db_field    => :unit_clubbers,
          :name        => {
            
            :en_US => "Club Warrior",
  
            :de_DE => "Keulenkrieger",
                
          },
          :effectiveness => {
            
            :unitcategory_infantry => 0.9,
  
            :unitcategory_cavalry => 0.9,
  
            :unitcategory_artillery => 0.7,
  
            :unitcategory_siege => 0.8,
                
          },
          :description => {
            
            :de_DE => "<p>Eine Keule in der Hand und immer an vorderster Front. Keulenkrieger brauchen nicht viel für ein glücklcihes Leben.</p><p>Zudem ist dieses meist sehr kurz.</p>",
  
            :en_US => "<p>Actually armed with a club, the mace-men are in the front rank of all armies.</p>",
                
          },

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 16,
          :attack      => 15,
          :armor       => 0,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 2,
          :critical_hit_chance => 0.01,


        },              #   END OF Club Warrior
        {               #   Tree Huggers
          :id          => 1, 
          :symbolic_id => :tree_huggers,
					:category    => 0,
          :db_field    => :unit_tree_huggers,
          :name        => {
            
            :en_US => "Tree Huggers",
  
            :de_DE => "Baum-Brutalo",
                
          },
          :effectiveness => {
            
            :unitcategory_infantry => 0.8,
  
            :unitcategory_cavalry => 1,
  
            :unitcategory_artillery => 0.8,
  
            :unitcategory_siege => 1,
                
          },
          :description => {
            
            :de_DE => "<p>Groß, stark, sauber rasierter Bart. Ein Baum-Brutalo legt sehr großen Wert auf sein Äußeres.</p><p>In der Schlacht bietet der Baum-Brutalo ein seltsames Schauspiel. Umhüllt von den rauschen Blättern seines Kampfbaumes wirbelt der Baum-Brutalo durch die gegnerischen Reihen wie ein Säberlzahntiger, der sich den Schwanz geklammt hat. Nicht den flauschigen, den anderen...</p>",
  
            :en_US => "<p>What Tree-Huggers lack in brains, they make up for with sheer strength.</p><p>Telling by an unverified legend, those guys are brought up in a tree-nursery.</p>",
                
          },

          :velocity    => 0.95,
          :action_points => 4,
          :initiative  => 14,
          :attack      => 20,
          :armor       => 4,
          :hitpoints   => 140,

          :overrunnable => true,

          :critical_hit_damage => 9,
          :critical_hit_chance => 0.02,


        },              #   END OF Tree Huggers
        {               #   Pebble Thrower
          :id          => 2, 
          :symbolic_id => :thrower,
					:category    => 2,
          :db_field    => :unit_thrower,
          :name        => {
            
            :en_US => "Pebble Thrower",
  
            :de_DE => "Kieselsteinwerfer",
                
          },
          :effectiveness => {
            
            :unitcategory_infantry => 1,
  
            :unitcategory_cavalry => 0.3,
  
            :unitcategory_artillery => 0.75,
  
            :unitcategory_siege => 0.75,
                
          },
          :description => {
            
            :de_DE => "<p>Große Steine, kleine Steine, ein Kieselsteinwerfer mag sie alle, solange er sie jemandem an den Kopf werfen kann. Ok, zugegeben, die kleinen mag er ein bisschen lieber. Nichtsdestotrotz kann er moderaten kritischen Schaden zufügen - denn, wie jeder weiß, das kann auch ins Auge gehen.</p>",
  
            :en_US => "<p>Small Stones, big Stones, a Peeble Thrower likes them all, as long as he can throw them at people. Ok, granted, the small ones are slightly prefered... Nevertheless, he may inflict moderate critical damage by sometimes hitting an opponent's eye.'</p>",
                
          },

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 8,
          :attack      => 18,
          :armor       => 2,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 10,
          :critical_hit_chance => 0.01,


        },              #   END OF Pebble Thrower
        {               #   Spit Bearer
          :id          => 3, 
          :symbolic_id => :skewer,
					:category    => 0,
          :db_field    => :unit_skewer,
          :name        => {
            
            :en_US => "Spit Bearer",
  
            :de_DE => "Bratspießträger",
                
          },
          :effectiveness => {
            
            :unitcategory_infantry => 0.9,
  
            :unitcategory_cavalry => 1.2,
  
            :unitcategory_artillery => 0.6,
  
            :unitcategory_siege => 0.6,
                
          },
          :description => {
            
            :de_DE => "<p>Der Umgang mit der Waffe ist schnell gelernt: Das spitze Ende muss nach vorn!</p><p>Richtig angewendet tropfen fettige Flüssigkeiten vom Spieß, genau genommen das Blut seiner Feinde</p>",
  
            :en_US => "<p>Skewer Crew training 101: stick'em with the pointy end!</p><p>Greasy liquids are dripping from the spits, correctly used it is the enemies‘ blood.</p>",
                
          },

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 15,
          :attack      => 16,
          :armor       => 3,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 11,
          :critical_hit_chance => 0.01,


        },              #   END OF Spit Bearer
        {               #   Ostrich Riders
          :id          => 4, 
          :symbolic_id => :light_cavalry,
					:category    => 1,
          :db_field    => :unit_light_cavalry,
          :name        => {
            
            :en_US => "Ostrich Riders",
  
            :de_DE => "Straußenreiter",
                
          },
          :effectiveness => {
            
            :unitcategory_infantry => 0.3,
  
            :unitcategory_cavalry => 0.75,
  
            :unitcategory_artillery => 1,
  
            :unitcategory_siege => 0.4,
                
          },
          :description => {
            
            :de_DE => "<p>Strauße sind nicht nur lecker sondern auch gute und schnelle Kämpfer. Die Straußenreiter sind äußerst schnell, dafür aber nur schwach gepanzert.</p>",
  
            :en_US => "<p>Ostrichs are not only delicious but also excellent and fast animals to be used in combats. Ostrich riders are very quick, but only lightly armored.</p>",
                
          },

          :velocity    => 1.5,
          :action_points => 5,
          :initiative  => 26,
          :attack      => 16,
          :armor       => 3,
          :hitpoints   => 95,

          :overrunnable => true,

          :critical_hit_damage => 10,
          :critical_hit_chance => 0.01,


        },              #   END OF Ostrich Riders
        {               #   Sabretooth-Riders
          :id          => 5, 
          :symbolic_id => :sabre_riders,
					:category    => 1,
          :db_field    => :unit_sabre_riders,
          :name        => {
            
            :en_US => "Sabretooth-Riders",
  
            :de_DE => "Säbelzahnreiter",
                
          },
          :effectiveness => {
            
            :unitcategory_infantry => 0.4,
  
            :unitcategory_cavalry => 0.6,
  
            :unitcategory_artillery => 1,
  
            :unitcategory_siege => 0.4,
                
          },
          :description => {
            
            :de_DE => "<p>Viele fürchten die Reittiere mehr als die eigentlichen Reiter...</p>",
  
            :en_US => "<p>It's not so much the riders themselves that are feared...</p>",
                
          },

          :velocity    => 1.4,
          :action_points => 4,
          :initiative  => 28,
          :attack      => 21,
          :armor       => 15,
          :hitpoints   => 140,

          :overrunnable => true,

          :critical_hit_damage => 14,
          :critical_hit_chance => 0.02,


        },              #   END OF Sabretooth-Riders
        {               #   Battering Ram
          :id          => 6, 
          :symbolic_id => :ram,
					:category    => 3,
          :db_field    => :unit_ram,
          :name        => {
            
            :en_US => "Battering Ram",
  
            :de_DE => "Rammbock",
                
          },
          :effectiveness => {
            
            :unitcategory_infantry => 0.2,
  
            :unitcategory_cavalry => 0.1,
  
            :unitcategory_artillery => 0.2,
  
            :unitcategory_siege => 1,
                
          },
          :description => {
            
            :de_DE => "<p>Nur wenige wissen, dass der Name Rammbock von einem prähistorischen Tier aus der Unterfamilie der ziegenartigen (caprinae) abstammt.</p>",
  
            :en_US => "<p>The battering ram is the lockpick of choice to open doors, gates and cracking down fortifications.</p>",
                
          },

          :velocity    => 0.9,
          :action_points => 4,
          :initiative  => 16,
          :attack      => 15,
          :armor       => 0,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 2,
          :critical_hit_chance => 0.01,


        },              #   END OF Battering Ram
        {               #   Catapult
          :id          => 7, 
          :symbolic_id => :catapult,
					:category    => 3,
          :db_field    => :unit_catapult,
          :name        => {
            
            :en_US => "Catapult",
  
            :de_DE => "Katapult",
                
          },
          :effectiveness => {
            
            :unitcategory_infantry => 0.2,
  
            :unitcategory_cavalry => 0.1,
  
            :unitcategory_artillery => 0.2,
  
            :unitcategory_siege => 1,
                
          },
          :description => {
            
            :de_DE => "<p>Das Basismodell 'Catabilly' zum selber zusammenbauen, unschlagbar günstig.</p>",
  
            :en_US => "<p>The catapults take the cake in every intense battle because of their devastating damage.</p>",
                
          },

          :velocity    => 0.7,
          :action_points => 4,
          :initiative  => 16,
          :attack      => 15,
          :armor       => 0,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 2,
          :critical_hit_chance => 0.01,


        },              #   END OF Catapult
        {               #   Neanderthal
          :id          => 8, 
          :symbolic_id => :neanderthal,
					:category    => 0,
          :db_field    => :unit_neanderthal,
          :name        => {
            
            :en_US => "Neanderthal",
  
            :de_DE => "Neandertaler",
                
          },
          :effectiveness => {
            
            :unitcategory_infantry => 1.0,
  
            :unitcategory_cavalry => 0.8,
  
            :unitcategory_artillery => 1.0,
  
            :unitcategory_siege => 1.0,
                
          },
          :description => {
            
            :de_DE => "<p>Wilder Vormenschenstamm.</p>",
  
            :en_US => "<p>Fierce Fighters.</p>",
                
          },

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 16,
          :attack      => 15,
          :armor       => 0,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 2,
          :critical_hit_chance => 0.01,


        },              #   END OF Neanderthal
        {               #   Slingshot Warrior
          :id          => 9, 
          :symbolic_id => :slingshot_warrior,
					:category    => 2,
          :db_field    => :unit_slingshot_warrior,
          :name        => {
            
            :en_US => "Slingshot Warrior",
  
            :de_DE => "Steinschleuderer",
                
          },
          :effectiveness => {
            
            :unitcategory_infantry => 1,
  
            :unitcategory_cavalry => 1.1,
  
            :unitcategory_artillery => 0.75,
  
            :unitcategory_siege => 0.5,
                
          },
          :description => {
            
            :de_DE => "<p>Der Steinschleuderer trägt eine große Lederschleuder. Mit Hilfe dieser Schleuder schleudert der Steinschleuderer dem Gegner Steine entgegen.</p><p>Ausschlaggebend für die Zielsicherheit ist dabei zum einen die Technik. Zwei bis drei Schwünge und dann am Scheitelpunkt mit einem Ruck den Stein schleudern. Zum anderen - und dies behaupten vor allem die Anfänger- ist die Art der Schleuder wichtig. Hochwertigere Ledersorten mit einer einwandfreien Verarbeitung und schönen Verzierungen treffen besser.</p><p>Viele Tests konnten dies nicht belegen, dennoch sind die hochwertig verzierten Schleudern eine begehrte Beute. Sowohl beim Gegner als auch bei den eigenen Steinschleuderern.</p>",
  
            :en_US => "<p>Small Stones, big Stones, a Peeble Thrower likes them all, as long as he can throw them at people. Ok, granted, the small ones are slightly prefered... Nevertheless, he may inflict moderate critical damage by sometimes hitting an opponent's eye.'</p>",
                
          },

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 8,
          :attack      => 18,
          :armor       => 2,
          :hitpoints   => 50,

          :overrunnable => true,

          :critical_hit_damage => 10,
          :critical_hit_chance => 0.01,


        },              #   END OF Slingshot Warrior
      ],                # END OF UNIT TYPES

    )
  end
end


# INLINED TEST CODE: (uncomment to run)

#puts GameRules::Rules.the_rules.to_json
#GameRules.rules.unit_types.each do |value| 
#  puts value[:name][:de_DE] 
#end

