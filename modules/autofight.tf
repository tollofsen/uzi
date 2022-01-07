;// vim: set ft=tf:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;===================================
;   Autofight
;===================================

/if (fighter>0) \
	/def ber = \
		/if (autoberserk=0) \
			/set autoberserk=1%%;\
			/ecko Berserk ON (You will try until you succeed)%%;\
		/elseif ((autoberserk) & (!berserktryonce)) \
			/set berserktryonce=1%%;\
			/ecko Berserk ON (You will only try once)%%;\
		/else \
			/set autoberserk=0%%;\
			/set berserktryonce=0%%;\
			/ecko Berserk OFF%%;\
		/endif%;\
	/endif

/if (fighter>1) \
	/def dd = \
		/if (autodeathdance=0) \
			/set autodeathdance=1%%;\
			/ecko Deathdance ON%%;\
		/else \
			/set autodeathdance=0%%;\
			/ecko Deathdance OFF%%;\
		/endif%;\
	/endif

/def dodamage = \
	/if (autofight=1 & sentdamage<1 & fighting=1 & protectee=~'' & groupRescue<1 & xsdamage<1 & ingroup=1 & temp_nofight<1 & aheal<1) \
		/debug %Y DODAMAGE %damage attackspell=%attackspell fighting=%fighting promptdamage=%promptdamage%;\
		/if (waitstate<2 | aura=~'Quickness') \
			/set waitstate=0%;\
		/endif%;\
		/if (fighter > 0 & (autodeathdance|autoberserk)) \
			/if (autodeathdance=1 & deathdance=0) \
				deathdance%;\
			/else \
				/if (autoberserk=1 & berserk=0) \
					berserk%;\
					/if (berserktryonce=1) \
						/set berserk 1%;\
					/endif%;\
				/else \
					/if (damage!~'-') \
						/repeat -%{waitstate} 1 /senddamage%;\
					/endif%;\
				/endif%;\
			/endif%;\
		/else \
			/if (damage!~'-') \
				/repeat -%{waitstate} 1 /senddamage%;\
			/endif%;\
		/endif%;\
;        /set lspell=nothing%;\
		/set cantstab=0%;\
		/if (damage!~'-') \
			/test ++sentdamage%;\
		/endif%;\
	/endif

/def senddamage = \
	/if (fighting=1 & autofight=1) \
		/if (sanc_mob=1 & sanc_smarts=1 & promana<80 & (rogue|nightblade)=0) \
			/setlodam%;\
			/if (lodam!~'' & lodam!~'-') \
				%lodam%;\
			/else \
				/test --sentdamage%;\
			/endif%;\
		/elseif (damage!~'' & damage!~'-') \
			/if (uzi_pgmob_spec_azimer=1) \
				%damage lord%;\
			/elseif (worm_fight>0) \
				%damage primeval%;\
			/else \
				%damage%;\
			/endif%;\
		/else \
			/test --sentdamage%;\
		/endif%;\
	/else \
		/set sentdamage=$[sentdamage - 1]%;\
	/endif%;\
	/set nomag=0

/def promptdamage = \
	/if (sentdamage<1 & fighting=1 & aheal=0) \
		/dodamage%;\
	/endif%;\
	/set waitstate=0%;\
	/set joinfight=0%;\
	/set promptdamage=1

/def repeatdamage = \
	/if (damage_analyzer>0) \
;        & (sentdamage=1|autofight=0)) \
		/do_damage_analysis%;\
	/endif%;\
	/if (sentdamage>0) \
		/test --sentdamage%;\
   /endif%;\
   /set tickison=0

/def joindamage = \
	/if (fighting=0) \
		/set endoffight=0%;\
		/set joinfight=1%;\
		/set fighting=1%;\
		/set position=stand%;\
		/set sentassist=0%;\
		/if (areaspells=1) \
			/set areafight=1%;\
		/endif%;\
	/endif

/def resetdamage = \
	/debug %E RESET%;\
	/set tickison=0%;\
	/set fighting=0%;\
	/set berserk=0%;\
	/set deathdance=0%;\
	/set endoffight=1%;\
	/set sentdamage=0

/def endoffight = \
	/set tickison=0%;\
	/set fighting=0%;\
	/set berserk=0%;\
	/set deathdance=0%;\
	/set endoffight=1


;;; patterns

/def -Eautofight -aBCred -t'Kinda hard right now*' dam_on_switch = \
	/set cantstab=1%;\
	/repeatdamage
;    /if (nightblade = 0) \
;        /repeat -0:00:01 1 /repeatdamage%;\
;    /else \
;        cast 'ATTACK'%;\
;    /endif

/def -Eautofight -aBCred -mglob -t'You can\'t seem to sneak around the back of your target!' dam_on_switch2 = \
	/debug @{B}Retrying damage..%;\
	/set cantstab=1%;\
	/repeatdamage

/def -mregexp -aCmagenta -t'^(You join the fight|You rush to attack)' startfight = \
	/joindamage

/def -mglob -t'No way! You are fighting for your life!' startfight4 = \
	/joindamage

/def -mglob -t'* shrugs off your pathetic magic.' mobshrug = \
	/repeatdamage

/def -mglob -p1 -F -aBCred -t'You retreat from the melee with *' mobretreat = \
	/set fighting=0%;/repeat -0:00:10 1 /endoffight%;/repeatdamage

/def -aBCred -mglob -t'Flames lick *\'s body, scorching *! BBQ, get the ketchup!' startfight2 = \
	/set immo=1%;/joindamage

/def -aBCcyan -mglob -t'Ah, * doesn\'t seem to like the cold very much...' startfight3 = \
	/set immo=2%;/joindamage

/def -aBCred -mglob -p999 -t'*you nearly cut you*' repeatdam01 = \
;    /if (damage=~'m') \
;        /set waitstate=3%;\
;    /endif%;\
	/test ++stabmisses%;\
	/repeatdamage


/def -aBCgreen -mglob -p999 -t'*makes a strange sound as you place*' repeatdam02 = \
	/if (damage=~'m' | damage=~'murder') \
		/set waitstate=3%;\
	/endif%;\
	/countstab%;\
	/repeatdamage

/def -aBCgreen -mglob -p999 -t'*makes a strange sound but is suddenly very silent*' repeatdam03 = \
	/set deathstab=1%;\
	/countstab%;\
	/repeatdamage

/def -aBCred -mglob -p999 -t'*detects your pathetic backstab attempt and charges!' repeatdam04 = \
	/set cantstab=1%;\
	/joindamage

/def -aBCgreen -mregexp -p999 -t'^You draw a sharp blade across .* throat opening a second mouth, blood gushing!$|You slice open .* throat, blood streams out like a fountain!' repeatdam05 = \
	/set deathstab=1%;\
	/countstab%;\
	/repeatdamage

/def -msimple -F -t'You disengage battle and sneak to the rear.' repeatdam06 = \
	/set waitstate=3

/def -aBCgreen -mregexp -Fp999 -t'^You clout .* on the head but .* survives the blow.$\
|^You smash .* on the head with your weapon causing .* to stagger violently.$\
|^You bring your weapon crashing down on .* and split .* head open like a watermelon.$\
|^You smash .* across the temple with your weapon, .* head explodes from the force\!$\
|^You stab .* deep in the back, piercing an organ and causing .* a lingering death.$\
|^You stab .* deep in the back, searching for an organ to pierce.$\
|^You drive your blade deep into the base of .*\'s skull, instantly turning .* into a lifeless jelly.$\
|^You drive your blade into the base of .*\'s skull but only just puncture the skin.$\
|^You slice .*\'s neck, your feeble assassination resembling a shaving cut.$\
|^You draw your blade across .*\'s throat but fail to kill .* outright.$\
' repeatdam07 = \
	/set fighting=1%;\
	/countstab%;\
	/repeatdamage

/def -mregexp -aBCred -Fp999 -t' senses your attempt to skewer .* brain and dodges your amateurish assassination attempt.$\
| senses your approach and evades your kill strike.$\
|sidesteps your assassination effort, laughing in your face as .* does.$\
|dodges your crude assassination effort and you topple forward embarassingly.$\
|spins round and eludes your attempt to assassinate .*.$\
|becomes aware of your assassination attempt and darts to the side out of harms way.$\
' repeatdam08 = \
	/set fighting=1%;\
	/test ++stabmisses%;\
	/repeatdamage

/def -aBCred -mglob -p999 -t'*detects your pathetic assassination attempt and charges!' repeatdam09 = \
	/set cantstab=1%;\
	/joindamage

/def -msimple -aBCred -t'Try assassinating the wimp first!' repeatdam10 = \
	/set fighting=0%;\
	/repeatdamage


;;;;;;;;;;;;;;;;;;;;;;;
;; Failing to damage ;;
;;;;;;;;;;;;;;;;;;;;;;;

/def -mregexp -aBCred -t'^(With your bare hands, good luck\!|You need to wield a weapon, to make it a success.)$' noweap_backstab = \
	/ecko Try wielding a weapon!%;\
	/repeatdamage

;;;;;;;;;;;;;;;;;;;;;;;
;;Immunity/Restistant;;
;;;;;;;;;;;;;;;;;;;;;;;

/def -msimple -aCred -t'You need more target practice!' ice_immune = \
	/ecko IMMUNE ICE!!!%;\
	/if (autofight=1) \
		/if (rogue>0) \
			/set hidam=ba%;\
			/set midam=ba%;\
			/set damage=ba%;\
		/else \
			/d fire%;\
		/endif%;\
	/endif%;\
	/repeatdamage

/def -mregexp -aCred -t' seems impervious to the effects of the ice.$' ice_immune2 = \
	/d fire

/def -mregexp -aCred -t'ducks your bolt effectively.$' fire_immune = \
	/ecko IMMUNE FIRE!!!%;\
	/if (autofight=1) \
		/if (rogue>0) \
			/set hidam=ba%;\
			/set midam=ba%;\
			/set damage=ba%;\
		/else \
			/d normal%;\
		/endif%;\
	/endif%;\
	/repeatdamage

/def -mregexp -aCred -t' seems impervious to the effects of fire.$' fire_immune2 = \
	/d ice

/def -mregexp -aCred -t'You miss .* with your burning hands.' fire2_immune = \
	/ecko IMMUNE FIRE!!!%;\
	/if (autofight=1) \
		/d normal%;\
	/endif%;\
	/repeatdamage

/def -mglob -aCred -t'As I told ya, nothing can\'t do anything...' netherb_immune = \
	/ecko IMMUNE UNLIFE!!!%;\
	/if (autofight=1) \
		/if (rogue>0) \
			/set hidam=ba%;\
			/set midam=ba%;\
			/set damage=ba%;\
		/else \
			/d fire ice normal%;\
		/endif%;\
	/endif%;\
	/repeatdamage

;;;;;;;;;;;;;;;;
;;Damage stuff;;
;;;;;;;;;;;;;;;;
/def resdam = \
	/set attackspell=0

; Adrenal focus
; -------------

/def foc = \
	/if (nightblade > 1) \
		/if (autofocus=0) \
			/set autofocus=3%;\
			/uecko Keeping Adrenal Focus on!%;\
		/else \
			/set autofocus=0%;\
			/uecko Not recasting Adrenal Focus!%;\
		/endif%;\
	/elseif (nightblade > 0) \
		/if (autofocus=0) \
			/set autofocus=1%;\
			/uecko Focus I: Casting focus when you are not fighting.%;\
		/elseif (autofocus=1) \
			/set autofocus=2%;\
			/uecko Focus II: Casting focus only in fights.%;\
		/elseif (autofocus=2) \
			/set autofocus=3%;\
			/uecko Focus III: Always cast focus.%;\
		/else \
			/set autofocus=0%;\
			/uecko Focus 0: Never cast Adrenal Focus!%;\
		/endif%;\
		/if (focusmana1 < 2) \
			/uecko %htxt2 Use /setfocus to set mana.%;\
		/endif%;\
	/else \
		/uecko This only works if you are Nightblade.%;\
	/endif

/def setfocus = \
	/if ({1} !~ '' & {2} !~ '') \
		/set focusmana1=%1%;\
		/set focusmana2=%2%;\
		/ecko Upper Mana: %1 Lower Mana: %2%;\
	/else \
		/ecko Usage: /setfocus <uppermana> <lowermana>%;\
	/endif


/def adr = \
	/if (didfoc = 0 & nightblade > 0) \
		/if (fighting=0 & currentmana>focusmana1 & (autofocus=1|autofocus=3) & focus=0 & ingroup=1) \
			cast 'adrenal focus'%;\
			/set didfoc=1%;\
			/set spellup=focus%;\
		/elseif (fighting=1 & currentmana>focusmana2 & autofocus>1 & focus=0) \
			cast 'adrenal focus'%;\
			/set didfoc=1%;\
			/set spellup=focus%;\
		/endif%;\
	/endif


/def -aBCblue -mregexp -t'^Your thoughts and body become as one\!$|^You continue your concentration.$' gotfocus= \
	/set focus=1%;/gotspell focus

/def -msimple -aCblue -t'Your deadly concentration breaks.' refocus= \
	/set focus=0%;/set didfoc=0%;/adr

/def -mregexp -t'gets a deadly look' focus3= \
	/adr

;

/def -mglob -t'You quickly focus your energy on a blow.' reattack = \
	/repeatdamage

/def -msimple -aBCmagenta -t"Let's do nothing, nothing at all!" netherb= \
	/repeatdamage

/def -msimple -aBCmagenta -t"Ah, see what nothing can do! Now A playful child is nothing too! :)" netherb_death = \
	/repeatdamage

/def -mglob -aBCmagenta -t'Now nothing did something, seems to have hurt * badly...' netherb2 = \
	/repeatdamage

/def -p2 -mglob -F -aBCred -t'You hurl a ferocious barrage of fire bolts.' tofb = \
	/repeatdamage

/def -p2 -mglob -F -aBCred -t'The triad of fire bolts blast *, engulfing * in searing flame.' tofb2

/def -p2 -mglob -F -aBCcyan -t'You unleash a spiralling volley of ice bolts.' toib = \
	/repeatdamage

/def -p2 -mglob -F -aBCcyan -t'The triad of ice bolts tears through *, freezing * solid.' toib2

/def -p2 -mglob -aBCred -t'Your bolt hits * hard, and leaves a burn mark big as a fist.' fireb= \
	/repeatdamage

/def -p2 -mglob -aBCred -t'You throw a fireball at * and have the satisfaction of seeing * enveloped in flames\!' fireb2= \
	/repeatdamage

/def -p2 -mglob -aBCred -t'You look after the blazing ball of flames that shoots out of your palm.' fireb3 = \
	/repeatdamage

/def -p2 -F -msimple -aBCred -t'When the flames die all that remain are some charred teeth.' fireb_death = \
	/repeatdamage

/def -mregexp -aBCcyan -t'Your water bolt hits .* in the head, almost drowning' waterb = \
	/repeatdamage

/def -msimple -aBCcyan -t'Now where is that spatula?!' waterb_death = \
	/repeatdamage

/def -p2 -mglob -aBCred -t'You slam * with your meteor bolt, bullseye\!' meterorb = \
	/repeatdamage

/def -p2 -mglob -aBCwhite -t'You watch with self pride as your magic missile hits*' mmissile = \
	/repeatdamage

/def -p2 -F -mglob -aBCwhite -t'The magic missile tears away the remaining life of *!' mmissile_death = \
	/repeatdamage

/def -F -p2 -mglob -aBCwhite -t"Ah, let's give * heartmassage." autofight_shockbolt = \
	/repeatdamage

/def -F -p2 -mglob -aBCwhite -t"Small sparks run up and down * chest..." autofight_shockbolt2 = \
	/repeatdamage

/def -F -p2 -mglob -aBCwhite -t"Your heartstimula stopped *'s heart..." shockb_death = \
	/repeatdamage

/def -F -p2 -aCred -mglob -t"You enshroud * in vampiric mists." vampiricmist = \
	/repeatdamage

/def -F -p2 -aCred -msimple -t"You are enshrouded in your own vampiric mists!" autofight_vampiricmist_fail = \
	/repeatdamage

/def -p2 -mglob -t'You circle around the back of your target and stab *' circle_1 = \
	/repeatdamage

/def -p2 -mglob -t'You try to circle around the back of *' circle_2 = \
	/repeatdamage

/def -p2 -mglob -aB -t'You pummel *' pummel_1= \
	/set waitstate=3%;\
	/repeatdamage

/def -p2 -msimple -aB -t'You fail your pummel.' pummel_2= \
	/repeatdamage

/def -p2 -mglob -t'You try to pummel *, but you miss.' pummel_3 = \
	/repeatdamage


/def -msimple -aB -t'Maybe you should be fighting before you pummel?' pummel_4 = \
	/repeatdamage

/def -mregexp -aBCcyan -t'^SPLAM! Bulls eye, the ice bolt hit .* right in .* face!' iceb= \
	/repeatdamage

/def -msimple -aBCcyan -t'Man he got a hole in his body! Yeah you won!' iceb_death = \
	/repeatdamage

/def -p2 -aB -mregexp -t'^You (try to grab|grab) .*\'s head' headb= \
	/repeatdamage

/def -F -aB -mglob -t"You crush *'s head with your bony DANISH head!" headb_death = \
	/repeatdamage

/def -mregexp -aB -t'^You call forth raw elemental energy.$|^You focus your will.$|^You call forth the flames of HELL!$\
|^You utter a single arcane word of pain.$|^You utter a single arcane word of power.$' otherb=\
	/repeatdamage

/def -aBCblue -mregexp -t'You feel a HUGE adrenaline rush!!!  You will FIGHT TO THE DEATH!' berserk = \
	/set berserk=1%;\
	/repeatdamage

/def -F -mregexp -t'You become humble again.' berserk_off = /set berserk=0%;/set deathdance=0

/def -msimple -t'You grumble a lot but nothing happens.' berserk_nofight= \
	/repeatdamage

/def -mregexp -t'You fail to find enough energy.' berserk2 = \
	/repeatdamage

/def -msimple -aBCwhite -t'You call upon your gods to pass judgement.' judgement1 = \
	/repeatdamage

/def -p2 -mglob -t'You enshroud * in vampiric mists.' vampm = \
	/repeatdamage

/def -aCyellow -mglob -t'Ah, they are lovely, aren\'t they?' insectsplague = \
	/repeatdamage

/def -aCgreen -mglob -t'You chant for transformation.' sticksofsnakes = \
	/repeatdamage

/def -aCyellow -mglob -t'You make a blistering beam of light strike from the sky.' sunarrow = \
	/repeatdamage

/def -aCgreen -mglob -t'You make a handful of seeds glow fiery red and hurl them at *' fireseeds = \
	/repeatdamage

/def -mglob -t'As * avoids your bash, you topple over and fall to the ground!' bash1 = \
	/set fighting=1%;\
	stand%;\
	/repeatdamage

/def -mglob -t'Your bash at * sends * sprawling!' bash2 = \
	/set fighting=1%;\
	/repeatdamage

/def -p2 -mglob -aBCcyan -F -t"You chill *!" autofight_chilltouch = \
	/repeatdamage

/def -p2 -mglob -aBCcyan -F -t'You chill *, remember to put flowers on * grave...' chilltouch_death = \
	/repeatdamage


/def -p2 -mglob -aBCcyan -F -t"The atmosphere turns chilly as you miss *!" autofight_chilltouch_2 = \
	/repeatdamage

/def -p2 -msimple -aBCcyan -F -t"Your fingers crackle as you concentrate on charging the air." autofight_shockinggrasp = \
	/repeatdamage

/def -mglob -F -t'You burned * to death!' bhands_death = \
	/repeatdamage

/def -mglob -F -t'You burn * with your hot little hands!' bhands = \
	/repeatdamage

;;;;;;;;;;;;;;;
;AREA SECTIONS;
;;;;;;;;;;;;;;;
/alias ajoin /areatojoin
/def areatojoin = \
	/if (areatojoin=1) /set areatojoin=0%;/echo -aBCblue *** Won't area to join automatically.%;\
	/else /set areatojoin=1%;/echo -aBCred *** You will area in if you can't see the mob.%;/endif

/def -aCmagenta -mglob -t'You can\'t see who is fighting *!' areain = \
	/if ((areaspells)&(autofight)=1) \
		%{damage}%;/set lspell=%{damage}%;\
	/elseif ((areatojoin)&(autofight)=1) \
		%{areadam}%;/set lspell=%{areadam}%;\
	/endif

/def -msimple -aB -t'You call forth swirling elemental energy.' pballarea =\
	/repeatdamage

/def -msimple -aB -t'You bring up black fire from hell to engulf all monsters!' hstarea = \
	/repeatdamage

/def -msimple -aB -t'You suddenly swell to gigantic proportions and utter a WORD to smite your foes!' mpainarea = \
	/repeatdamage

/def -msimple -aB -t'The air around you starts to move faster and faster, forming a raging hurricane.' hurricanearea = \
	/repeatdamage

/def -msimple -aB -t'You make scorching beams of light lance down from the sky.' sunrayarea = \
	/repeatdamage

/def -msimple -aB -t'You call for a horde of insects, rodents and reptiles to help you.' deadlyswarmarea = \
	/repeatdamage

/def -msimple -aB -t'You yell a single arcane word of power.' deathspellarea = \
	/repeatdamage

/def -mregexp -aB -t'^You whirl your .* over your head and go to attack...|You frantically flail your arms in the air, trying to impersonate a whirlwind...' uzi_autofight_area_whirlwind = \
	/repeatdamage

/def areas = \
	/ecko %htxt2\AREAS! AREA SPELLS %ntxt\will be casted in the next room.%;\
	/set areaspells=1%;\
	/set areafight=1

/def singles = \
	/set areaspells=0%;\
	/set areafight=0%;\
	/ecko Single spells will be casted.

; deathdances
/def -mregexp -aBCred -t'You feel too tired for a dance of death right now\.' deathdancetired = \
	/set deathdance=1%;\
	/repeatdamage

/def -mregexp -aBCgreen -t'You concentrate your thoughts and begin your deadly display of weapon prowess\.' deathdanceon = \
	/set deathdance=2%;\
	/repeatdamage

/def -msimple -t"You can't seem to get the right rhythm to do it." deathdancefail = \
	/set deathdance=1%;\
	/repeatdamage

/def -aBCcyan -mregexp -t'With no opponents left, you end your dashing display of weapon skill' deathdanceoff = \
	/set deathdance=0

/def -aB -msimple -t'You need to be fighting someone first!' uzi_autofight_deathdance_nomob = \
	/set fighting=0%;\
	/repeatdamage

/def -aB -msimple -t'You jumble the words as you attempt to cast.' uzi_autofight_confusion = \
	/repeatdamage

/def -aB -msimple -t"You can't do anything, you're turned to stone!" uzi_autofight_stoned = \
	/repeatdamage

/def -mglob -F -p23112 -t'The water weird is here, fighting*' rp_weird = \
	/if ((priest|nightblade|animist|templar) > 0) \
		retreat%;cast 'remove poison' weird%;\
	/endif

