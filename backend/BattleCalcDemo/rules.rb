# encoding: utf-8  

require 'active_model'

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
class GameRules::Rules
  include ActiveModel::Serializers::JSON
  include ActiveModel::Serializers::Xml
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  self.include_root_in_json = false

  attr_accessor :version, :battle, :character_creation, :resource_types, :unit_types, :building_types, :science_types, :unit_categories, :building_categories, :queue_types, :settlement_types
  
  def attributes 
    { 
      'version'        => version,
      'battle'         => battle,
      'character_creation' => character_creation,
      'unit_categories'=> unit_categories,
      'building_categories'=> building_categories,
      'unit_types'     => unit_types,
      'resource_types' => resource_types,
      'building_types' => building_types,
      'science_types'  => science_types,  
      'settlement_types'  => settlement_types,  
      'queue_types'    => queue_types,  
    }
  end
  
  def initialize(attributes = {})
    if !Rails.logger.nil?
      Rails.logger.debug('RULES: running game rules initializer.')
    end
  
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
    @the_rules ||= GameRules::Rules.new(
  
        :version => { :major => 0, 
                      :minor => 0, 
                      :build => 1, 
        },
        :battle => {
          :calculation => {
            :round_time => 30,
            :retreat_probability => 0.6,
            },
        },
        :character_creation => {
          :start_resources => {
            0 => 2000,
1 => 2000,
2 => 1500,
3 => 5,

          },
        },
  
# ## RESOURCE TYPES ##########################################################
  
      :resource_types => [  # ALL RESOURCE TYPES

        {               #   resource_wood
          :id          => 0, 
          :symbolic_id => :resource_wood,
          :stealable   => true,
          :rating_value=> 1,
          :name        => {
            
            :de_DE => "Holz",
  
            :en_US => "Wood",
                
          },
          :flavour     => {
            
            :de_DE => "Ein Brett in Ehren kann niemand verwehren.",
  
            :en_US => "Hard as wood.",
                
          },
          :description => {
            
            :de_DE => "<p>Holz war bereits in der Steinzeit in allen Varianten verfügbar: Nadelholz, Laubholz, Kantholz und natürlich Brettholz. Als Rohtoff spielt Holz eine wichtige Rolle bei der Konstruktion von Gebäuden und Belagerungswaffe.</p>",
  
            :en_US => "<p>Basic resource for constructing buildings and siege machines.</p>",
                
          },          
        },              #   END OF resource_wood
        {               #   resource_stone
          :id          => 1, 
          :symbolic_id => :resource_stone,
          :stealable   => true,
          :rating_value=> 1,
          :name        => {
            
            :de_DE => "Stein",
  
            :en_US => "Stone",
                
          },
          :flavour     => {
            
            :de_DE => "Grau, hart, überall zu finden.",
  
            :en_US => "Harder than wood.",
                
          },
          :description => {
            
            :de_DE => "<p>Steine -- in der STEINzeit DER Rohstoff schlechthin. Kann gesammelt, gestapelt, geschärft und geworfen werden. Mehr muss man nicht sagen.</p>",
  
            :en_US => "<p>Basic resource for constructing buildings and weapons.</p>",
                
          },          
        },              #   END OF resource_stone
        {               #   resource_fur
          :id          => 2, 
          :symbolic_id => :resource_fur,
          :stealable   => true,
          :rating_value=> 1,
          :name        => {
            
            :de_DE => "Fell",
  
            :en_US => "Fur",
                
          },
          :flavour     => {
            
            :de_DE => "In der gesamten Steinzeit wurden Kunstfelle verwendet, es kamen keine Tiere zu schaden. Natürlich!",
  
            :en_US => "Softer than wood.",
                
          },
          :description => {
            
            :de_DE => "<p>Hällt warm, hällt Wasser ab, verhängt Löcher und taugt im Notfall auch als rudimentäre Dachbedeckung.</p>",
  
            :en_US => "<p>Basic resource to be worn by warriors and also utilized in buildings..</p>",
                
          },          
        },              #   END OF resource_fur
        {               #   resource_cash
          :id          => 3, 
          :symbolic_id => :resource_cash,
          :stealable   => false,
          :rating_value=> 0,
          :name        => {
            
            :de_DE => "Kröte",
  
            :en_US => "Toad",
                
          },
          :flavour     => {
            
            :de_DE => "Jeder mag Kröten! Die Steinzeitwährung.",
  
            :en_US => "Everybody loves toads! Stoneage-Cash.",
                
          },
          :description => {
            
            :de_DE => "<p>Quasi-Wärhung in der Steinzeit. Gerne genommen in jeglichen Tauschhandeln.</p>",
  
            :en_US => "<p>Currency of the stone-age.</p>",
                
          },          
        },              #   END OF resource_cash
      ],                # END OF RESOURCE TYPES

  
      :unit_categories => [  # ALL UNIT CATEGORIES

        {               #   Infantry
          :id          => 0, 
          :symbolic_id => :unitcategory_infantry,
          :db_field    => :unitcategory_infantry,
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
          :db_field    => :unitcategory_cavalry,
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
          :db_field    => :unitcategory_artillery,
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
          :db_field    => :unitcategory_siege,
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

  
# ## UNIT TYPES ##############################################################

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
          :flavour     => {
            
            :en_US => "<p>Kills opposing units.</p>",
  
            :de_DE => "<p>Kämpft gegen andere Einheiten.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Eine Keule in der Hand und immer an vorderster Front. Keulenkrieger brauchen nicht viel für ein glücklcihes Leben.</p><p>Zudem ist dieses meist sehr kurz.</p>",
  
            :en_US => "<p>Actually armed with a club, the mace-men are in the front rank of all armies.</p>",
                
          },

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 16,
          :effectiveness => {
            
            :unitcategory_infantry => 1,
  
            :unitcategory_cavalry => 1.2,
  
            :unitcategory_artillery => 0.92,
  
            :unitcategory_siege => 0.8,
                
          },
          :attack      => 16,
          :armor       => 12,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 2,
          :critical_hit_chance => 0.01,

          :production_time => '1200',

          :costs      => {
            1 => '30',
            0 => '60',
            2 => '45',
            
          },


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
          :flavour     => {
            
            :en_US => "<p>Kills opposing units.</p>",
  
            :de_DE => "<p>Kämpft gegen andere Einheiten.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Groß, stark, sauber rasierter Bart. Ein Baum-Brutalo legt sehr großen Wert auf sein Äußeres.</p><p>In der Schlacht bietet der Baum-Brutalo ein seltsames Schauspiel. Umhüllt von den rauschen Blättern seines Kampfbaumes wirbelt der Baum-Brutalo durch die gegnerischen Reihen wie ein Säberlzahntiger, der sich den Schwanz geklammt hat. Nicht den flauschigen, den anderen...</p>",
  
            :en_US => "<p>What Tree-Huggers lack in brains, they make up for with sheer strength.</p><p>Telling by an unverified legend, those guys are brought up in a tree-nursery.</p>",
                
          },

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 16,
          :effectiveness => {
            
            :unitcategory_infantry => 1,
  
            :unitcategory_cavalry => 1.2,
  
            :unitcategory_artillery => 0.92,
  
            :unitcategory_siege => 0.8,
                
          },
          :attack      => 18,
          :armor       => 14,
          :hitpoints   => 100,

          :overrunnable => true,

          :critical_hit_damage => 2,
          :critical_hit_chance => 0.02,

          :production_time => '2700',

          :costs      => {
            1 => '60',
            0 => '120',
            2 => '90',
            
          },

          :requirements=> [
            
            {
              :symbolic_id => 'building_barracks',
              :id => 8,
              :type => 'building',

              :min_level => 11,

            },

          ],          


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
          :flavour     => {
            
            :en_US => "<p>Kills opposing units.</p>",
  
            :de_DE => "<p>Kämpft gegen andere Einheiten.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Große Steine, kleine Steine, ein Kieselsteinwerfer mag sie alle, solange er sie jemandem an den Kopf werfen kann. Ok, zugegeben, die kleinen mag er ein bisschen lieber. Nichtsdestotrotz kann er moderaten kritischen Schaden zufügen - denn, wie jeder weiß, das kann auch ins Auge gehen.</p>",
  
            :en_US => "<p>Small Stones, big Stones, a Peeble Thrower likes them all, as long as he can throw them at people. Ok, granted, the small ones are slightly prefered... Nevertheless, he may inflict moderate critical damage by sometimes hitting an opponent's eye.'</p>",
                
          },

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 8,
          :effectiveness => {
            
            :unitcategory_infantry => 1.2,
  
            :unitcategory_cavalry => 0.92,
  
            :unitcategory_artillery => 1,
  
            :unitcategory_siege => 0.8,
                
          },
          :attack      => 17,
          :armor       => 12,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 5,
          :critical_hit_chance => 0.02,

          :production_time => '3600',

          :costs      => {
            1 => '90',
            0 => '45',
            2 => '67',
            
          },


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
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Der Umgang mit der Waffe ist schnell gelernt: Das spitze Ende muss nach vorn!</p><p>Richtig angewendet tropfen fettige Flüssigkeiten vom Spieß, genau genommen das Blut seiner Feinde</p>",
  
            :en_US => "<p>Skewer Crew training 101: stick'em with the pointy end!</p><p>Greasy liquids are dripping from the spits, correctly used it is the enemies‘ blood.</p>",
                
          },

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 15,
          :effectiveness => {
            
            :unitcategory_infantry => 0.9,
  
            :unitcategory_cavalry => 1.2,
  
            :unitcategory_artillery => 0.6,
  
            :unitcategory_siege => 0.6,
                
          },
          :attack      => 16,
          :armor       => 3,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 11,
          :critical_hit_chance => 0.01,

          :production_time => '300',

          :costs      => {
            1 => '2',
            0 => '10',
            2 => '4',
            
          },

          :requirements=> [
            
            {
              :symbolic_id => 'building_firing_range',
              :id => 13,
              :type => 'building',

              :min_level => 21,

            },

          ],          


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
          :flavour     => {
            
            :en_US => "<p>Kills opposing units.</p>",
  
            :de_DE => "<p>Kämpft gegen andere Einheiten.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Strauße sind nicht nur lecker sondern auch gute und schnelle Kämpfer. Die Straußenreiter sind äußerst schnell, dafür aber nur schwach gepanzert.</p>",
  
            :en_US => "<p>Ostrichs are not only delicious but also excellent and fast animals to be used in combats. Ostrich riders are very quick, but only lightly armored.</p>",
                
          },

          :velocity    => 1.5,
          :action_points => 4,
          :initiative  => 26,
          :effectiveness => {
            
            :unitcategory_infantry => 0.92,
  
            :unitcategory_cavalry => 1,
  
            :unitcategory_artillery => 1.2,
  
            :unitcategory_siege => 0.8,
                
          },
          :attack      => 19,
          :armor       => 14,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 6,
          :critical_hit_chance => 0.02,

          :production_time => '5400',

          :costs      => {
            1 => '140',
            0 => '70',
            2 => '100',
            
          },


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
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Viele fürchten die Reittiere mehr als die eigentlichen Reiter...</p>",
  
            :en_US => "<p>It's not so much the riders themselves that are feared...</p>",
                
          },

          :velocity    => 1.4,
          :action_points => 4,
          :initiative  => 28,
          :effectiveness => {
            
            :unitcategory_infantry => 0.4,
  
            :unitcategory_cavalry => 0.6,
  
            :unitcategory_artillery => 1,
  
            :unitcategory_siege => 0.4,
                
          },
          :attack      => 21,
          :armor       => 15,
          :hitpoints   => 140,

          :overrunnable => true,

          :critical_hit_damage => 14,
          :critical_hit_chance => 0.02,

          :production_time => '300',

          :costs      => {
            1 => '2',
            0 => '10',
            2 => '4',
            
          },

          :requirements=> [
            
            {
              :symbolic_id => 'building_stud',
              :id => 14,
              :type => 'building',

              :min_level => 11,

            },

          ],          


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
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Nur wenige wissen, dass der Name Rammbock von einem prähistorischen Tier aus der Unterfamilie der ziegenartigen (caprinae) abstammt.</p>",
  
            :en_US => "<p>The battering ram is the lockpick of choice to open doors, gates and cracking down fortifications.</p>",
                
          },

          :velocity    => 0.9,
          :action_points => 4,
          :initiative  => 16,
          :effectiveness => {
            
            :unitcategory_infantry => 0.2,
  
            :unitcategory_cavalry => 0.1,
  
            :unitcategory_artillery => 0.2,
  
            :unitcategory_siege => 1,
                
          },
          :attack      => 15,
          :armor       => 0,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 2,
          :critical_hit_chance => 0.01,

          :production_time => '300',

          :costs      => {
            1 => '2',
            0 => '10',
            2 => '4',
            
          },


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
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Das Basismodell 'Catabilly' zum selber zusammenbauen, unschlagbar günstig.</p>",
  
            :en_US => "<p>The catapults take the cake in every intense battle because of their devastating damage.</p>",
                
          },

          :velocity    => 0.7,
          :action_points => 4,
          :initiative  => 16,
          :effectiveness => {
            
            :unitcategory_infantry => 0.2,
  
            :unitcategory_cavalry => 0.1,
  
            :unitcategory_artillery => 0.2,
  
            :unitcategory_siege => 1,
                
          },
          :attack      => 15,
          :armor       => 0,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 2,
          :critical_hit_chance => 0.01,

          :production_time => '300',

          :costs      => {
            1 => '2',
            0 => '10',
            2 => '4',
            
          },

          :requirements=> [
            
            {
              :symbolic_id => 'building_workshop',
              :id => 15,
              :type => 'building',

              :min_level => 11,

            },

          ],          


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
          :flavour     => {
            
            :en_US => "<p>Don't talk, fight.</p>",
  
            :de_DE => "<p>Reden nicht, handeln. Äh, schlagen.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Wilder Vormenschenstamm.</p>",
  
            :en_US => "<p>Fierce Fighters.</p>",
                
          },

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 16,
          :effectiveness => {
            
            :unitcategory_infantry => 1.0,
  
            :unitcategory_cavalry => 0.8,
  
            :unitcategory_artillery => 1.0,
  
            :unitcategory_siege => 1.0,
                
          },
          :attack      => 15,
          :armor       => 0,
          :hitpoints   => 90,

          :overrunnable => true,

          :critical_hit_damage => 2,
          :critical_hit_chance => 0.01,

          :production_time => '1200',

          :costs      => {
            1 => '40',
            0 => '20',
            2 => '12',
            
          },

          :requirements=> [
            
            {
              :symbolic_id => 'building_stud',
              :id => 14,
              :type => 'building',

              :min_level => 100,

            },

          ],          


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
          :flavour     => {
            
            :en_US => "<p>Kills opposing units.</p>",
  
            :de_DE => "<p>Je hübscher die Schleuder, desto tödlicher auch der Steinschleuderer. Ursache hierfür ist weniger die Schleuder als die natürliche Selektion unter den Steinschleuderern. Wer hat die schönste Schleuder? Die Überlebenden!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Der Steinschleuderer trägt eine große Lederschleuder. Mit Hilfe dieser Schleuder schleudert der Steinschleuderer dem Gegner Steine entgegen.</p><p>Ausschlaggebend für die Zielsicherheit ist dabei zum einen die Technik. Zwei bis drei Schwünge und dann am Scheitelpunkt mit einem Ruck den Stein schleudern. Zum anderen - und dies behaupten vor allem die Anfänger- ist die Art der Schleuder wichtig. Hochwertigere Ledersorten mit einer einwandfreien Verarbeitung und schönen Verzierungen treffen besser.</p><p>Viele Tests konnten dies nicht belegen, dennoch sind die hochwertig verzierten Schleudern eine begehrte Beute. Sowohl beim Gegner als auch bei den eigenen Steinschleuderern.</p>",
  
            :en_US => "<p>Small Stones, big Stones, a Peeble Thrower likes them all, as long as he can throw them at people. Ok, granted, the small ones are slightly prefered... Nevertheless, he may inflict moderate critical damage by sometimes hitting an opponent's eye.'</p>",
                
          },

          :velocity    => 1,
          :action_points => 4,
          :initiative  => 8,
          :effectiveness => {
            
            :unitcategory_infantry => 1.2,
  
            :unitcategory_cavalry => 0.92,
  
            :unitcategory_artillery => 1,
  
            :unitcategory_siege => 0.8,
                
          },
          :attack      => 19,
          :armor       => 13,
          :hitpoints   => 100,

          :overrunnable => true,

          :critical_hit_damage => 8,
          :critical_hit_chance => 0.03,

          :production_time => '8100',

          :costs      => {
            1 => '135',
            0 => '90',
            2 => '180',
            
          },

          :requirements=> [
            
            {
              :symbolic_id => 'building_firing_range',
              :id => 13,
              :type => 'building',

              :min_level => 11,

            },

          ],          


        },              #   END OF Slingshot Warrior
        {               #   Babysaurus
          :id          => 10, 
          :symbolic_id => :babysaurus,
					:category    => 1,
          :db_field    => :unit_babysaurus,
          :name        => {
            
            :en_US => "Babysaurus",
  
            :de_DE => "Babysaurus",
                
          },
          :flavour     => {
                          
          },
          :description => {
            
            :de_DE => "<p>Die Babysaurier haben noch keine spitzen Zähne, man kann zwar besser auf ihnen reiten, aber der Reiter muss dafür selbst die Keule schwingen.</p>",
  
            :en_US => "<p>Babysaurus's teeth are not sharp. They are easy to ride but their rider has to kill his enemies himself.</p>",
                
          },

          :velocity    => 1.5,
          :action_points => 4,
          :initiative  => 26,
          :effectiveness => {
            
            :unitcategory_infantry => 0.92,
  
            :unitcategory_cavalry => 1,
  
            :unitcategory_artillery => 1.2,
  
            :unitcategory_siege => 0.8,
                
          },
          :attack      => 17,
          :armor       => 13,
          :hitpoints   => 80,

          :overrunnable => true,

          :critical_hit_damage => 4,
          :critical_hit_chance => 0.01,

          :production_time => '2400',

          :costs      => {
            1 => '50',
            0 => '70',
            2 => '35',
            
          },

          :requirements=> [
            
            {
              :symbolic_id => 'building_stud',
              :id => 14,
              :type => 'building',

              :min_level => 1,

            },

          ],          


        },              #   END OF Babysaurus
      ],                # END OF UNIT TYPES

  
      :building_categories => [  # ALL BUILDING CATEGORIES

        {               #   Fortification
          :id          => 0, 
          :symbolic_id => :building_category_fortress_main,
          :name        => {
            
            :en_US => "Fortification",
  
            :de_DE => "Festungsanlagen",
                
          },
          :description => {
            
            :de_DE => "<p>Allgemeine Verbesserungen, die in Festungen gebaut werden können.</p>",
  
            :en_US => "<p>Improvements to be build in fortresses.</p>",
                
          },

        },              #   END OF Fortification
        {               #   Towers
          :id          => 1, 
          :symbolic_id => :building_category_fortress_tower,
          :name        => {
            
            :en_US => "Towers",
  
            :de_DE => "Türme",
                
          },
          :description => {
            
            :de_DE => "<p>In Türmen untergebrachte militärische Verbesserungen von Festungen.</p>",
  
            :en_US => "<p>Towers that extend the military abilities of fortresses.</p>",
                
          },

        },              #   END OF Towers
        {               #   Defensive Barricade 
          :id          => 2, 
          :symbolic_id => :building_category_wall,
          :name        => {
            
            :en_US => "Defensive Barricade ",
  
            :de_DE => "Verteidigungswall",
                
          },
          :description => {
            
            :de_DE => "<p>Grundlegende Verteidigungseinrichtung einer jeden Siedlung.</p>",
  
            :en_US => "<p>Fundamental defensive building of any settlement.</p>",
                
          },

        },              #   END OF Defensive Barricade 
        {               #   Large Buildings
          :id          => 3, 
          :symbolic_id => :building_category_large_building,
          :name        => {
            
            :en_US => "Large Buildings",
  
            :de_DE => "Große Gebäude",
                
          },
          :description => {
            
            :de_DE => "<p>Wichtige Gebäude, die eine große Grundfläche benötigen.</p>",
  
            :en_US => "<p>Advanced buildings that must be build on a large lot.</p>",
                
          },

        },              #   END OF Large Buildings
        {               #   Standard Buildings
          :id          => 4, 
          :symbolic_id => :building_category_small_building,
          :name        => {
            
            :en_US => "Standard Buildings",
  
            :de_DE => "Einfache Gebäude",
                
          },
          :description => {
            
            :de_DE => "<p>Grundlegende Gebäude, die überall, auf großen und kleinen Bauplätzen, gebaut werden können.</p>",
  
            :en_US => "<p>Fundamental buildings of any settlement that can be build on large as well as small lots.</p>",
                
          },

        },              #   END OF Standard Buildings
      ],                # END OF BUILDING CATEGORIES

# ## BUILDING TYPES ##########################################################
  
      :building_types => [  # ALL BUILDING TYPES

        {               #   Festungsanlagen
          :id          => 0, 
          :symbolic_id => :building_fortress_fortification,
					:category    => 0,
          :db_field    => :building_fortress_fortification,
          :name        => {
            
            :de_DE => "Festungsanlagen",
  
            :en_US => "Fortifications",
                
          },
          :flavour     => {
            
            :en_US => "<p>The fortification is controlling the region. Therefore armed forces are deployed to collect empathically the taxes and in case of attacks to protect the fortress. Prepare for battle!</p>",
  
            :de_DE => "<p>Die Festung beherrscht die Region. Dafür werden Truppen aufgestellt, die die Steuern der Siedlungen eintreiben und die Festung vor Angriffen beschützen. </p>",
                
          },
          :description => {
            
            :de_DE => "<p>Ein paar aufgetürmte Steinbrocken, zusammengebundene Baumstämme, ein provisorisches Tor. Fertig ist die Festung. Die Festungsanlagen bestehen aus einen Hauptgebäude, einem kleinen Versammlungsplatz und Mauern zur Verteidigung.</p><p>Die Festung beschleunigt alle anderen Gebäudeausbauten und erhöht die Wehrhaftigkeit. Mit fortschreitendem Ausbau wird auch die maximale Größe der Garnisson erhöht.</p>",
  
            :en_US => "<p>Some debris, tied tree trunks, a provisional gate, small parade-ground, main building and some walls; rudimentary stronghold finished. Improving the fortification results in a higher maximum size of the garrison, speeding-up all other construction sites and increases the defensive abilities.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,

          :costs      => {
            1 => 'FLOOR(30*POW(LEVEL,2.95)*(10*POW(LEVEL,-0.7))+0.5)',
            0 => 'FLOOR(30*POW(LEVEL,2.95)*(10*POW(LEVEL,-0.7))+0.5)',
            2 => 'FLOOR(((MIN(LEVEL,3)-MIN(LEVEL,2))*30*POW(LEVEL,2.95))*0.5*(10*POW(LEVEL,-0.7))+0.5)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(293.33*POW(LEVEL,3)-1760*POW(LEVEL,2)+3286.7*LEVEL-1760)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(6*POW(LEVEL,4.3)+250*LEVEL))*(10*POW(LEVEL,-0.7))+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 0,
                :queue_type_id_sym => :queue_buildings,
                :domain            => :settlement,
                :speedup_formula   => "2*FLOOR(1.88*POW(LEVEL,1.425)+0.5)/100.0",
              },

            ],

            :unlock_queue => [

              {
                :queue_type_id     => 0,
                :queue_type_id_sym => :queue_buildings,
                :level             => 1,
              },

            ],

            :unlock_garrison => 1,            

            :command_points => "1",
    
          },

        },              #   END OF Festungsanlagen
        {               #   Truppenunterkunft
          :id          => 1, 
          :symbolic_id => :building_infantry_tower,
					:category    => 1,
          :db_field    => :building_infantry_tower,
          :name        => {
            
            :de_DE => "Truppenunterkunft",
  
            :en_US => "Vertical Barracks",
                
          },
          :flavour     => {
            
            :en_US => "<p>Hooray! Strike first then talk, is the overall principle the instructors drum into the recruits‘ brains.</p>",
  
            :de_DE => "<p>Hier ist kein Platzer für Denker! Kraft und Ausdauer braucht ein Nahkämpfer, egal ob er mit Knüppel, Keule oder Speer bewaffnet ist.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Im Turm der Infanterie werden die Nahkämpfer in der Kunst des Kampfes unterwiesen. Der überaus sadistische Ausbilder legt höchsten Wert auf Gehorsam und Disziplin.</p><p>Wer den Befehlen nicht gehorcht, oder sich im Training noch dümmer anstellt als die anderen, der muss im Turm der Reitmeisterei putzen. Wer es zurück schafft, kämpft anschließend mit deutlich größerem Elan.</p>",
  
            :en_US => "<p>Training center for close combat warriors. Without the infantry every army becomes useless - and this is the place where the backbone of every stone-aged and postmodern army composition gets finishing. Reckless. Ruthless. Relentless.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 0,
              :type => 'building',

              :min_level => 2,

            },

          ],          

          :costs      => {
            1 => 'FLOOR(((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(132*POW(LEVEL,2)-543*LEVEL+520))*3*(10*POW(LEVEL,-0.7))+0.5)',
            0 => 'FLOOR(((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(132*POW(LEVEL,2)-543*LEVEL+520))*1.5*(10*POW(LEVEL,-0.7))+0.5)',
            2 => 'FLOOR((MIN(LEVEL,3)-MIN(LEVEL,2))*((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(132*POW(LEVEL,2)-543*LEVEL+520))*0.5*(10*POW(LEVEL,-0.7))+0.5)',
            3 => 'MAX(LEVEL-9,0)',
            
          },

          :production_time => 'FLOOR((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*19.5*POW(LEVEL,3.6)*3*(10*POW(LEVEL,-0.7))+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 2,
                :queue_type_id_sym => :queue_infantry,
                :domain            => :settlement,
                :speedup_formula   => "FLOOR(1.88*POW(LEVEL,1.425)*0.5+0.5)/100.0",
              },

            ],

            :unlock_queue => [

              {
                :queue_type_id     => 2,
                :queue_type_id_sym => :queue_infantry,
                :level             => 1,
              },

            ],
    
          },

        },              #   END OF Truppenunterkunft
        {               #   Turm der Ballistik
          :id          => 2, 
          :symbolic_id => :building_artillery_tower,
					:category    => 1,
          :db_field    => :building_artillery_tower,
          :name        => {
            
            :de_DE => "Turm der Ballistik",
  
            :en_US => "Ballistic Tower",
                
          },
          :flavour     => {
            
            :en_US => "<p>Everything which can be shoot flies around here. So, watch yourself and duck in time! Training of long-range combat fighter is in progress.</p>",
  
            :de_DE => "<p>Hier fliegt alles was man werfen oder abschießen kann! Kopf runter! Die Ausblidung der Fernkämpfer ist in vollem Gang.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Von Außen betrachtet ist der Turm der Ballistik eine Augenweide. Von Innen betrachtet ist der Turm ein Trümmerfeld. Kleine Kieselsteine liegen auf dem ganzen Boden verteilt, Bratspieße, Speere und Pfeile haben sich in sämtliche Stützpfeiler gebort und an den Wänden spuren hinterlassen.</p><p>Nicht weiter verwunderlich ist da die Helmpflicht. Die Ausbilder und Auszubildende haben sich feste Tierhäute um den Kopf gebunden, damit sie den Aufprall kleiner Steinen oder Splittern halbwegs überstehen.</p><p>Verglichen mit der Ordnung einer Artillerie-Kampfreihe auf dem Schlachtfeld ist das herrschende Chaos überraschend. Auf ein Kommando werden alle Arten von Wurfgeschossen in die Luft gesandt, nur leider wissen die Wenigsten auf welches Kommando sie eigentlich gerade achten sollen.</p>",
  
            :en_US => "<p>Trains artillery.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 0,
              :type => 'building',

              :min_level => 6,

            },

          ],          

          :costs      => {
            1 => 'FLOOR(((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(132*POW(LEVEL,2)-543*LEVEL+520))*1.5*(10*POW(LEVEL,-0.7))+0.5)',
            0 => 'FLOOR(((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(132*POW(LEVEL,2)-543*LEVEL+520))*3*(10*POW(LEVEL,-0.7))+0.5)',
            2 => 'FLOOR((MIN(LEVEL,3)-MIN(LEVEL,2))*((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(132*POW(LEVEL,2)-543*LEVEL+520))*0.5*(10*POW(LEVEL,-0.7))+0.5)',
            3 => 'MAX(LEVEL-9,0)',
            
          },

          :production_time => 'FLOOR((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*19.5*POW(LEVEL,3.6)*3*(10*POW(LEVEL,-0.7))+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 3,
                :queue_type_id_sym => :queue_artillery,
                :domain            => :settlement,
                :speedup_formula   => "FLOOR(1.88*POW(LEVEL,1.425)*0.5+0.5)/100.0",
              },

            ],

            :unlock_queue => [

              {
                :queue_type_id     => 3,
                :queue_type_id_sym => :queue_artillery,
                :level             => 1,
              },

            ],
    
          },

        },              #   END OF Turm der Ballistik
        {               #   Turm der Reitmeisterrei
          :id          => 3, 
          :symbolic_id => :building_cavalry_tower,
					:category    => 1,
          :db_field    => :building_cavalry_tower,
          :name        => {
            
            :de_DE => "Turm der Reitmeisterrei",
  
            :en_US => "Cavalry Tower",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>Ermöglicht und beschleunigt die Ausbildung von berittenen Einheiten. Vorsicht vor Dung und penetrantem Geruch!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Der Turm der Reitmeisterei dient zur Ausbildung aller berittenen Einheiten. Dabei wird der Wert vor allem auf den Umgang mit den Tieren wie auch die Reittechnik gelegt.</p><p>Der Zutritt ist streng begrenzt auf ausgebildete Reiter und Tierpfleger. Wenn das Tor der Reitmeisterei kurzzweitig offen steht, schleichen sich oftmals neugierige halbstarke Jungs hinein. Die Tierpfleger entsorgen die blutige Kleidung ohne großes Aufhebens.</p>",
  
            :en_US => "<p>Training center for all mounted units. Horse-back riding is not vanilla, so, 101-riding courses, how to put spur on horses and domesticating them; all this is done here.</p><p>Access is only granted to equestrians and zookeepers.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 0,
              :type => 'building',

              :min_level => 4,

            },

          ],          

          :costs      => {
            1 => 'FLOOR(((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(132*POW(LEVEL,2)-543*LEVEL+520))*3*(10*POW(LEVEL,-0.7))+0.5)',
            0 => 'FLOOR(((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(132*POW(LEVEL,2)-543*LEVEL+520))*1.5*(10*POW(LEVEL,-0.7))+0.5)',
            2 => 'FLOOR(((MIN(LEVEL,3)-MIN(LEVEL,2))*((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(132*POW(LEVEL,2)-543*LEVEL+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*8032/2.6*POW(2.71828,0.0953*LEVEL)))*0.5*(10*POW(LEVEL,-0.7))+0.5)',
            3 => 'MAX(LEVEL-9,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)+(MIN(LEVEL,11)-MIN(LEVEL,10))*950*POW(LEVEL,2))*3*(10*POW(LEVEL,-0.7))+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 4,
                :queue_type_id_sym => :queue_cavalry,
                :domain            => :settlement,
                :speedup_formula   => "FLOOR(1.88*POW(LEVEL,1.425)*0.5+0.5)/100.0",
              },

            ],

            :unlock_queue => [

              {
                :queue_type_id     => 4,
                :queue_type_id_sym => :queue_cavalry,
                :level             => 1,
              },

            ],
    
          },

        },              #   END OF Turm der Reitmeisterrei
        {               #   Turm der Tüftler
          :id          => 4, 
          :symbolic_id => :building_siege_tower,
					:category    => 1,
          :db_field    => :building_siege_tower,
          :name        => {
            
            :de_DE => "Turm der Tüftler",
  
            :en_US => "Inventor Tower",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>Für Tüftler zählt keine Muskelkraft, unglaubliche Kriegsmaschinene werden nur von unglaublichen Nerds erdacht. Ab und zu sind die Belagerungsmaschinen sogar brauchbar.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Der Turm der Tüftler ist ein Ort der Stille, die nur durch kurze Hämmerschläge oder leisem Geflüster unterbrochen wird.</p><p>An den Wänden hängen Skizzen, Pläne und unvollendete Entwürfe. Die Tüftler sehen sich als Elite, da sie als einzige ihr Gehirn für ihre Arbeit einsetzen.</p><p>Die anderen Krieger halten die Tütfler natürlich für Idioten, die nur in ihrem Turm eingesperrt werden, damit sie nicht im Weg rumstehen.</p>",
  
            :en_US => "<p>Training center for war machine engineers. Thinking of themselves as the pinnacle of all men at arms, the war machine engineers dedicate their life to invent mechanical constructions independent of muscles and man power. This place is a mess with countless blueprints for all sorts of siege-weapons.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'building_fortress_fortification',
              :id => 0,
              :type => 'building',

              :min_level => 21,

            },

          ],          

          :costs      => {
            1 => 'FLOOR((132*POW(10,2)-543*10+520)*1.5*2*(1+(0.94*POW(LEVEL,1.425)/100.0))+0.5)',
            0 => 'FLOOR((132*POW(10,2)-543*10+520)*3*2*(1+(0.94*POW(LEVEL,1.425)/100.0))+0.5)',
            2 => 'FLOOR((132*POW(10,2)-543*10+520)*0.75*2*(1+(0.94*POW(LEVEL,1.425)/100.0))+0.5)',
            3 => 'MAX(LEVEL-9,0)',
            
          },

          :production_time => 'FLOOR(19.5*POW(10,3.6)*3*2*(1+(0.94*POW(LEVEL,1.425)/100.0))+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 5,
                :queue_type_id_sym => :queue_siege,
                :domain            => :settlement,
                :speedup_formula   => "0.5*0.5*FLOOR(1+0.94*POW(LEVEL,1.425)+0.5)/100.0",
              },

            ],

            :unlock_queue => [

              {
                :queue_type_id     => 5,
                :queue_type_id_sym => :queue_siege,
                :level             => 1,
              },

            ],
    
          },

        },              #   END OF Turm der Tüftler
        {               #   Häuptlingshütte
          :id          => 5, 
          :symbolic_id => :building_chief_cottage,
					:category    => 3,
          :db_field    => :building_chief_cottage,
          :name        => {
            
            :de_DE => "Häuptlingshütte",
  
            :en_US => "Chieftain‘s Hall",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>Hier werden die Entscheidungen getroffen! Je größer die Häuptlingshütte desto mehr Gebäude können gebaut werden.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Die allererste Hütte in der Siedlung eghört natürlich dem Häuptling. Zu Beginn nicht mehr als ein undichtes Dach über dem Kopf wird die Hütte bald zu einer repräsentativen Halle.</p><p>Zeichen der Triumpfe, Banner und ausgestelltes Beutegut zieren die Halle. Gerüchte sprechen auch von ausschweifenden Orgien.</p>",
  
            :en_US => "<p>At start it is more a hut or but later an area to represent the chieftain‘s glory, advancement and power.</p><p>Symbols of triumph, the banners and iconic loot is shown off here. Rumor has it that the chieftain uses his hall for excessive orgies from time to time!</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> false,
          :destructable=> false,

          :requirements=> [
            
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

          ],          

          :costs      => {
            1 => 'FLOOR(30*POW(LEVEL-1,2.95)*0.5+0.5)',
            0 => 'FLOOR(30*POW(LEVEL-1,2.95)*0.5+0.5)',
            2 => 'FLOOR(((MIN(LEVEL,3)-MIN(LEVEL,2))*30*POW(LEVEL-1,2.95))*0.5*0.5+0.5)',
            
          },

          :production_time => '(MAX(LEVEL+1,1)-MAX(LEVEL,2))*FLOOR(((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(293.33*POW(LEVEL-1,3)-1760*POW(LEVEL-1,2)+3286.7*(LEVEL-1)-1760)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(6*POW(MAX(LEVEL-2,0),4.3)+250*(LEVEL-1)))+0.5)',
          :production  => [
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_stone,
                :formula            => "2",
              },
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :unlock_queue => [

              {
                :queue_type_id     => 0,
                :queue_type_id_sym => :queue_buildings,
                :level             => 1,
              },

            ],

            :unlock_garrison => 2,            

            :command_points => "2+1*(MIN(LEVEL,15)-MIN(LEVEL,14))",
    
          },

        },              #   END OF Häuptlingshütte
        {               #   Jäger und Sammler
          :id          => 6, 
          :symbolic_id => :building_gatherer,
					:category    => 4,
          :db_field    => :building_gatherer,
          :name        => {
            
            :de_DE => "Jäger und Sammler",
  
            :en_US => "Hunter-Gatherer",
                
          },
          :flavour     => {
            
            :en_US => "<p>Collecs resources for the daily needs.</p>",
  
            :de_DE => "<p>Sammelt für Dich Holz und Steine, und ab Stufe 11 findet er sogar hin und wieder eine Kröte auf seinem Gelände, die zu langsam für seine schwerfälligen Füße ist.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Primitivster aller Steinzeiteinwohner. Ihr könnt frohe sein, ihn in eine Hütte bekommen zu haben. Manchmal bleibt er sogar für ein paar Stunden da.</p><p>Jedenfalls sammelt und jagt er alles, was ihm for die Flinte, äh, die Steinschleuder kommt. Auf seinem Gelände können die Stammesangehörigen alles finden, was sie zur Abdeckungen des täglichen Bedarfs benötigen; er findet alles von Knochen und Steinen über Wurzeln bis hin zu Kröten (natürlich nur bei ausreichend großem Gelände).</p>",
  
            :en_US => "<p>Hunting and gathering everything useful which comes in sight and is accordingly the collector of basic resources for the daily needs. He comes home with wood, stones and easily slain animals.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 1,

            },

          ],          

          :costs      => {
            1 => 'FLOOR(((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(132*POW(LEVEL,2)-543*LEVEL+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*8032/2.6*POW(2.71828,0.0953*LEVEL))/13+0.5)',
            0 => 'FLOOR(((MIN(LEVEL,2)-MIN(LEVEL,1))*((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(132*POW(LEVEL,2)-543*LEVEL+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*8032/2.6*POW(2.71828,0.0953*LEVEL)))/13+0.5)',
            2 => 'FLOOR(((MIN(LEVEL,2)-MIN(LEVEL,1))*((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(132*POW(LEVEL,2)-543*LEVEL+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*8032/2.6*POW(2.71828,0.0953*LEVEL)))/72+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)+(MIN(LEVEL,11)-MIN(LEVEL,10))*950*POW(LEVEL,2))/1.5+0.5)',
          :production  => [
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_stone,
                :formula            => "FLOOR(7.5/4*POW(LEVEL,1.33)+0.5)",
              },
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_wood,
                :formula            => "FLOOR(7.5/4*POW(LEVEL,1.33)+0.5)",
              },
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "FLOOR(7.5/8*POW(LEVEL,1.33)+0.5)",
              },
            
              {
                :id                 => 3,
                :symbolic_id        => :resource_cash,
                :formula            => "(MIN(LEVEL,11)-MIN(LEVEL,10))*1/48+(MIN(LEVEL,20)-MIN(LEVEL,19))*1/48",
              },
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {
    
          },

        },              #   END OF Jäger und Sammler
        {               #   Kleine Hütte
          :id          => 7, 
          :symbolic_id => :building_cottage,
					:category    => 4,
          :db_field    => :building_cottage,
          :name        => {
            
            :de_DE => "Kleine Hütte",
  
            :en_US => "Small Hut",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>In den kleinen Hütten leben Eure Untertanen. Je mehr Untertanen desto schneller geht auch der Ausbau von Gebäuden.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Die kleine Hütte schützt eure Untertanen vor Sonne und Regen. Solange ihr alles habt, brauchen eure Untertanen natürlich auch nicht mehr.</p>",
  
            :en_US => "<p>Provides shelter for your subjects. No-one is as demanding as you are, so your people only need basic fit-outs inside their own four walls.</p><p>Your grace and foreseeing leadership is fullfilling all their needs of luxury. The good old times!</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 2,

            },

          ],          

          :costs      => {
            1 => 'FLOOR((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(3.6926*POW(2.71828,0.8021*LEVEL)/2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*(5270*POW(2.71828,0.097*LEVEL)/2.58))',
            0 => 'FLOOR((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(3.6926*POW(2.71828,0.8021*LEVEL)/2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*(5270*POW(2.71828,0.097*LEVEL)/2.58))',
            2 => 'FLOOR(((MIN(LEVEL+1,11)-MIN(LEVEL,11))*(3.6926*POW(2.71828,0.8021*LEVEL)/2)+(MIN(LEVEL,11)-MIN(LEVEL,10))*(5270*POW(2.71828,0.097*LEVEL)/2.58))*1.2)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)+(MIN(LEVEL,11)-MIN(LEVEL,10))*950*POW(LEVEL,2))+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 0,
                :queue_type_id_sym => :queue_buildings,
                :domain            => :settlement,
                :speedup_formula   => "FLOOR(1.88*POW(LEVEL,1.425)*1.5+0.5)/100.0",
              },

            ],
    
          },

        },              #   END OF Kleine Hütte
        {               #   Ausbildungsgelände
          :id          => 8, 
          :symbolic_id => :building_barracks,
					:category    => 4,
          :db_field    => :building_barracks,
          :name        => {
            
            :de_DE => "Ausbildungsgelände",
  
            :en_US => "Barracks",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>Auf der Suche nach einem kleinen Kampf, lange nicht mehr verprügelt worden? Im Ausbildungsgelände werden die Nahkämpfer ausgebildet, die Freund und Feind gerne mal eine verpassen.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Auf dem Ausbildungsgelände werden alle Arten von Nahkämpfern ausgebildet. Große Keule, Bratspieß oder doch die bloßen Fäuste, alles ist erlaubt.</p><p>In zahlreichen Wettbewerben messen sich die kommenden Krieger um sich im Zweikampf zu stählen. Einmal im Mondumlauf wird ein öffentliches Turnier veranstaltet. Der Sieger bekommt alles. Ruhm, Essen, einen Tag frei und Männer soviel sie wollen. Ja Männer, denn zumeist gewinnt eine Frau diese Turnier. Wie? Mit den Waffen eine Frau natürlich, und die sind tödlich!</p>",
  
            :en_US => "<p>Training facility for all kinds of groud units and also hosts troops. It has its own drill ground and from to time to time you can see magnificient parades.</p><p>Don´t get mistaken for one of the punching dummies or you won´t leave the barracks alive! Training of beserkers is in progress.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 3,

            },

          ],          

          :costs      => {
            1 => 'FLOOR(((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(132*POW(LEVEL,2)-543*LEVEL+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*8032/2.6*POW(2.71828,0.0953*LEVEL))*3+0.5)',
            0 => 'FLOOR(((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(132*POW(LEVEL,2)-543*LEVEL+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*8032/2.6*POW(2.71828,0.0953*LEVEL))*1.5+0.5)',
            3 => '2*MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)+(MIN(LEVEL,11)-MIN(LEVEL,10))*950*POW(LEVEL,2))*3+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 2,
                :queue_type_id_sym => :queue_infantry,
                :domain            => :settlement,
                :speedup_formula   => "FLOOR(1.88*POW(LEVEL,1.425)+0.5)/100.0",
              },

            ],

            :unlock_queue => [

              {
                :queue_type_id     => 2,
                :queue_type_id_sym => :queue_infantry,
                :level             => 1,
              },

            ],
    
          },

        },              #   END OF Ausbildungsgelände
        {               #   Lagerfeuer
          :id          => 9, 
          :symbolic_id => :building_campfire,
					:category    => 4,
          :db_field    => :building_campfire,
          :name        => {
            
            :de_DE => "Lagerfeuer",
  
            :en_US => "Campfire",
                
          },
          :flavour     => {
            
            :en_US => "<p>Diplomatic bla-bla or alliance conferences can be held in the embassies. And a good conversation is not a monologue!</p>",
  
            :de_DE => "<p>Ort für Diplomatischer Austausch oder Allianzbesprechungen. Zu einer guten Unterhaltung gehören mindestens zwei. Auch wenn oft nur einer redet.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Das Lagerfeuer ist der Versammlungsort einer Siedlung und übernimmt in der Steinzeit auch die Rolle einer Botschaft.</p><p>Die freiwilligen und unfreiwilligen Gästen werden wahlweise ans Feuer gebeten oder am Marterfall aufgestellt.</p><p>Hier ist der Ort, um  Entsandte von benachbarten und weit entfernten Stämmen zu bewirten, Kontakte zu pflegen und die wichtigen Dinge zu besprechen. Hier ist aber auch der Ort, um an den gutgläubigen Entsandten oder eingefangenen Gegnern ein Exempel zu statuieren oder sie kurzerhand zu verspeisen.</p>",
  
            :en_US => "<p>Assembly area for the locals and also the district of foreign embassies. Random guests are normally invited to sit by the fire while hostile messengers get hammered at the stake.</p><p>The place to be in every settlement for networking and discussing the really important matters, like whether a stranger gets eaten alive or tickled to ecstasy.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 4,

            },

            {
              :symbolic_id => 'building_campfire',
              :id => 9,
              :type => 'building',

              :min_level => 0,

              :max_level => 0,

            },

          ],          

          :costs      => {
            1 => 'FLOOR(((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(132*POW(LEVEL,2)-543*LEVEL+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*8032/2.6*POW(2.71828,0.0953*LEVEL))+0.5)',
            0 => 'FLOOR(((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(132*POW(LEVEL,2)-543*LEVEL+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*8032/2.6*POW(2.71828,0.0953*LEVEL))+0.5)',
            2 => 'FLOOR(((MIN(LEVEL,3)-MIN(LEVEL,2))*((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(132*POW(LEVEL,2)-543*LEVEL+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*8032/2.6*POW(2.71828,0.0953*LEVEL)))/2+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)+(MIN(LEVEL,11)-MIN(LEVEL,10))*950*POW(LEVEL,2))+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :unlock_diplomacy     => 1,

            :unlock_alliance_creation => 5,
    
          },

        },              #   END OF Lagerfeuer
        {               #   Holzfäller
          :id          => 10, 
          :symbolic_id => :building_logger,
					:category    => 4,
          :db_field    => :building_logger,
          :name        => {
            
            :de_DE => "Holzfäller",
  
            :en_US => "Lumberjack",
                
          },
          :flavour     => {
            
            :en_US => "<p>Wood! Even more wood!</p>",
  
            :de_DE => "<p>Ein Mann und seine Steinaxt! Neben losem Holz bringt er ab und zu sogar einen selbst gefällten Baum mit ins Lager.</p><p>Ab Level 11 bietet der Holfäller einen lokalen Holzbonus. Auf Level 11-19 beträgt dieser 1% je Level: 1-9%, bei Level 20 ist der Holzbonus 15%.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Unter Ausnutzung purer Gewalt aber auch modernster Steinwerkzeuge gelingt es dem Holzfäller mehr oder weniger große Stämme zu fällen und zu wertvollen Rohstoffen zu verarbeiten.</p>",
  
            :en_US => "<p>Specialized in cutting trees more efficiently than the gatherer and produces logs. Is by definition permanently competing with the quarry man.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 5,

            },

          ],          

          :costs      => {
            1 => 'FLOOR(((MIN(LEVEL,3)-MIN(LEVEL,2))*((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(132*POW(LEVEL,2)-543*LEVEL+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*8032/2.6*POW(2.71828,0.0953*LEVEL)))/2+0.5)',
            0 => 'FLOOR(((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(132*POW(LEVEL,2)-543*LEVEL+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*8032/2.6*POW(2.71828,0.0953*LEVEL))+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)+(MIN(LEVEL,11)-MIN(LEVEL,10))*950*POW(LEVEL,2))+0.5)',
          :production  => [
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_wood,
                :formula            => "FLOOR(7.5*POW(LEVEL,1.33)+0.5)",
              },
            
          ],
          :production_bonus  => [
            
              {
                :id                 => 0,
                :symbolic_id        => :resource_wood,
                :formula            => "MAX(LEVEL-10,0)*0.01+MAX(0,LEVEL-19)*0.05",
              },
            
          ],          

          :abilities   => {
    
          },

        },              #   END OF Holzfäller
        {               #   Steinbruch
          :id          => 11, 
          :symbolic_id => :building_quarry,
					:category    => 4,
          :db_field    => :building_quarry,
          :name        => {
            
            :de_DE => "Steinbruch",
  
            :en_US => "Quarry",
                
          },
          :flavour     => {
            
            :en_US => "<p>Stones, even more stones!</p>",
  
            :de_DE => "<p>Steine, nichts als Steine! Verschwitzte Arbeiter und der montone Schlag der schweren Werkzeuge. Genau was man von einem Steinbruch erwartet.</p><p>Ab Level 11 bietet der Steinbruch einen lokalen Steinbonus. Auf Level 11-19 beträgt dieser 1% je Level: 1-9%, bei Level 20 ist der Steinbonus 15%.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Durch eine komplizierte Kette von Arbeitsvorgängen (kompliziert in der Steinzeit), werden im Steinbruch Steine gewonnen. Größere Steinbrüche produzieren mehr Steine pro Stunde. Unglaublich, oder?</p>",
  
            :en_US => "<p>Specialized in rock cutting more efficiently than the gatherer and produces stones. It is still not clear, if lumberjacks and quarry men are akin to each other or not.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 5,

            },

          ],          

          :costs      => {
            1 => 'FLOOR(((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(132*POW(LEVEL,2)-543*LEVEL+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*8032/2.6*POW(2.71828,0.0953*LEVEL))+0.5)',
            0 => 'FLOOR(((MIN(LEVEL,3)-MIN(LEVEL,2))*((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(132*POW(LEVEL,2)-543*LEVEL+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*8032/2.6*POW(2.71828,0.0953*LEVEL)))/2+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)+(MIN(LEVEL,11)-MIN(LEVEL,10))*950*POW(LEVEL,2))+0.5)',
          :production  => [
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_stone,
                :formula            => "FLOOR(7.5*POW(LEVEL,1.33)+0.5)",
              },
            
          ],
          :production_bonus  => [
            
              {
                :id                 => 1,
                :symbolic_id        => :resource_stone,
                :formula            => "MAX(LEVEL-10,0)*0.01+MAX(0,LEVEL-19)*0.05",
              },
            
          ],          

          :abilities   => {
    
          },

        },              #   END OF Steinbruch
        {               #   Kürschner
          :id          => 12, 
          :symbolic_id => :building_furrier,
					:category    => 4,
          :db_field    => :building_furrier,
          :name        => {
            
            :de_DE => "Kürschner",
  
            :en_US => "Peltmonger",
                
          },
          :flavour     => {
            
            :en_US => "<p>The peltmonger is literally flaying all day long!</p>",
  
            :de_DE => "<p>Der Kürschner zieht dem Tier das Fell über die Ohren. Hier gibt es schöne Felle und hochwertige Lederwaren, dazu immer mal ein leckeres Tier auf dem Feuer.</p><p>Ab Level 11 bietet der Kürschner einen lokalen Fellonus. Auf Level 11-19 beträgt dieser 1% je Level: 1-9%, bei Level 20 ist der Fellbonus 15%.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Verarbeitet Häute zu Leder und hat manchmal auch ein paar schöne Säbelzahntigerfelle für die Dame von Welt im Angebot.</p>",
  
            :en_US => "<p>Manufacturing hides into leather. Sometimes there are also must-have sabre cat furs as ready-to-wear fashion for the lady or cosy brontosaurus regulation underwear.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 8,

            },

          ],          

          :costs      => {
            0 => 'FLOOR(((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(132*POW(LEVEL,2)-543*LEVEL+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*8032/2.6*POW(2.71828,0.0953*LEVEL))/2+0.5)',
            1 => 'FLOOR(((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(132*POW(LEVEL,2)-543*LEVEL+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*8032/2.6*POW(2.71828,0.0953*LEVEL))/2+0.5)',
            2 => 'FLOOR(((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(132*POW(LEVEL,2)-543*LEVEL+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*8032/2.6*POW(2.71828,0.0953*LEVEL))+0.5)',
            3 => 'MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)+(MIN(LEVEL,11)-MIN(LEVEL,10))*950*POW(LEVEL,2))*3+0.5)',
          :production  => [
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "FLOOR(7.5/2*POW(LEVEL,1.33)+0.5)",
              },
            
          ],
          :production_bonus  => [
            
              {
                :id                 => 2,
                :symbolic_id        => :resource_fur,
                :formula            => "MAX(LEVEL-10,0)*0.01+MAX(0,LEVEL-19)*0.05",
              },
            
          ],          

          :abilities   => {
    
          },

        },              #   END OF Kürschner
        {               #   Schießstand
          :id          => 13, 
          :symbolic_id => :building_firing_range,
					:category    => 4,
          :db_field    => :building_firing_range,
          :name        => {
            
            :de_DE => "Schießstand",
  
            :en_US => "Firing Range",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>Berufsziel Fernkämpfer? Kein Lust auf Prügeleien oder stinkende Tiere? Die schießwütigen Fernkämpfer finden sich hier wieder. Der sicherste Platz ist immer HINTER dem Schützen!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Das Ausbildungsgelände für Fernkämpfer. Steine, Speere und alles was man werfen oder schießen kann fliegt hier durch die Luft.</p><p>Zu schwächlich zum Führen einer Keule? Ein Kampf im Angesicht deines Gegners ist nicht dein Ding? Schließ dich der Artillerie an!</p>",
  
            :en_US => "<p>Training area for ranged units. Stones and javelins fill the air with a whiring buzz.</p><p>If some-one lacks courage to fight face-to-face, the firing range is the place to make a career in the army. Accidents that go pear-shaped are possible!</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 7,

            },

          ],          

          :costs      => {
            1 => 'FLOOR(((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(132*POW(LEVEL,2)-543*LEVEL+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*8032/2.6*POW(2.71828,0.0953*LEVEL))*1.5+0.5)',
            0 => 'FLOOR(((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(132*POW(LEVEL,2)-543*LEVEL+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*8032/2.6*POW(2.71828,0.0953*LEVEL))*3+0.5)',
            3 => '2*MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)+(MIN(LEVEL,11)-MIN(LEVEL,10))*950*POW(LEVEL,2))*3+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 3,
                :queue_type_id_sym => :queue_artillery,
                :domain            => :settlement,
                :speedup_formula   => "FLOOR(1.88*POW(LEVEL,1.425)+0.5)/100.0",
              },

            ],

            :unlock_queue => [

              {
                :queue_type_id     => 3,
                :queue_type_id_sym => :queue_artillery,
                :level             => 1,
              },

            ],
    
          },

        },              #   END OF Schießstand
        {               #   Stall
          :id          => 14, 
          :symbolic_id => :building_stud,
					:category    => 4,
          :db_field    => :building_stud,
          :name        => {
            
            :de_DE => "Stall",
  
            :en_US => "Stable",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>Stinkende Tiere und brüllende Ausbilder. Genau das bietet ein Stall bei der Ausbildung von Kavallerieeinheiten. Der Traum aller Pferdemädchen!</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Kein Ort in der Siedlung stinkt so sehr wie der Stall. Nicht weiter verwunderlich werden hier doch Straußen, Säbelzahntiger, kleine Dinosaurier und eine Katze gehalten.</p><p>Die Katze ist das einzige Wesen vor denen die Dinos Angst haben. Ihre Körperfülle entspricht ihre wichtigen Position.</p><p>Vorrangig werden die Tiere dressiert und den Reitern der richtige Umgang beigebracht. Die wenigsten Reiter führen im Kampf selber Waffen, zumeist ist das Reittier an sich die Waffe.</p>",
  
            :en_US => "<p>Hosts troops.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 9,

            },

          ],          

          :costs      => {
            1 => 'FLOOR(((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(132*POW(LEVEL,2)-543*LEVEL+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*8032/2.6*POW(2.71828,0.0953*LEVEL))*3+0.5)',
            0 => 'FLOOR(((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(132*POW(LEVEL,2)-543*LEVEL+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*8032/2.6*POW(2.71828,0.0953*LEVEL))*1.5+0.5)',
            2 => 'FLOOR(((MIN(LEVEL,3)-MIN(LEVEL,2))*((MIN(LEVEL+1,5)-MIN(LEVEL,5))*(40*POW(LEVEL,2)-80*LEVEL+60)+(MIN(LEVEL,5)-MIN(LEVEL,4))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*(132*POW(LEVEL,2)-543*LEVEL+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*8032/2.6*POW(2.71828,0.0953*LEVEL)))/2+0.5)',
            3 => '2*MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,4)-MIN(LEVEL,4))*(130*POW(LEVEL,2)-350*LEVEL+240)+(MIN(LEVEL,4)-MIN(LEVEL,3))*(MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(LEVEL,3.6)+(MIN(LEVEL,11)-MIN(LEVEL,10))*950*POW(LEVEL,2))*3+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 4,
                :queue_type_id_sym => :queue_cavalry,
                :domain            => :settlement,
                :speedup_formula   => "FLOOR(1.88*POW(LEVEL,1.425)+0.5)/100.0",
              },

            ],

            :unlock_queue => [

              {
                :queue_type_id     => 4,
                :queue_type_id_sym => :queue_cavalry,
                :level             => 1,
              },

            ],
    
          },

        },              #   END OF Stall
        {               #   Werkstatt
          :id          => 15, 
          :symbolic_id => :building_workshop,
					:category    => 3,
          :db_field    => :building_workshop,
          :name        => {
            
            :de_DE => "Werkstatt",
  
            :en_US => "Workshop",
                
          },
          :flavour     => {
            
            :en_US => "<p> lustiger Flavour Text hier </p>",
  
            :de_DE => "<p>In der Werkstatt werden Belagerungsgeräte hergestellt, zumindest wenn man den Häuptling fragt. Die Tüftler selbst stellen nach ihrer Meinung wahre Wunder her.</p>",
                
          },
          :description => {
            
            :de_DE => "<p>Die Werksatt wird von den meisten Bewohnern gemieden. Zum einen haben die Tütfler komische Verhaltensweisen und einen seltsamen Sinn für Humor, zum anderen ist hier die Gefahr bereits beim Eintritt in eine neuartige Falle oder ein unachtsam abgestelltes Testobjekt zu tappen sehr hoch.</p><p>Die Tüftler selbst sind gerne unter sich, lachen über Dinge wie den Großen Knall und basteln Tag ein Tag aus an ihren Geräten. Alle Mondumläufe stellen sie auf dem Platz vor dem Lagerfeuer ihre neusten Ideen vor.</p><p>Die Tüftler sind an diesem Tagen sehr angespannt, da hier über ihre weitere Karriere entschieden wird. Keine Entscheidung über Leben und Tod, aber bei einem Fehlschlag dürfen die Tüftler nicht weiterarbeiten. Und werden meist hingerichtet, aber das ist für den Tüftler das kleinere Übel</p>",
  
            :en_US => "<p>Hosts troops.</p>",
                
          },
          :hidden      => 0,

          :buyable     => true,
          :demolishable=> true,
          :destructable=> true,

          :requirements=> [
            
            {
              :symbolic_id => 'building_chief_cottage',
              :id => 5,
              :type => 'building',

              :min_level => 21,

            },

          ],          

          :costs      => {
            1 => 'FLOOR(((MIN(LEVEL+1,11)-MIN(LEVEL,10))*(132*POW(10,2)-543*10+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*950*POW(LEVEL,2))*1.5*(1+(0.94*POW(MAX(LEVEL,10),1.425)/100))+0.5)',
            0 => 'FLOOR(((MIN(LEVEL+1,11)-MIN(LEVEL,10))*(132*POW(10,2)-543*10+520)+(MIN(LEVEL,11)-MIN(LEVEL,10))*950*POW(LEVEL,2))*3*(1+(0.94*POW(MAX(LEVEL,10),1.425)/100))+0.5)',
            3 => '2*MAX(LEVEL-19,0)',
            
          },

          :production_time => 'FLOOR(((MIN(LEVEL+1,11)-MIN(LEVEL,11))*19.5*POW(10,3.6)+(MIN(LEVEL,11)-MIN(LEVEL,10))*950*POW(LEVEL,2))*3*(1+(0.94*POW(MAX(LEVEL,10),1.425)/100.0))+0.5)',
          :production  => [
            
          ],
          :production_bonus  => [
            
          ],          

          :abilities   => {

            :speedup_queue => [

              {
                :queue_type_id     => 5,
                :queue_type_id_sym => :queue_siege,
                :domain            => :settlement,
                :speedup_formula   => "FLOOR(1.88*POW(LEVEL,1.425)+0.5)/100.0",
              },

            ],

            :unlock_queue => [

              {
                :queue_type_id     => 5,
                :queue_type_id_sym => :queue_siege,
                :level             => 1,
              },

            ],
    
          },

        },              #   END OF Werkstatt
      ],                # END OF BUILDING TYPES

# ## SETTLEMENT TYPES ########################################################
  
      :settlement_types => [  # ALL SETTLEMENT TYPES

        {               #   Unbesiedelt
          :id          => 0, 
          :symbolic_id => :settlement_none,
          :name        => {
            
            :de_DE => "Unbesiedelt",
  
            :en_US => "Wilderness",
                
          },
          :description => {
            
            :de_DE => "Unbesiedeltes Gebiet. Spieler können hier siedeln.",
  
            :en_US => "Unclaimed location. Players can settle here.",
                
          },

	        :conquerable => false,
	        :destroyable => false,





        },              #   END OF Unbesiedelt
        {               #   Festung
          :id          => 1, 
          :symbolic_id => :settlement_fortress,
          :name        => {
            
            :de_DE => "Festung",
  
            :en_US => "Fortress",
                
          },
          :description => {
            
            :de_DE => "Beherrscht eine Region mit allen Einwohnern, erlaubt es Steuern zu erheben und den Gebietszugang zu reglementieren.",
  
            :en_US => "English Description.",
                
          },

	        :conquerable => true,
	        :destroyable => false,



          :building_slots => {
            0 => {
              :max_level => 10,
              
              :building  => 0,
              
              :level  => 1,
              
              :options   => [
              0,
              
              ],
            },
            1 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              1,
              
              ],
            },
            2 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              1,
              
              ],
            },
            
          },



        },              #   END OF Festung
        {               #   Heimatstadt
          :id          => 2, 
          :symbolic_id => :settlement_home_base,
          :name        => {
            
            :de_DE => "Heimatstadt",
  
            :en_US => "Home Town",
                
          },
          :description => {
            
            :de_DE => "Die Hauptsiedlung eines Stammes.",
  
            :en_US => "English Description.",
                
          },

	        :conquerable => false,
	        :destroyable => false,



          :building_slots => {
            0 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              2,
              
              ],
            },
            1 => {
              :max_level => 20,
              
              :building  => 5,
              
              :level  => 1,
              
              :options   => [
              3,
              4,
              
              ],
            },
            2 => {
              :max_level => 20,
              
              :level  => 0,
              
              :options   => [
              3,
              4,
              
              ],
            },
            3 => {
              :max_level => 20,
              
              :level  => 0,
              
              :options   => [
              3,
              4,
              
              ],
            },
            4 => {
              :max_level => 20,
              
              :level  => 0,
              
              :options   => [
              3,
              4,
              
              ],
            },
            5 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            6 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            7 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            8 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            9 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            10 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            11 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            12 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            13 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            14 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            15 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            16 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            17 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            18 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            19 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            20 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            21 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            22 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            23 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            24 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            25 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            26 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            27 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            28 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            29 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            30 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            31 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            32 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            33 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            34 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            35 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            36 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            37 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            38 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            39 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            40 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            
          },



        },              #   END OF Heimatstadt
        {               #   Außenposten
          :id          => 3, 
          :symbolic_id => :settlement_outpost,
          :name        => {
            
            :de_DE => "Außenposten",
  
            :en_US => "Outpost",
                
          },
          :description => {
            
            :de_DE => "Außenlager eines Stammes.",
  
            :en_US => "English Description.",
                
          },

	        :conquerable => true,
	        :destroyable => true,



          :building_slots => {
            0 => {
              :max_level => 20,
              
              :level  => 0,
              
              :options   => [
              3,
              4,
              
              ],
            },
            1 => {
              :max_level => 20,
              
              :level  => 0,
              
              :options   => [
              3,
              4,
              
              ],
            },
            2 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            3 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            4 => {
              :max_level => 10,
              
              :level  => 0,
              
              :options   => [
              4,
              
              ],
            },
            
          },



        },              #   END OF Außenposten
      ],                # END OF SETTLEMENT TYPES

# ## QUEUE TYPES #############################################################
  
      :queue_types => [  # ALL QUEUE TYPES

        {               #   queue_buildings
          :id          => 0, 
          :symbolic_id => :queue_buildings,
          :unlock_field=> :settlement_queue_buildings_unlock_count,
          :category_id => 0,
					:category    => :queue_category_construction,
          :domain      => :settlement,
          :base_threads=> 1,
          :base_slots  => 4,
          :name        => {
            
            :en_US => "Construction of Buildings",
  
            :de_DE => "Gebäudeproduktion",
                
          },
          :produces    => [
            0,
            1,
            3,
            4,
            
          ],
        },              #   END OF queue_buildings
        {               #   queue_fortifications
          :id          => 1, 
          :symbolic_id => :queue_fortifications,
          :unlock_field=> :settlement_queue_fortifications_unlock_count,
          :category_id => 0,
					:category    => :queue_category_construction,
          :domain      => :settlement,
          :base_threads=> 1,
          :base_slots  => 4,
          :name        => {
            
            :en_US => "Construction of Fortifications",
  
            :de_DE => "Aufbau von Verteidigungsanlagen",
                
          },
          :produces    => [
            
          ],
        },              #   END OF queue_fortifications
        {               #   queue_infantry
          :id          => 2, 
          :symbolic_id => :queue_infantry,
          :unlock_field=> :settlement_queue_infantry_unlock_count,
          :category_id => 1,
					:category    => :queue_category_training,
          :domain      => :settlement,
          :base_threads=> 1,
          :base_slots  => 4,
          :name        => {
            
            :en_US => "Training of Infantry",
  
            :de_DE => "Infanterieausbildung",
                
          },
          :produces    => [
            0,
            
          ],
        },              #   END OF queue_infantry
        {               #   queue_artillery
          :id          => 3, 
          :symbolic_id => :queue_artillery,
          :unlock_field=> :settlement_queue_artillery_unlock_count,
          :category_id => 1,
					:category    => :queue_category_training,
          :domain      => :settlement,
          :base_threads=> 1,
          :base_slots  => 4,
          :name        => {
            
            :en_US => "Training of Artillery",
  
            :de_DE => "Ausbildung von Fernkämpfern",
                
          },
          :produces    => [
            2,
            
          ],
        },              #   END OF queue_artillery
        {               #   queue_cavalry
          :id          => 4, 
          :symbolic_id => :queue_cavalry,
          :unlock_field=> :settlement_queue_cavalry_unlock_count,
          :category_id => 1,
					:category    => :queue_category_training,
          :domain      => :settlement,
          :base_threads=> 1,
          :base_slots  => 4,
          :name        => {
            
            :en_US => "Training of Cavalry",
  
            :de_DE => "Ausbildung von berittenen Einheiten",
                
          },
          :produces    => [
            1,
            
          ],
        },              #   END OF queue_cavalry
        {               #   queue_siege
          :id          => 5, 
          :symbolic_id => :queue_siege,
          :unlock_field=> :settlement_queue_siege_unlock_count,
          :category_id => 1,
					:category    => :queue_category_training,
          :domain      => :settlement,
          :base_threads=> 1,
          :base_slots  => 4,
          :name        => {
            
            :en_US => "Training of Siege",
  
            :de_DE => "Bau von Belagerungsgeräten",
                
          },
          :produces    => [
            3,
            
          ],
        },              #   END OF queue_siege
        {               #   queue_research
          :id          => 6, 
          :symbolic_id => :queue_research,
          :unlock_field=> :character_queue_research_unlock_count,
          :category_id => 2,
					:category    => :queue_category_research,
          :domain      => :character,
          :base_threads=> 1,
          :base_slots  => 4,
          :name        => {
            
            :en_US => "Forschung",
  
            :de_DE => "Research",
                
          },
          :produces    => [
            0,
            
          ],
        },              #   END OF queue_research
        {               #   queue_alliance_research
          :id          => 7, 
          :symbolic_id => :queue_alliance_research,
          :unlock_field=> :alliance_queue_alliance_research_unlock_count,
          :category_id => 2,
					:category    => :queue_category_research,
          :domain      => :alliance,
          :base_threads=> 1,
          :base_slots  => 1,
          :name        => {
            
            :en_US => "Allianzweite Forschung",
  
            :de_DE => "Alliance Research",
                
          },
          :produces    => [
            0,
            
          ],
        },              #   END OF queue_alliance_research
      ],                # END OF QUEUE TYPES

    )
  end
end


# INLINED TEST CODE: (uncomment to run)

#puts GameRules::Rules.the_rules.to_json
#GameRules.rules.unit_types.each do |value| 
#  puts value[:name][:de_DE] 
#end

