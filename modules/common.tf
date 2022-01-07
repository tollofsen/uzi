; // vim: set ft=tf:
;;;;;;;;;;;;;;;;
;Standard Stuff;
;;;;;;;;;;;;;;;;

/def gc = \
	/if ({1} !~ '') \
		/gpcontainer get %*%;\
	/else \
		/ecko Usage: %htxt2\gc <object> %htxt[ s[croll] | w[eapon] | f[ood] | p[otion] | wa[ter]] [commands]%;\
	/endif

/def pc = \
	/if ({1} !~ '') \
		/gpcontainer put %*%;\
	/else \
		/ecko Usage: %htxt2\gc <object> %htxt[ s[croll] | w[eapon] | f[ood] | p[otion] | wa[ter] ] [commands]%;\
	/endif

/def gpcontainer = \
	/let _method=%1%;\
	/let _object=%2%;\
	/let _tmpcont=%3%;\
	/let _commands=$[replace(';','%;', {-3})]%;\
	/if (_tmpcont !~ '') \
		/if (substr(_tmpcont, strlen(_tmpcont)-1, 1) =~ '!') \
			/let _skipsec=%_method%;\
		/endif%;\
		/if (_tmpcont =/ 's*') \
			/let _container=%scrollcontainer%;\
			/if (getscrollcontainer=1) /let _pickup=1%;/endif%;\
		/elseif (_tmpcont =/ 'f*') \
			/let _container=%foodcont%;\
			/if (getfoodcont=1) /let _pickup=1%;/endif%;\
		/elseif (_tmpcont =/ 'p*') \
			/let _container=%potioncontainer%;\
			/if (getpotioncontainer=1) /let _pickup=1%;/endif%;\
		/elseif (_tmpcont =/ 'wa*') \
			/let _container=%watercont%;\
			/if (getwatercont=1) /let _pickup=1%;/endif%;\
		/elseif (_tmpcont =/ 'w*') \
			/let _container=%weaponcontainer%;\
			/if (getweaponcontainer=1) /let _pickup=1%;/endif%;\
		/else \
			/let _container=%container%;\
		/endif%;\
	/else \
		/if (_object =/ '*scroll' | _object =/ '*rec' | _object =/ '*iden*' | _object =/ 'all.id' | _object =/ 'id' | _object =/ '*parch' | _object =/ '*parchment') \
			/let _container=%scrollcontainer%;\
			/if (getscrollcontainer=1) /let _pickup=1%;/endif%;\
		/elseif (_object =/ '*potion' | _object =/ '*amb' | _object =/ '*ambrosia' | _object =/ '*ambr') \
			/let _container=%potioncontainer%;\
			/if (getpotioncontainer=1) /let _pickup=1%;/endif%;\
		/elseif (_object =/ '*bread' | _object =/ '*grape') \
			/let _container=%foodcont%;\
			/if (getfoodcont=1) /let _pickup=1%;/endif%;\
		/else \
			/let _container=%container%;\
		/endif%;\
	/endif%;\
	/if (_container=~'') \
		/let _container=%container%;\
	/endif%;\
	/if (_pickup = 1) \
		/if (_skipsec !~ 'put') \
			get %_container %container%;\
		/endif%;\
		%_method %_object %_container%;\
		/if (_commands !~ '') \
			/eval %_commands%;\
		/endif%;\
		/if (_skipsec !~ 'get') \
			put %_container %container%;\
		/endif%;\
	/else \
		%_method %_object %_container%;\
		/if (_commands !~ '') \
			/eval %_commands%;\
		/endif%;\
	/endif%;\


	/def -mglob -t'You are thirsty.' drink= \
;    /if (animist>0 & currentmana > 10 & nomag=0) \
;        cast 'Satiate'%;\
;    /else \
		/gc %watercont%;\
		drink %watercont%;\
		/pc %watercont%;\
;    /endif

/def -mglob -t'You are hungry.' eat= \
	/if (animist>0 & currentmana > 10 & nomag=0) \
		cast 'Satiate'%;\
	/elseif (priest>0 & foodcont=~'' & currentmana > 10 & nomag=0) \
		cast 'Create Food'%;\
		get mushroom%;\
		eat mushroom%;\
	/else \
		/gc %food food eat %food%;\
	/endif

/def -mglob -t'It\'s empty.' refill = \
	/if (priest>0) \
		gc %watercont%;\
		cast 'Create Water' %watercont%;\
		drink %watercont%;\
		pc %watercont%;\
	/endif


/def -ag -mregexp -t'^$' gagwhitespace
/def -ag -mregexp -t'^ $' gagwhitespace2

/def antiidle = \
	save%;/set borg=on%;/repeat -0:05 1 /antiidle%;\
	/if (uziautosave=1) /saveall q%;/endif

/antiidle

;/set status_int_clock=ftime("%H:%M", time())

/def -mglob -t"{*} tells you 'ping'" pingpong = tell %{1} PONG

/def -mglob -t"{*} tells you 'version'" versioncheck = \
	/if (OSTYPE =~ 'linux-gnu') \
		/let _mostype=GNU/Linux%;\
	/else \
		/let _mostype=$(/quote -S /echo !uname)%;\
	/endif%;\
	tell %{1} TinyFugue $(/ver) + Uzi %{uziversion} %{gitcommit} \
	(os: %_mostype)

/def -mregexp -t'^Saving ([A-Za-z]+).$' Checkifnewchar = \
	/if ({P1}!~char) \
		/ecko Uzi have noticed that you are playing a different char!%;\
		/ecko If you would like to load this chars default values (or fix a new savefile)%;\
		/ecko type %{htxt2}/chchar %{ntxt}and look for further actions.%;\
		/if (uziautosave=0) \
			/ecko (don't forget to save your current settings.. /saveall )%;\
		/endif%;\
	/endif

/def chchar = \
	/if (uziautosave=1) \
		/saveall%;\
	/endif%;\
	aff%;\
	/lood modules/autohealvalues.tf%;\
	/lood modules/changechar.tf


/def -F -p99 -msimple -t'The Fountain Square of Karandras' fountain_square_of_karandras_check = \
	/set at_temple=2%;\
	/set in_underworld=0


/def -F -mglob -t'Obvious exits: *' resetvars = \
	/if (_roomcheck=~1) \
		/set _roomcheck=2%;\
	/elseif (_roomcheck=~2) \
		/set _roomcheck=0%;\
		/set currentroom=%;\
	/else \
		/set _roomcheck=0%;\
		/set currentroom=%;\
	/endif%;\
	/set nomag=0%;\
	/set aggmob=0%;\
	/set mobs=0%;\
	/set sentassist=0%;\
	/set onpromptassist=%;\
	/set walkdir=0%;\
	/set cop=0%;\
	/set countmob=1%;\
	/set aggarea=0%;\
	/set stalag_mode=0%;\
	/set stalac=0%;\
	/set sanc_mob=0%;\
	/quote -S /unset `/listvar -s uzi_pgmob_spec_*%;\
	/if (no_gate_report>0) \
		/test --no_gate_report%;\
	/endif%;\
	/if (nyx_spec>0) \
		/test --nyx_spec%;\
	/endif%;\
	/if (areaspells=1) \
		/set areafight=1%;\
	/else \
		/set areafight=0%;\
	/endif%;\
	/set areaspells=0%;\
	/if (didfoc=1) \
		/repeat -0:00:02 1 /set didfoc=0%;\
	/endif%;\
	/set fighting=0%;\
	/set tickison=0%;\
	/if (ddcoping=2) \
		/set ddcoping=3%;\
	/else \
		/set ddcoping=0%;\
	/endif%;\
	/if (exitspellup!~1) \
		/spellup%;\
		/set exitspellup=1%;\
		/repeat -0:00:30 1 /set exitspellup=0%;\
	/endif%;\
	/if (drow_spec>0) \
		/test --drow_spec%;\
	/endif%;\
	/if (worm_fight>0) \
		/test --worm_fight%;\
	/endif%;\
	/if (worm_belly>0) \
		/test --worm_belly%;\
	/endif%;\
	/if (uzi_lloth_room>0) \
		/test --uzi_lloth_room%;\
	/endif%;\
	/if (in_well>0) \
		/test --in_well%;\
	/endif%;\
	/if (in_well<1 & welltempest>0) \
		/set welltempest=0%;\
	/endif%;\
	/if (guallidurth_move_group>0) \
	  /test --guallidurth_move_group%;\
	/endif%;\
	/if (_peek_peeking<1) \
		/if (wildmagic>0) \
			/test --wildmagic%;\
		/endif%;\
		/if (well_waterroom>0) \
			/test --well_waterroom%;\
		/endif%;\
		/if (temp_nofight>0) \
			/test --temp_nofight%;\
		/endif%;\
		/if (at_temple>0) \
			/test --at_temple%;\
		/endif%;\
		/if (welltempest=1 & well_waterroom=0 & position=~'stand') \
			sit%;\
		/endif%;\
	/endif

/def butch = \
	/let i=%{1}%; \
	/if (solobutcher=1) \
		/if (tank=~char) \
			group self%;\
		/else \
			follow self%;\
		/endif%;\
	/endif%;\
	/while (i>0) \
		butcher %{i}.corpse%;/let i=$[i - 1]%;\
	/done%;\
	/if (solobutcher=1) \
		/if (tank=~char) \
			group all%;\
		/else \
			follow %{tank}%;\
		/endif%;\
	/endif

/def -p99999 -F -msimple -t"You can't gain more experience." lootcor2 = \
	/if (autobutcher=1) \
		/if (wannabutcher<0) \
			/set wannabutcher=0%;\
		/endif%;\
		/set wannabutcher=$[{wannabutcher}+1]%;\
		/butch %{wannabutcher}%; \
	/endif%; \
	/if (autoloot=1 & (leading=1|ingroup<1)) \
		get all corpse%; \
	/endif


/def -p99999 -F -mglob -t'You receive*' lootcor = \
	/if (autobutcher=1) \
		/if (wannabutcher<0) \
			/set wannabutcher=0%;\
		/endif%;\
		/set wannabutcher=$[{wannabutcher}+1]%;\
		/butch %{wannabutcher}%; \
	/endif%; \
	/if (autoloot=1 & (leading=1|ingroup<1)) \
		get all corpse%; \
	/elseif (regentloot=1) \
		get all.regent corpse%;\
	/endif

/def -mregexp -t'^You butcher Corpse of|^Only an animist can butcher this corpse.$|^You carve the heart|^Sorry, no \'.*\' here to butcher.$' didbutcher = \
	/test wannabutcher:=%{wannabutcher}-1

/def loot = \
	/if (autoloot=1) \
		/set autoloot=0%;/ecko You won't search all corpses for loot!%;\
	/else \
		/set autoloot=1%;/ecko You will now loot corpses automatically!%;\
	/endif

/def butcher = \
	/if (autobutcher=1) \
		/set autobutcher=0%;/ecko You will leave the butchering to someone else.%;\
	/else \
		/set autobutcher=1%;/ecko You will now auto-butcher!%;\
	/endif

/def -msimple -E{leave_quest} -t'Okay, you leave your current quest.' leave_quest1 =\
	/set leave_quest=0

/def -msimple =E{leave_quest} -t'Are you sure you want to leave your quest?' leave_quest2 =\
	/send yes

/def -msimple -E{leave_quest} -t'That\'s not a direction.' leave_quest3 =\
	/set leave_quest=0

/def leave_quest = \
	leave quest%;\
	/set leave_quest=1%;\
	/repeat -0:00:02 1 /set leave_quest=0

/def beeper = \
	/beep%;\
	/beep%;\
	/beep%;\
	/beep%;\
	/beep%;\
	/beep%;\
	/repeat -0:00:00 5 /beep%;\
	/repeat -0:00:01 1 /beep%;\
	/repeat -0:00:01 1 /beep%;\
	/repeat -0:00:01 1 /beep

