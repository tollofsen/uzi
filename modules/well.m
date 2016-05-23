;======================================
;   Well Script
;======================================

/alias nosleep \
	/ecko DO %{htxt2}NOT %{ntxt}SLEEP IN HERE!

/set stalac=0
/set tick5=sleep

/def -aBCred -mglob -t'You feel a slight movement in the air, and you can hear a storm brewing afar.' stormsl = \
	/if (position=/'rest') \
		/ecko Continuing resting?%;\
;      sit%;\
	/elseif (tick5=/'nosleep') \
		/if (assist == 0) assist %; /endif%;\
		nosleep%;\
	/else \
		/if (assist == 0) assist %; /endif%;\
		sit%;\
	/endif%;\
	/set welltempest=1


/def -aBCblue -mglob -t'A raging tempest races through the room, leaving devastation in its wake.' stormwa = \
	/if (position=/'rest') \
		/ecko Continuing resting?%;\
	/else \
		/if (assist == 0) retreat %; /endif%;\
		stand%;\
	/endif%;\
	/set welltempest=0


/def -mregexp -t'^([^ ]*)\'s group leaves ([^ ]*).' save_last_dir = \
    /if ({P1}=/{tank}) \
      /set walkdir=%{P2}%;\
    /endif

/def -F -mglob -t'You follow *\'s group.' well_nollacop = \
    /set coppen=1

/def -mregexp -t'A stalactite dislodges from the ceiling and plummets to the ground, narrowly' walk_last_dir = \
    /set stalac=1%;\
    /ecko Stalactited.%;\
    stand

/def -E$[{fighting}==0] -mregexp -t'You stand up.' walk_last_dir2=	\
    /if (stalac=1) \
      /if (walkdir!=(east|north|west|south|up|down)) \
        /ecko %{htxt2}Warning! No dir to walk!!%;\
    /else \
          /ecko Walking %{htxt2}%{walkdir}!%;\
          %{walkdir}%;\
          /send group leader%;\
		  /set wellcheckgroup=1%;\
;        fol %{tank}%;\
          /repeat -00:00:10 1 /set walkdir=0%;\
          /repeat -00:00:10 1 /set stalac=0%;\
      /endif%;\
  /elseif (slipped=1) \
      /if (walkdir!=(east|north|west|south|up|down)) \
          /ecko %{htxt2}Warning! %{ntxt}No dir to walk!!%;\
      /else \
          /ecko Slipped... Walking %{htxt2}%{walkdir}!%;\
          %{walkdir}%;\
          /repeat -00:00:10 1 /set walkdir=0%;\
          /repeat -00:00:10 1 /set slipped=0%;\
      /endif%;\
  /else \
      /ecko No stalactite. Phew!%;\
      /if ({tick5}=/'snore') \
          /set tick5=sleep%;\
      /endif%;\
  /endif

/def -aBCred -mregexp -t'([^ ]*) grapples onto you and starts squeezing.' well_freeze = \
    /ecko You are trapped by the %{htxt2}%{P1}!

/def -p11111 -ag -F -E{wellcheckgroup} -mregexp -t'No one here by that name\.' well_refollow = \
        /ecko Ungrouped! ..refollowing %{tank}.%;\
        /send follow %{tank}%;\
        /set wellcheckgroup 0

/def -p11111 -F -ag -E{wellcheckgroup} -mglob -t"01. * \(Leader\)" well_refollow2 = \
        /set wellcheckgroup 0

/def -aBCred -mglob -t'Your feet lose their purchase on the smooth ice, and you slide on your behind' well_ice = \
    /ecko %{htxt2}SLIPPED!%;\
    stand%;\
    /set slipped2=1

;/def -aBCred -mglob -t'*uncontrollably to the ([^ ]*).' well_ice2 = \
;    /if (slipped2=1) \
;        /set slipped2=0%;\
;        /if ({P1} =/ 'north') south%;\
;        /elseif ({P1} =/ 'south') north%;\
;        /elseif ({P1} =/ 'west') east%;\
;        /elseif ({P1} =/ 'east') west%;\
;        /else /ecko Hrm, what dir?%;\
;        /endif%;\
;     /endif

/def -aBCred -mregexp -t'You slip over on the ice and head careening out of control towards a nearby' well_ice3 = \
    /ecko %{htxt2}SLIIIIIIIIIIIIIIPED!%;\
    stand%;\
    /set slipped=1

/def -aBCred -mregexp -t'The grey ooze surrounds your feet and you watch in despair as it dissolves your' FUCKFUCK = \
    /ecko Sad but true... Your favorite pair of feet wear just %{htxt2}disappeared%{ntxt}. 

/def -mglob -aBCred -t'You open a door into another dimension and quickly step through it.' well_leaderdissed = \
    /set well_leaderdiss=0%;\
    /if ({tick5}=/'snore') \
      /togtick sleep%;\
    /endif

/def -aBCred -p2 -F -mregexp -t'^(In the Essence Flows|A Magical Waterfall)' wellwild = \
	/if (autofight=1) \
		/if ($[fighter+rogue+nightblade]<2) \
			/set wildmag=1%;\
			/if ((rogue|nightblade)>0) \
				/set autochange=0%;\
				/if (rogue=1) \
					/set damage=backstab%;\
					/ecko Wildmagic, only using Backstab.%;\
				/elseif ($[rogue+fighter+nightblade]<2) \
					/set damage=murder%;\
					/ecko Wildmagic, only using Murder.%;\
				/endif%;\
			/else \
				/fight%;\
			/endif%;\
		/endif%;\
	/endif%;\
	/if (wmag!~'1' & (priest>0 | templar>1 | animist>1)) \
		/wmag%;\
	/endif%;\
	/if ({tick5}=/'nosleep') \
		/set tick5=sleep%;\
	/endif%;\
	/set welltempest=0

/def wmag = \
	/set olthp=%{atthp}%;\
	/set olmhp=%{atmhp}%;\
	/set olghp=%{atghp}%;\
	/set atthp=0%;\
	/set atmhp=0%;\
	/set atghp=0%;\
	/set wmag=1%;\
	/if (priest>0) \
		/ecko Wild Magic, switching to gpows.%;\
	/elseif (templar>1) \
		/ecko Wild Magic, turning healing off.%;\
	/elseif (animist>1) \
                /ecko Wild Magic, turning healing off.%;\
	/endif

/def nmag= \
	/set atthp=%{olthp}%;\
	/set atmhp=%{olmhp}%;\
	/set atghp=%{olghp}%;\
	/set wmag=0%;\
	/ecko Normal Magic... heal on.


/def -aBCcyan -p2 -F -mregexp -t'^(A Deep Eddy|A Deep Pool|A Narrow Underground Stream|A Hot Lava Flow|A Fiery Lavafall\
|A Small Passage|A Small Cavern|A Glittering Passage|A Wide Pool|An Icy Passage|An Underground Lake|A Shimmering Room\
|A Frozen Pool|An Ice-Covered Cavern|The Temple Square)' wellwild2 = \
    \
    /if ((rogue|nightblade)>0) \
      /set autochange=1%;\
    /else \
      /if ((autofight=0)&(wildmag=1)) \
        /fight%;\
      /endif%;\
    /endif%;\
    /if (wmag=1 & (priest>0 | templar>1 | animist>1)) \
      /nmag%;\
    /endif%;\
    /if ({4}=/'Stream' | {3}=/'Lake' | {3}=/'Eddy' | (({3}=/'Pool') & ({2}!/'Frozen')) | {2}=/'Pool') \
      /if ({tick5}=/'sleep') \
        /set tick5=nosleep%;\
      /endif%;\
    /else \
      /if ({tick5}=/'nosleep') \
        /set tick5=sleep%;\
      /endif%;\
    /endif%;\
    /set wildmag=0%;\
    /set welltempest=0

/def -mglob -t'*your feet. You try to fight free, but you are sucked down through the ground*' well_slurped = \
    gtf emote just slurped thru a &+yquicksand&+g.%;\
	/set fighting=0%;\
	/if (autofight) \
		/fight%;\
	/endif

/def -aBCred -mregexp -t'You have a strange desire to leave this place.' well_special = \
    /ecko %{htxt2}WARNING!!! %{ntxt}Left rooooooooooooom!

/def -aBCred -mregexp -t'You are unable to react in time, and tumble through the hole in the floor.' well_trapped = \
    /ecko TRAPPED!!!!!

/def -aBCred -mregexp -t'([^ ]*) is too slow to react, and falls through it.' well_trapped2 = \
    /if (priest>0 & wellsumm=1) \
      /set lastsum=%{1}%;\
      /set sumway=gt%;\
      cast 'summon' 0.%{P1}%;\
    /endif

/def -mglob -t'{*} slips on the icy floor and slides off to the {*} on {*} butt.' somslipped = \
    /if (priest>0 & wellsumm=1) \
		/set lastsum=%{1}%;\
		/set sumway=tell %{1}%;\
		cast 'summon' 0.%{1}%;\
    /endif

/def -mregexp -t'You finally manage to escape The cloaker\'s evil clutches.' wellfreeze4 = \
    /ecko You escaped the Cloaker!%;\
    ass %{tank}

/def -aBCred -mregexp -t'The cloaker escapes the melee long enough to surround you in a cloak of darkness.' well_freeze2 = \
    /ecko The cloaker have %{htxt2}TRAPPED YOU!!!!

/def -mregexp -t'shoots out a tentacle and snags you. You feel the strength drain out of your body.' well_freeze3 = \
  /if (assist=1) \
    ass %{tank}%;\
  /endif

 
/def -aBCred -mregexp -t'has turned you to stone!' well_stoned = \
    /ecko STONED!!! DrugsRUs(tm)

/def -aBCred -mglob -t'You find yourself lost in the gaze of The greater medusa - ut oh!' medusan_petri = \
	/ecko Petrified!

;;
