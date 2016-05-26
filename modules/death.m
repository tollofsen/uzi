;// vim: set ft=tf

/if (criticalbeep=~'') /set criticalbeep=1%;/endif
/if (logondeath=~'') /set logondeath=1%;/endif

/def -p3 -aBCmagenta -t'You are dead!  Sorry...*' reneter = \
        /if (logondeath=1) \
 	  /log %{uzidirectory}/logs/%{char}.txt%;/recall /200%;/log off%;\
        /endif%;\
        1%;\
        aff%;\
        /repeat -0:00:10 1 /spellup%;\
        /if ({hometown} =/ 'Midgaard') \
          s%;\
        /elseif ({hometown} =/ 'Myrridon') \
          w%;w%;\
        /endif%;\
        /if (criticalbeep=1) \
          /beeper%;\
        /endif%;\
        /reset_affects

/def -p3 -mregexp -t'^\[INFO\] ([A-z]+) (killed by|was|died|committed|cunningly|bled)' tank_killed= \
	/if ({P1}=~tank & oldtank=~char) \
	  /echo -aBCcyan *** DOH DOH DOH DOH DOH DOH DOH DOH %;\
          /set oldtank=%{tank}%;\
          /set leaderdied=1%;\
          /if (criticalbeep=1) \
            /beeper%;\
          /endif%;\
          /set wimpylevel2=%{wimpylevel}%;\
	  /set wimpylevel=$[{wimpylevel}+{wimpyplus}]%;\
	/endif
