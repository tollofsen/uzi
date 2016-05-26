;// vim: set ft=tf
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
        /if ($[substr(_tmpcont, strlen(_tmpcont)-1, 1)] =~ '!') \
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
        /gc %watercont water drink %watercont

/def -mglob -t'You are hungry.' eat= \
    /if (priest>0 & foodcont=~'' & currentmana > 10 & nomag=0) \
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
    save%;/repeat -0:05 1 /antiidle%;\
    /if (uziautosave=1) /saveall q%;/endif

/antiidle

/set status_int_clock=ftime("%H:%M", time())

/def -mglob -t"{*} tells you 'ping'" pingpong = tell %{1} PONG

/def -mglob -t"{*} tells you 'version'" versioncheck = \
    /let seconds=$[time() - tf_start_time]%;\
    /if (OSTYPE =~ 'linux-gnu') \
        /let _mostype=GNU/Linux%;\
    /else \
        /let _mostype=$(/quote -S /echo !uname)%;\
    /endif%;\
    tell %{1} TinyFugue $(/ver) + Uzi(%uziversion) \
    (os: %_mostype TF-uptime: $[seconds/86400] days, $[mod(seconds/3600,24)]:$[mod(seconds/60,60)]:$[mod(seconds,60)])

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
    /lood modules/autohealvalues.m%;\
    /lood modules/changechar.m%;\

    /def -F -p99 -mglob -t'The Temple Square' temple_square_check = \
        /set _roomcheck=1%;\
        /set currentroom=The Temple Square

/def -F -p99 -mglob -t'The Fountain Square of Karandras' fountain_square_of_karandras_check = \
    /set _roomcheck=1%;\
    /set currentroom=The Fountain Square of Karandras


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
    /set sentassist=0%;\
    /set onpromptassist=%;\
    /set walkdir=0%;\
    /set cop=0%;\
    /if (areaspells=1) \
        /set areafight=1%;\
    /endif%;\
    /if (didfoc=1) \
        /repeat -0:00:02 1 /set didfoc=0%;\
    /endif%;\
    /set fighting=0%;\
    /set groupass=1%;\
    /set tickison=0%;\
    /if (sentgroup=1) \
        /repeat -0:00:01 1 /set sentgroup=0%;\
    /endif%;\
    /if (exitspellup!~1) \
        /spellup%;\
        /set exitspellup=1%;\
        /repeat -0:00:30 1 /set exitspellup=0%;\
    /endif

/def butch = \
    /let i=%{1}%; \
    /while (i>0) \
        butcher %{i}.corpse%;/let i=$[i - 1]%;\
    /done

/def -p99999 -F -mglob -t'You receive*' lootcor = \
    /if (autobutcher=1) \
        /if (wannabutcher<0) \
            /set wannabutcher=0%;\
        /endif%;\
        /set wannabutcher=$[{wannabutcher}+1]%;\
        /butch %{wannabutcher}%; \
    /endif%; \
    /if (autoloot=1) \
        get all corpse%; \
    /endif

/def -mglob -t'{You butcher Corpse of*|Only an animist can butcher this corpse.|You carve the heart*|Sorry, no \'*\' here to butcher.*}*' didbutcher = \
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

