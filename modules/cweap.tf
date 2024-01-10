; // vim: set ft=tf:
;;;;;;;Autochange script.

/if ({cweap}=~'') /set cweap=1%;/endif
/if ({pweap}=~'') /set pweap=1%;/endif

/def w = \
	/let _w_input=$[replace('slay ', 'slay', {*})]%;\
	/d %*%;\
	/weapon %_w_input

/def tdam = \
	/if ({1}=~'horgar') \
		gt &+Rhorgar%;\
	/elseif ({*}=~'') \
		gtell use &+Rnormal%;\
	/else \
		gtell use &+R%{*}%;\
	/endif%;\
	/w %{*}

/alias tdam /tdam %{*}

/def -mregexp -p9999 -F -t'([A-z]+) tells the group, \'(H|h)(ORGAR|orgar)\'' cweaphorgar = \
	/if ({horgarslay} !~ '') \
		/weapon horgar%;\
	/else \
		/weapon fire%;\
	/endif%;\
	/d fire

/def -mregexp -p9999 -F -t'^You tell the group, \'(H|h)(ORGAR|orgar)\'' cweaphorgar2 = \
	/if ({horgarslay} !~ '') \
		/weapon horgar%;\
	/else \
		/weapon fire%;\
	/endif%;\
	/d fire


;/def -mregexp -p9999 -F -t'([A-z]+) tells the group, \'(USE|use) ([A-Za-z/\ ]*)\'' leadercweap = \
/def leadercweap = \
;    /if ({P1}=/{tank}) \
		/let _newdam=$[replace('/',' ', {*})]%;\
		/let _newdam=$[replace('or',' ', {_newdam})]%;\
		/let _newdam=$[replace('slay ','slay', {_newdam})]%;\
		/let _newdam=$[replace('  ',' ', {_newdam})]%;\
		/let _newdam=$[replace('  ',' ', {_newdam})]%;\
;        /if (_newdam =/ 'iron') \
;            /d %_newdam%;\
;            /weapon %_newdam%;\
;        /elseif (_newdam =/ 'unlife') \
;            /d %_newdam dark slaymagical%;\
;            /weapon unlife dark slaymagical%;\
;        /elseif (_newdam =/ 'pure') \
;            /d %_newdam light%;\
;            /weapon %_newdam light slaydemon%;\
		/if (_newdam =/ 'horgar') \
			/d fire%;\
			/weapon horgar%;\
		/elseif (_newdam =/ 'normal') \
			/d plain%;\
			/weapon plain%;\
		/else \
			/d %_newdam%;\
			/weapon %_newdam%;\
		/endif
;    /endif

;/def -mregexp -p9999 -F -t'([A-z]+) tells the group, \':dam ([A-Za-z/\ ]*)\'' leadercweapbps = \
;    /if ({P1}=/{tank}) \
;        /let _newdam=$[replace('/',' ', {P2})]%;\
;        /let _newdam=$[replace('or',' ', {_newdam})]%;\
;        /let _newdam=$[replace('slay ','slay', {_newdam})]%;\
;        /let _newdam=$[replace('  ',' ', {_newdam})]%;\
;        /let _newdam=$[replace('  ',' ', {_newdam})]%;\
;        /if (_newdam =/ 'iron') \
;            /d %_newdam%;\
;            /weapon %_newdam%;\
;        /elseif (_newdam =/ 'unlife') \
;            /d %_newdam dark magical%;\
;            /weapon unlife dark magical%;\
;        /elseif (_newdam =/ 'pure*') \
;            /d %_newdam light%;\
;            /weapon %_newdam light slaydemon%;\
;        /else \
;            /d %_newdam%;\
;            /weapon %_newdam%;\
;        /endif%;\
;    /endif


;;;;;;;;;;;;;;;;;;
;PathWeaver
;;;;;;;;;;;;;;;;;;
/def weaver = \
	/if ({1}=/'fire'|{1}=/'slayorc'|{1}=/'slaygoblin'|{1}=/'slaytroll'|{1}=/'slaylugroki'|{1}=/'beast') \
		/if ({pweavertype}!/'death') \
			/ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2\Pathweaver%htxt)%;\
			say baru goth deathflame%;wield pathweaver%;/set pweavertype=death%;\
		/elseif (weapon!/'pathweaver') \
			/ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2\Pathweaver%htxt)%;\
		/endif%;\
	/elseif ({1}=/'ice'|{1}=/'slayde'|{1}=/'slaydrow'|{1}=/'slaydrow-elf'|{1}=/'slaydrowelf') \
		/if ({pweavertype}!/'hail') \
			/ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2\Pathweaver%htxt)%;\
			say bwaihna cur hailstrike%;wield pathweaver%;/set pweavertype=hail%;\
		/elseif (weapon!/'pathweaver') \
			/ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2\Pathweaver%htxt)%;\
		/endif%;\
	/else \
		/if ({pweavertype}!/'normal') \
			/ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2\Pathweaver%htxt)%;\
			say cuntoh magu%;wield pathweaver%;/set pweavertype=normal%;\
		/elseif (weapon!/'pathweaver') \
			/ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2\Pathweaver%htxt)%;\
		/endif%;\
	/endif




;;;;;;;;;;;;;;;;;
;WEAPON SWITCHER;
;;;;;;;;;;;;;;;;;
/def cweap = \
	/if ({1} =/ 'on') \
		/set cweap=1%;\
		/ecko Will now autochange Weapon.%;\
	/elseif ({1} =/ 'off') \
		/set cweap=0%;\
		/ecko Won't autochange Weapon.%;\
	/else \
		/if (rogue>0 & quickdraw=1 & fighting=1) \
			/let _wieldcmd=quickdraw%;\
		/else \
			/let _wieldcmd=wield%;\
		/endif%;\
		/if ({2}!~('')|(' ')|('0')) \
			/if (({2}!/weapon)|({2}=/'pathweaver')) \
				/if ({2}=/'mord*') \
					mord%;\
				/elseif ({2}=/'pathweaver') \
					/if ({weapon}!/'pathweaver') \
						/if (pweap=1) \
							gc %{2} weapon!%;\
							/if (quickdraw=1 & fighting=1) \
								quickdraw %2%;\
							/else \
								unwield%;\
							/endif%;\
							wield %2%;\
							/repeat -0:00:01 1 pc %{weapon} weapon!%;\
						/else \
							/if (quickdraw=1 & fighting=1) \
								quickdraw %2%;\
							/else \
								unwield%;\
							/endif%;\
							wield %2%;\
						/endif%;\
					/endif%;\
					/weaver %1%;\
				/else \
					/if (pweap=1) \
						gc %{2} weapon!%;\
						/if (quickdraw=1 & fighting=1) \
							quickdraw %2%;\
						/else \
							unwield%;\
						/endif%;\
						wield %2%;\
						/repeat -0:00:01 1 pc %{weapon} weapon!%;\
					/else \
						/if (quickdraw=1 & fighting=1) \
							quickdraw %2%;\
						/else \
							unwield%;\
						/endif%;\
						wield %2%;\
					/endif%;\
					/ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2%2%htxt)%;\
				/endif%;\
				/set weapon=%{2}%;\
				/if (nightblade>1 & level>=55 & manalevel!~'low' & avenom=1) \
					cast 'venom' %{weapon}%;\
					/set venom=0%;\
				/endif%;\
			/endif%;\
		/else \
			/if (slayalt1!~''|slayalt1!~' '|slayalt1!~'0') \
				/weapon %slayalt1 %slayalt2%;\
			/elseif (normslay!~('')|(' ')|('0')) \
				/weapon%;\
			/endif%;\
		/endif%;\
	/endif

/def weapon = \
	/if (cweap=1) \
		/set slayalt1=0%;/set slayalt2=0%;\
		/set slayalt1=%{2}%;\
		/set slayalt2=%{3}%;\
		/if ({1} =/ 'acid') \
			/cweap Acid %acidslay%;\
		/elseif ({1} =/ 'air') \
			/cweap Air %airslay%;\
		/elseif ({1} =/ 'bleed') \
			/cweap Bleed %bleedslay%;\
		/elseif ({1} =/ 'dark') \
			/cweap Dark %darkslay%;\
		/elseif ({1} =/ 'earth') \
			/cweap Earth %earthslay%;\
		/elseif ({1} =/ 'electricity') \
			/cweap Electricity %electricityslay%;\
		/elseif ({1} =/ 'energy') \
			/cweap Energy %energyslay%;\
		/elseif ({1} =/ 'fire') \
			/cweap Fire %fireslay%;\
		/elseif ({1} =/ 'horgar') \
			/cweap HorgarWeapon %horgarslay%;\
		/elseif ({1} =/ 'gas') \
			/cweap Gas %gasslay%;\
		/elseif ({1} =/ 'ice') \
			/cweap Ice %iceslay%;\
		/elseif ({1} =/ 'iron') \
			/cweap Iron %ironslay%;\
		/elseif ({1} =/ 'light') \
			/cweap Light %lightslay%;\
		/elseif ({1} =/ 'normal') \
			/cweap Normal %normalslay%;\
		/elseif ({1} =/ 'magic') \
			/cweap Magic %magicslay%;\
		/elseif ({1} =/ 'mental') \
			/cweap Mental %mentalslay%;\
		/elseif ({1} =/ 'poison') \
			/cweap Poison %poisonslay%;\
		/elseif ({1} =/ 'pure') \
			/cweap Pure %pureslay%;\
		/elseif ({1} =/ 'silver') \
			/cweap Silver %silverslay%;\
		/elseif ({1} =/ 'stun') \
			/cweap Stun %stunslay%;\
		/elseif ({1} =/ 'superlarge') \
			/cweap Superlarge %superlargeslay%;\
		/elseif ({1} =/ 'unlife') \
			/cweap Unlife %unlifeslay%;\
		/elseif ({1} =/ 'water') \
			/cweap Water %waterslay%;\
		/elseif ({1} =/ 'wood') \
			/cweap Wood %woodslay%;\
		/elseif ({1} =/ 'slayanimal') \
			/cweap SlayANIMAL %animalslay%;\
		/elseif ({1} =/ 'slaybotanic') \
			/cweap SlayBOTANIC %botanicslay%;\
		/elseif ({1} =/ 'slaydemon') \
			/cweap SlayDEMON %demonslay%;\
		/elseif ({1} =/ 'slaydinosaur') \
			/cweap SlayDINOSAUR %dinosaurslay%;\
		/elseif ({1} =/ 'slaydragon') \
			/cweap SlayDRAGON %dragonslay%;\
		/elseif ({1} =/ 'slayde' | {1} =/ 'slaydrowelf' | {1} =/ 'slaydrow-elf' | {1} =/ 'slaydrow') \
			/cweap SlayDROW-ELF %drowelfslay%;\
		/elseif ({1} =/ 'slaydwarf') \
			/cweap SlayDWARF %dwarfslay%;\
		/elseif ({1} =/ 'slayelemental') \
			/cweap SlayELEMENTAL %elementalslay%;\
		/elseif ({1} =/ 'slayelf') \
			/cweap SlayELF %elfslay%;\
		/elseif ({1}=/ 'slayfairie'| {1} =/ 'slayfairy') \
			/Cweap SlayFAIRIE %fairieslay%;\
		/elseif ({1} =/ 'slaygiant') \
			/cweap SlayGIANT %giantslay%;\
		/elseif ({1} =/ 'slaygnome') \
			/cweap SlayGNOME %gnomeslay%;\
		/elseif ({1} =/ 'slaygoblin') \
			/cweap SlayGOBLIN %goblinslay%;\
		/elseif ({1} =/ 'slayhe' | {1} =/ 'slayhalfelf') \
			/cweap SlayHALF-ELF %halfelfslay%;\
		/elseif ({1} =/ 'slayho' | {1} =/ 'slayhalforc') \
			/cweap SlayHALF-ORC %halforcslay%;\
		/elseif ({1} =/ 'slayhobbit') \
			/cweap SlayHOBBIT %hobbitslay%;\
		/elseif ({1} =/ 'slayhuman') \
			/cweap SlayHUMAN %humanslay%;\
		/elseif ({1} =/ 'slayinsect') \
			/cweap SlayINSECT %insectslay%;\
		/elseif ({1} =/ 'slayinsubstantial') \
			/cweap SlayINSUBSTANTIAL %insubstantialslay%;\
		/elseif ({1} =/ 'slaylugroki') \
			/cweap SlayLUGROKI %lugrokislay%;\
		/elseif ({1} =/ 'slaymythical') \
			/cweap SlayMYTHICAL %mythicalslay%;\
		/elseif ({1} =/ 'slaymagical') \
			/cweap SlayMAGICAL %magicalslay%;\
		/elseif ({1} =/ 'slayorc') \
			/cweap SlayORC %orcslay%;\
		/elseif ({1} =/ 'slayrodent') \
			/cweap SlayRODENT %rodentslay%;\
		/elseif ({1} =/ 'slaysnake') \
			/cweap SlaySNAKE %snakeslay%;\
		/elseif ({1} =/ 'slaytroll') \
			/cweap SlayTROLL %trollslay%;\
		/elseif ({1} =/ 'slayundead') \
			/cweap SlayUNDEAD %undeadslay%;\
		/elseif ({1} =/ 'slayvampire') \
			/cweap SlayVAMPIRE %vampireslay%;\
		/elseif ({1} =/ 'fireslash') \
			/cweap Fireslash %fireslash%;\
		/else \
			/eval /set _tmpweap=%%{%{1}slay}%;\
			/if (_tmpweap !~ '') \
				/cweap $[toupper({1})] %_tmpweap%;\
			/elseif (slayalt1 !~ '') \
				/weapon %slayalt1 %slayalt2%;\
			/else \
				/if (weapon!~normslay) \
					/cweap Normal %normslay%;\
				/endif%;\
			/endif%;\
		/endif%;\
	/endif

/def addweapon = \
	/if ({1} !~ '' & {2} !~ '') \
		/let _newdamtype=$[tolower({1})]%;\
		/eval /set %{_newdamtype}slay=%{2}%;\
		/ecko Added:%htxt2 %_newdamtype%ntxt To use it type%htxt2 /w %_newdamtype%;\
	/else \
		/uecko Usage: /addweapon <type> <weapon-name>%;\
	/endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;Mob/Room name triggs;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Gorm
/def -mglob -F -t'A gorm {mage|priestess|warrior}*' cweap1 = \
	/weapon acid poison fire%;\
	/d fire light poison

/def -msimple -F -t'A huge, ancient tree towers above you.' cweap2 = \
	/weapon slaybotanic acid%;\
	/d slaybotanic plain normal

; The soulstealers laboratory
/def -F -mregexp -t'^A soulcrusher lurks in the shadows here.$|^The soulcrusher glances at you with fear.$|^A blurred figure stands here.$|^Entrance to the SoulCrusher\'s Laboratory$' cweap3 = \
	/weapon slaydemon pure iron light%;\
	/d slaydemon light pure

/def -F -mregexp -t'^A great soulcrusher stands here.$|^A Long Hallway in the Twisted Laboratory$' cweap4 = \
	/weapon slaydemon pure iron light%;\
	/d slaydemon light pure

; Dungeons of Ceanyth
/def -F -mregexp -t'^Entrance to the Dark Dungeons$\
|^A worn out guard stands watch here.$\
|^A prisoner looks angrily around him.$\
|^An orc merchant is standing here.$\
|^A young prisoner looks wearily at you.$\
|^A skinny man hides in the shadows.$' cweap5 = \
	/weapon beast pure light fire%;\
	/d beast pure light fire

; Dragonspyre
/def -F -mregexp -t'^Walking through DragonSpyre|The star spawn|The deep one|The hunting horror' cweap6 = \
	/weapon plain normal%;\
	/d normal

; Antiriad
/def -mregexp -F -t'^Entrance to the City of Antiriad$|^Outside Ye Olde Shoppe$' cweap8 = \
	/weapon slaylugroki pure fire%;\
	/d slaylugroki fire pure light

; Antiriad - Poltergeist
/def -msimple -F -t'The abandoned shop' cweap9 = \
	/weapon energy%;\
	/d energy

; Upper Argo (black and white trolls)
/def -msimple -F -t'Mt. Ulmo Pass' cweap10 = \
	/weapon slaytroll fire acid mental%;\
	/d slaytroll fire light pure

; Dragons graveyard
/def -msimple -F -t"The dragons' graveyard" cweap11 = \
	/weapon slaydragon%;\
	/d slaydragon

; The Citadel
/def -msimple -F -t'The Gatehouse of the Citadel' cweap12 =\
	/weapon slayelf unlife dark iron%;\
	/d slayelf unlife dark

; Kaltor
/def -msimple -F -t'Entrance to the Ruins of Kaltor' cweap13 = \
	/weapon slaymagical unlife%;\
	/d slaymagical unlife

; Earthsea
/def -msimple -F -t'The Entrance To EarthSea' cweap15 = \
	/weapon slaymagical unlife%;\
	/d slaymagical unlife

; Inglestone
/def -msimple -F -t'The entrance to the great Dwarven kingdom, Inglestone' cweap16 =\
	/weapon slaydwarf magic superlarge water%;\
	/d slaydwarf magic water

; Alterac - Entrance
/def -msimple -F -t'The Gatekeeper of the stronghold stands here proudly' cweap17 = \
	/weapon slayhuman%;\
	/d slayhuman normal

; Drow City/Shadowdwell
;/def -msimple -F -t'Outside the City Gates' cweap18 = \
;    /weapon slaydrowelf pure light ice%;\
;    /d slaydrowelf pure light ice

; Kaltor - Skeletons (does anyone kill these nowadays?)
/def -mglob -t'You {*} The Skeleton with your *' cweap19 = \
	/weapon slayundead pure light silver%;\
	/d slayundead heal

; The desolate plains
/def -msimple -p2 -F -t'The slope down.' cweap20 = \
	/weapon slaymagical unlife%;\
	/d slaymagical unlife

; The amphitheatre
/def -msimple -F -t'The upper seatings' cweap21 =\
	/weapon grolim iron light slayhuman%;\
	/d grolim light

; Great red wyrm
/def -msimple -F -t'A huge red dragon lies on a huge hoard of treasures, sleeping. (hidden)' cweap22 = \
	/weapon slaydragon%;\
	/d slaydragon normal

; Olympus
/def -msimple -F -t'The Temple of Olympus' cweap23 = \
	/weapon slaymythical%;\
	/d slaymythical plain normal


; Leviathan, entrance to ice wall
/def -msimple -F -t'Leviathan is here, looking at you with a quizzical expresion.' cweap25 = \
	/weapon slaymagical unlife%;\
	/d slaymagical unlife

/def -msimple -t'Western Manyfolk' cweap26 = \
	/weapon slaydemon pure light iron%;\
	/d slaydemon pure light

/def -mglob -t'An ugly orc stands here.' cweap27 =\
	/weapon slayorc fire pure light%;\
	/d slayorc fire light

; Sarakesh
/def -msimple -F -t'The temple of Sarakesh' cweap28 =\
	/weapon sarakesh slayundead silver mental light%;\
	/d sarakesh slayundead light

; Underworld
/def -msimple -F -t'Elysium Fields' cweap_uw_1 =\
	/weapon underworld dark pure%;\
	/d underworld pure

/def -msimple -F -t'Gates of Tartarus' cweap_uw_2 = \
	/weapon unlife%;\
	/d unlife

/def -msimple -F -t'Plain of Judgment' cweap_uw_3 = \
	/weapon underworld dark pure%;\
	/d underworld pure

; Khronatio
/def -msimple -F -t'Inside a ruined Gatehouse' cweap30 = \
	/weapon decap water%;\
	/d decap water

/def -msimple -F -t'The den of the Black Dragon' cweap32 = \
	/weapon slaydragon%;\
	/d slaydragon normal

/def -msimple -F -t'A dark cell' cweap33 = \
	/weapon bodak silver slash%;\
	/d bodak

/def -mregexp -F -p1000 -t'^Deep down in the ravine$|^A drow is here, guarding the hallways.|^A drow guard is here, playing cards.|^A drow warrior is here, training.|^A huge drow is here, clad in the finest azur and silver armor' cweap41 = \
 /weapon slaydrowelf ice pure light%;\
 /d slaydrowelf ice pure light

/def -mregexp -t'Korr, the Overlord of Chaos stands here grinning wickedly.\
	|A Chaos Knight Sergeant stands here pondering the boulders situation' cweap42 = \
	/weapon slayhuman%;\
	/d normal

/def -F -msimple -t'The Grand Hallway.' cweap50 =\
	/weapon slayelf unlife dark iron%;\
	/d slayelf unlife

;/def -F -msimple -t'Entrance to the King\'s Castle' cweap52 =\
;    /weapon slayhuman%;\
;    /d slayhuman normal

;/def -F -msimple -t'You feel a sensation as you travel through the essence flows.' cweap53 = \
;    /weapon normal%;\
;    /d normal

; Cohn Shar
/def -F -mregexp -t'^(A warrior stands here overseeing the protection of Egypt.\
	|A warrior stands here protecting the gates of the palace.\
	|A warrior stands here protecting the palace.\
	|A warrior stands here looking at antiquity.\
	|A warrior lies here resting.)$' cweap54 = \
	/weapon medjai slayhuman iron light%;\
	/d medjai light

; Snake Lair
/def -F -msimple -t'A Path In The Mountains' cweap55 = \
	/weapon slaysnake%;\
	/d slaysnake normal

/def -F -mregexp -t'^An old crone of the hive scrunches her face up at your presence.$|^A powerful witch of the hive is busy creating new incantations.$|^A young initiate of the hive awaits instruction from her superiors here.$' cweap56 = \
	/weapon coven normal%;\
	/d coven normal


; Oblivion
/def -msimple -F -t'A frozen tundra' cweap_oblivion_1 = \
	/weapon fire%;\
	/d fire

/def -msimple -F -t'A burning inferno' cweap_oblivion_2 = \
	/weapon ice%;\
	/d icc

/def -msimple -F -t'Floating in the void' cweap_oblivion_3 = \
	/weapon slaymagical unlife%;\
	/d slaymagical unlife

; Alterac - waywatchers
/def -mregexp -F -t'^An elven ranger scouts the surrounding hinterland' cweap59 = \
	/weapon slayelf unlife dark iron%;\
	/d slayelf unlife dark

; Dead mans cove
/def -msimple -F -t"Ocean's edge" cweap60 = \
  /weapon energy%;\
  /d energy

/def -msimple -F -t'In the dungeons' cweap61 = \
  /weapon bodak silver slash%;\
  /d bodak

/def -mregexp -Fp2100 -t'^A wizarne is here studying the arts of magic.$|^A wizarn is here studying the arts of magic.$' cweap62 = \
  /weapon slayhuman%;\
  /d slayhuman

/def -msimple -F -t'Gateway To The Farm' cweap63 = \
  /weapon slayundead pure silver%;\
  /d pure light

/def -msimple -F -t'The Entrance to the Spire of Statues' cweap64 = \
  /weapon plain%;\
  /d plain


;; Set damage spell on hit
/def -mregexp -F -p200002 -t'^You (miss|obliterate|annihilate|vaporize|pulverize|atomize|ultraslay|\*\*\*ULTRASLAY\*\*\*) (.*) with your ' hit_cdam = \
  /let _mob=%{P2}%;\
  /if (quickdraw=1 & ingroup=1 & leading<1 & slipped<1 & temp_nofight<1) \
	/let _quickdraw=1%;\
  /else \
	/let _quickdraw=0%;\
  /endif%;\
  /if ({_mob}=~'The thassaloss') \
	/if (_quickdraw) \
	  /weapon plain%;\
	/endif%;\
	/d slayevil plain%;\
  /elseif ({_mob}=~'The Balrog') \
	/if (_quickdraw) \
	  /weapon slaymythical%;\
	/endif%;\
	/d slayevil slaymythical%;\
  /elseif ({_mob}=~'Morgoth the Valar God') \
	/if (_quickdraw) \
	  /weapon slaymythical%;\
	/endif%;\
	/d slayevil slaymythical%;\
  /elseif ({_mob}=~'The Shadow Deamon') \
	/if (_quickdraw) \
	  /weapon fire slaydemon pure light%;\
	/endif%;\
	/d fire slayevil slaydemon pure light%;\
  /elseif (regmatch('^(The Major Eraditor|The Eraditor|The Terrorite Demon|The Lesser Eraditor|The Sword Demon|The Storm Demon)$', {_mob})) \
	/if (_quickdraw) \
	  /weapon slaydemon pure light%;\
	/endif%;\
	/d slayevil slaydemon pure light%;\
  /elseif ({_mob}=~'The umber hulk') \
	/if (_quickdraw) \
	  /weapon beast pure light%;\
	/endif%;\
	/d slayevil beast pure fire light%;\
  /elseif (regmatch('^The Dao (Khan|Hetman)$', {_mob})) \
	/if (_quickdraw) \
	  /weapon air slayelemental%;\
	/endif%;\
	/d air%;\
  /elseif (regmatch('^The Djinni (Vizier|Malik)$', {_mob})) \
	/if (_quickdraw) \
	  /weapon earth slayelemental%;\
	/endif%;\
	/d earth%;\
  /elseif (regmatch('^The Marid (Mufti|Atabeg|Shah|Beglerbeg)$', {_mob})) \
	/if (_quickdraw) \
	  /weapon fire slayelemental%;\
	/endif%;\
	/d fire%;\
  /elseif (regmatch('^The (manticore|neo\-otyugh|otyugh|purple worm|thessaltrice|thessalgorgon|thessalmera|thessalhydra)$', {_mob})) \
	/if (_quickdraw) \
	  /weapon slaymagical unlife%;\
	/endif%;\
	/d slaymagical unlife%;\
  /elseif (regmatch('^The (gauth|beholder)$', {_mob})) \
	/if (_quickdraw) \
	  /weapon light%;\
	/endif%;\
	/d light%;\
  /elseif (regmatch('^The (fire elemental|pyrohydra)$', {_mob})) \
	/if (_quickdraw) \
	  /weapon ice%;\
	/endif%;\
	/d ice%;\
  /elseif (regmatch('^The (frost dragon|ancient white dragon)$', {_mob})) \
	/if (_quickdraw) \
	  /weapon fire slaydragon%;\
	/endif%;\
	/d fire%;\
  /elseif (regmatch('^The water elemental$', {_mob})) \
	/if (_quickdraw) \
	  /weapon fire slayelemental%;\
	/endif%;\
	/d fire%;\
  /elseif (regmatch('^The Efreeti (Bey|Pasha|Emir|Malik)$', {_mob})) \
	/if (_quickdraw) \
	  /weapon ice slayelemental%;\
	/endif%;\
	/d ice%;\
  /elseif (regmatch('^The remorhaz$', {_mob})) \
	/if (_quickdraw) \
	  /weapon slaydragon%;\
	/endif%;\
	/d slaydragon%;\
; Ceanyth
  /elseif (regmatch('^(A creepy monster|A hairy beast)$', {_mob})) \
	/d slayevil beast pure fire light%;\
; Earthsea
  /elseif (regmatch('^(A Bodyguard|The Draconian)$', {_mob})) \
	/d slayevil slaymagical unlife%;\
; Graveyard
  /elseif (regmatch('^(A dracolich|A Doomed Black Wyrm|A skeletal dragon|A Zombie Wyrm )$', {_mob})) \
	/d slaydragon%;\
  /elseif ({_mob}=~'The Draconian Attendant') \
	/d slaymagical%;\
  /elseif (regmatch('^(The Charred Skeleton)$', {_mob})>0) \
	/d slayevil slaymagical%;\
; Icewood vale
  /elseif (regmatch('^(The Mountain Firbolg|The Icewood Firbolg|The Arctic Firbolg|The Winter Giant|The Mountain Firbolg)$', {_mob})) \
	/d slaygiant%;\
	/if (_quickdraw=1) \
	  /weapon slaygiant%;\
	/endif%;\
  /elseif (regmatch('^(A Polar Bear|A Mammoth)$', {_mob})) \
	/d slayanimal%;\
	/if (_quickdraw=1) \
	  /weapon slayanimal mental%;\
	/endif%;\
  /elseif ({_mob}=~'The Ice Worm') \
	/if (_quickdraw=1) \
	  /weapon normal%;\
	/endif%;\
; Alterac
  /elseif (regmatch('^(A Brettonian man-at-arms|An Ofcol mercenary|A Brettonian Guard|A captain of the Brettonian High Command)$', {_mob})) \
	/if (_quickdraw & humanslay!~'') \
		/weapon slayhuman%;\
	/endif%;\
	/if (warlock>1) \
		/d ice%;\
	/else \
		/d slayhuman normal%;\
	/endif%;\
  /elseif (regmatch('^(The Gatekeeper of Alterac|A lieutenant of the Brettonian High Command)$', {_mob})) \
	/if (_quickdraw & humanslay!~'') \
		/weapon slayhuman%;\
	/endif%;\
	/if (warlock>1) \
		/d fire%;\
	/else \
		/d slayhuman normal%;\
	/endif%;\
  /elseif ({_mob}=~'A Champion of Alterac') \
	/weapon champion horgar fire%;\
	/d fire%;\
  /elseif ({_mob}=~'An Elven waywatcher ') \
	/if (_quickdraw=1) \
	  /weapon slayelf unlife iron%;\
	/endif%;\
	/d slayelf unlife dark%;\
  /elseif (regmatch('^(A lugroki berserker|The lugroki Warlord|A lugroki raider|A lugroki veteran|A lugroki marauder|a lugroki bloodling|A lugroki runner|A lugroki seeker)$', {_mob})) \
	/if (_quickdraw=1) \
	  /weapon slaylugroki pure fire%;\
	/endif%;\
	/d slaylugroki pure fire light%;\
  /elseif ({_mob}=~'A lugroki prisoner') \
	/if (_quickdraw=1) \
	  /weapon pure light%;\
	/endif%;\
	/d light pure%;\
; Underworld
  /elseif (regmatch('^(Ajax the Greater|Musaeus of Athens|A member of the Trojan Royal House)$', {_mob})) \
	/if (_quickdraw=1) \
	  /weapon underworld dark%;\
	/endif%;\
	/d member unlife underdark dark%;\
  /elseif (regmatch('^(A brave soldier|A valiant soldier)$', {_mob})) \
	/if (_quickdraw=1) \
	  /weapon underworld dark pure%;\
	/endif%;\
	/d underdark dark pure%;\
; Khron    
  /elseif (regmatch('^(Khronatian Gatehouse Guard|A Guard of Khron)$', {_mob})) \
	/if (_quickdraw=1) \
	  /weapon khron slayhuman water%;\
	/endif%;\
	/d khron water%;\
  /elseif ({_mob}=~'A ghost of a decapitated woman') \
	/if (_quickdraw=1) \
		/weapon decap water%;\
	/endif%;\
	/d decap water%;\
; Whitebridge
  /elseif (regmatch('^(The Golem of Keleof Dragonmoon, the First Chancellor\
|The Golem of Isen Shadowlock, the Second Chancellor|The Golem of Leying Greendawn, the Third Chancellor\
|The Golem of Redmark Fallrage, the Fourth Chancellor|The Golem of Masdeb Helmbreak, the Fifth Chancellor\
|The Golem of Armuel Blackspear, the Seventh Chancellor|The Golem of Dasean Nightbreaker, the Eighth Chancellor\
|The Golem of Debthas Hawktree, the Sixth Chancellor|The Golem of Dasean Nightbreaker, the Eighth Chancellor\
|The Golem of Armuel Blackspear, the Seventh Chancellor)$', {_mob})) \
	/if (quickdraw=1) \
	  /weapon plain%;\
	/endif%;\
	/d plain%;\
; Oblivion
  /elseif ({_mob}=~'The nightwalker') \
    /if (_quickdraw=1) \
      /weapon plain%;\
    /endif%;\
    /d nightwalker%;\
  /elseif (regmatch('^(A scamp|The Torturer|A vermai|The devourer|A clannfear|A nalfeshnee|A Daedroth|An Elite Daedroth|The Spider Daedra|The Dremora|The Guardian of Oblivion|Nocturnal|Meridia)$', {_mob})) \
  	/if (_quickdraw=1) \
  	  /weapon slaydemon pure light iron%;\
  	/endif%;\
  	/d slaydemon pure light%;\
  /elseif (regmatch('^(A fire daedra|A greater fire daedra)$', {_mob})) \
    /if (_quickdraw=1) \
      /weapon ice slaydemon %;\
    /endif%;\
    /d ice slaydemon%;\
  /elseif (regmatch('^(A frost daedra|A greater frost daedra)$', {_mob})) \
    /if (_quickdraw=1) \
      /weapon fire slaydemon%;\
    /endif%;\
    /d fire slaydemon%;\
  /elseif ({_mob}=~'A Sharn') \
    /if (_quickdraw=1) \
      /weapon slaymagical unlife%;\
    /endif%;\
    /d slaymagical unlife%;\
  /endif%;\
  /if (regmatch('^(The Draconian Attendant|Ajax|Musaeus|A member of the Trojan Royal House|A drow elite guard|A drow instructor|A royal guard|The Royal Doorguard|A Brettonian man-at-arms|An Alliance counsellor\
	  |The laen golem|Lord Ceanyth|The mithril golem|Lady Nydethiel|The Dragon Master|The priestess of the crescent moon hive\
	  |Zeus|Hera|Poseidon|Shiva|Ra|Apollo|Athena|Ares|Hephaestus|King Minos)$', {_mob})) \
	  /set sanc_mob=1%;\
  /else \
	  /set sanc_mob=0%;\
  /endif

