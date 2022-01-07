; // vim: set ft=tf:

;======================================
;   Well Script
;======================================

;/alias nosleep \
;    /ecko DO %{htxt2}NOT %{ntxt}SLEEP IN HERE!

/set stalac=0
;/set tick5=sleep

/def -aBCred -mglob -t'You feel a slight movement in the air, and you can hear a storm brewing afar.' stormsl = \
    /set welltempest=1%;\
    /if (well_waterroom=0) \
        sit%;\
    /endif
;    /if (position=/'rest') \
;        /ecko Continuing resting?%;\
;      sit%;\
;    /elseif (tick5=/'nosleep') \
;        /if (assist == 0) assist %; /endif%;\
;        nosleep%;\
;    /else \
;        /if (assist == 0) assist %; /endif%;\
;        sit%;\
;    /endif%;\
;    /set welltempest=1


/def -aBCblue -mglob -t'A raging tempest races through the room, leaving devastation in its wake.' stormwa = \
    /if (position=/'rest') \
        /ecko Continuing resting?%;\
    /else \
        stand%;\
    /endif%;\
    /set welltempest=0


/def -aBCred -msimple -t'As you try to move, you lose your grip on the slippery ice and end up on your' well_slip = \
    /ecko %{htxt2}SLIPPED!%;\
    stand%;\
    /set slipped=1

/def -mregexp -t'^([^ ]*)\'s group leaves ([^ ]*).' save_last_dir = \
    /if ({P1}=/{tank}) \
        /set walkdir=%{P2}%;\
        /if (stalag_mode<1) \
            /set stalag_mode=1%;\
        /endif%;\
    /endif

/def -F -mregexp -t'^You follow (.*)\'s group.$' well_nollacop = \
    /set _group_walk_gag=1%;\
    /set coppen=1%;\
    /if (stalag_mode=1) \
        /set stalag_mode=2%;\
    /endif

/def -mregexp -t'A stalactite dislodges from the ceiling and plummets to the ground, narrowly' walk_last_dir = \
    /set stalac=1%;\
    /ecko Stalactited.%;\
    /if (stalag_mode=0) \
        /set stalag_mode=3%;\
    /endif%;\
    stand

;/def -mregexp -Estalag_mode -t'^([A-z]+) (is in excellent condition|has a few scratches|has some small wounds and bruises|has quite a few wounds|has some big nasty wounds and scratches|looks pretty hurt|is in awful condition|is bleeding awfully from big wounds)' stalag_check_leader0 = \
;    /if ({P1}=~tank) \
;        /set stalag_mode=0%;\
;    /endif

;/def -msimple -Estalag_mode -Fp1222 -t'No-one by that name here.' stalag_check_leader1 = \
;    /ecko Walking %{htxt2}%{walkdir}%;\
;    %{walkdir}%;\
;    /send group leader%;\
;    /set wellcheckgroup=1%;\
;    /repeat -00:00:10 1 /set walkdir=0%;\
;    /repeat -00:00:10 1 /set stalac=0%;\
;    /set stalag_mode=0


/def -E(fighting==0) -mregexp -t'You stand up.' walk_last_dir2=	\
    /if (stalac=1) \
        /if (regmatch("^(east|north|west|south|up|down)$", walkdir)=0) \
            /ecko %{htxt2}Warning! No dir to walk!!%;\
        /else \
            /if (stalag_mode>1) \
                /ecko Walking %{htxt2}%{walkdir}!%;\
                %{walkdir}%;\
                /if (stalag_mode=3) \
                    follow %{tank}%;\
                /endif%;\
;                /send group leader%;\
;                /set wellcheckgroup=1%;\
;                /repeat -00:00:10 1 /set walkdir=0%;\
;                /repeat -00:00:10 1 /set stalac=0%;\
            /endif%;\
        /endif%;\
    /elseif (slipped=1) \
        /if (regmatch("^(east|north|west|south|up|down)$", walkdir)=0) \
            /ecko %{htxt2}Warning! %{ntxt}No dir to walk!!%;\
            /set slipped=0%;\
        /else \
            /ecko Slipped... Walking %{htxt2}%{walkdir}!%;\
            %{walkdir}%;\
;            /repeat -00:00:10 1 /set walkdir=0%;\
            /repeat -00:00:10 1 /set slipped=0%;\
        /endif%;\
    /endif

/def -aBCred -mregexp -t'([^ ]*) grapples onto you and starts squeezing.' well_freeze = \
    /ecko You are trapped by the %{htxt2}%{P1}!%;\
    /repeatdamage

;/def -p11111 -ag -F -E{wellcheckgroup} -mregexp -t'No one here by that name\.' well_refollow = \
;    /ecko Ungrouped! ..refollowing %{tank}.%;\
;    /send follow %{tank}%;\
;    /set wellcheckgroup 0

;/def -p11111 -F -ag -E{wellcheckgroup} -mglob -t"01. * \(Leader\)" well_refollow2 = \
;    /set wellcheckgroup 0

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
    /set well_leaderdiss=0
;    /if ({tick5}=/'snore') \
;        /togtick sleep%;\
;    /endif

/def -aBCgreen -p2 -F -mregexp -t'^(In the Essence Flows|A Magical Waterfall)' wellwild = \
    /set in_underworld=0%;\
    /set in_well=2%;\
    /if (_peek_peeking<1) \
        /set wildmagic=2%;\
    /endif

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

/def -aBCcyan -p2 -F -mregexp -t'^(A Deep Eddy|A Deep Pool|A Narrow Underground Stream|A Wide Pool|An Underground Lake)$' well_water_room = \
    /set in_underworld=0%;\
    /set in_well=2%;\
    /set hometown=Karandras%;\
    /if (_peek_peeking<1) \
        /set well_waterroom=2%;\
    /endif

/def -anCyellow -p2 -F -msimple -t'A Pool of Quicksand' well_quicksand_room = \
    /set in_well=2%;\
    /set in_underworld=0%;\
    /set temp_nofight=2%;\
    /set hometown=Karandras


/def -anCred -p2 -F -mregexp -t'^(A Hot Lava Flow|A Fiery Lavafall)$' well_lava_room = \
    /set in_well=2%;\
    /set in_underworld=0%;\
    /set hometown=Karandras

/def -p2 -F -mregexp -t'^(A Small Passage|A Small Cavern|A Glittering Passage|A Shimmering Room|An Ice-Covered Cavern|A Frozen Pool|An Icy Passage)$' well_nospec_room = \
    /set in_well=2%;\
    /set in_underworld=0%;\
    /set hometown=Karandras
;/def -aBCcyan -E(_peek_peeking<1) -p2 -F -mregexp -t'^(A Deep Eddy|A Deep Pool|A Narrow Underground Stream|A Hot Lava Flow|A Fiery Lavafall\
;    |A Small Passage|A Small Cavern|A Glittering Passage|A Wide Pool|An Icy Passage|An Underground Lake|A Shimmering Room\
;    |A Frozen Pool|An Ice-Covered Cavern|The Temple of Karandras)' wellwild2 = \
;    \
;    /if ((rogue|nightblade)>0) \
;        /set autochange=1%;\
;    /else \
;        /if ((autofight=0)&(wildmag=1)) \
;            /fight%;\
;        /endif%;\
;    /endif%;\
;    /if (wmag=1 & (priest>0 | templar>1 | animist>1)) \
;        /nmag%;\
;    /endif%;\
;    /if ({4}=/'Stream' | {3}=/'Lake' | {3}=/'Eddy' | (({3}=/'Pool') & ({2}!/'Frozen')) | {2}=/'Pool') \
;        /if ({tick5}=/'sleep') \
;            /set tick5=nosleep%;\
;        /endif%;\
;    /else \
;        /if ({tick5}=/'nosleep') \
;            /set tick5=sleep%;\
;        /endif%;\
;    /endif%;\
;    /set wildmag=0%;\
;    /set welltempest=0

/def -mglob -t'*your feet. You try to fight free, but you are sucked down through the ground*' well_slurped = \
    gtf emote just slurped thru a &+yquicksand&+g.%;\
    /set fighting=0%;\
    /set temp_nofight=2

/def -aBCred -mregexp -t'You have a strange desire to leave this place.' well_special = \
    /set temp_nofight=2%;\
    /ecko %{htxt2}WARNING!!! %{ntxt}Left rooooooooooooom!

/def -aBCred -mregexp -t'^You are unable to react in time, and tumble through the hole in the floor.$' well_trapped = \
    /set temp_nofight=2%;\
    /ecko TRAPPED!!!!!

/def -aBCred -mregexp -t'([^ ]*) is too slow to react, and falls through it.' well_trapped2 = \
    /if (priest>0 & wellsumm=1) \
        /set lastsum=%{1}%;\
        /set sumway=gt%;\
        cast 'summon' 0.%{P1}%;\
    /endif

/def -mglob -t'{*} slips on the icy floor and slides off to the {*} on {*} butt.' somslipped = \
    /if (priest>0 & wellsumm=1 & stalac<1 & slipped<1) \
        /set lastsum=%{1}%;\
        /set sumway=gt%;\
        cast 'summon' 0.%{1}%;\
    /endif

/def -mregexp -t'You finally manage to escape The cloaker\'s evil clutches.' wellfreeze4 = \
    /ecko You escaped the Cloaker!%;\
    /set sentdamage=0%;\
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

/def -mregexp -F -t'^(The tentamort|someone) injects you with something tasty from one of its tentacles.$' well_tenta_injected = \
    /ecko INJECTED!!!%;\
    /if (priest>2) \
        true self%;\
    /endif

/def -mregexp -t'^The tentamort lashes out with a tentacle and injects something ominous into ([A-z]+).$' well_tenta_injected2 = \
    /ecko %{P1} just got injected by a tentamort!%;\
    /if (priest>1 & ismember({P1}, gplist)) \
        true %{P1}%;\
    /endif

/def -msimple -aB -F -t'The Terrorite Demon whips its tail out towards you, striking with great precision.' well_terrorite_spec

;;

;; Orb on the floor
/def -msimple -F -aB -t'An odd looking orb is lies here, pulsating with power.' orb_on_floor

/def -aBCred -msimple -t'The artifact seems to resist your attempts to pick it up.' nonktv_orb = \
    /beep

/def -msimple -t'You can\'t do anything while in the clutches of The otyugh.' uzi_well_otyugh = \
    /set sentdamage=0%;\
    /repeatdamage

/def -msimple -t'You can\'t do anything while in the clutches of The neo-otyugh.' uzi_well_neo = \
    /set sentdamage=0%;\
    /repeatdamage

/def -msimple -t'You can\'t do a thing! The grell has you tightly in its grasp.' uzi_well_grell = \
    /set sentdamage=0%;\
    /repeatdamage

/def -msimple -t'You can\'t do anything, you\'re turned to stone!' uzi_well_stoned = \
    /set sentdamage=0%;\
    /repeatdamage

/def -msimple -t'Fearing for your life you panic and flee!' uzi_well_forcefled = \
    /set temp_nofight=2

;; Auras

/def uzi_well_invoke = \
    /if (aura !~'Vampirism') \
        /if (priest>0 & aura!~'Regeneration') \
            invoke %{1}%;\
        /elseif (animist>0 & aura!~'Regeneration' & aura!~'the withered soul') \
            invoke %{1}%;\
        /elseif ((rogue|nightblade)>0 & aura!~'Quickness') \
            invoke %{1}%;\
        /elseif ((magician|warlock|templar|animist)>0 & aura!~'the withered soul' & aura!~'Regeneration') \
            invoke %{1}%;\
        /elseif ((magician|warlock|templar|priest)<1) \
            invoke %{1}%;\
        /endif%;\
    /endif

