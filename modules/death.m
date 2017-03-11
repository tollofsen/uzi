; // vim: set ft=tf:

/if (criticalbeep=~'') /set criticalbeep=1%;/endif
/if (logondeath=~'') /set logondeath=1%;/endif

/def -p3 -aBCmagenta -t'You are dead!  Sorry...*' reenter = \
    /if (logondeath=1) \
        /log %{uzidirectory}/logs/%{char}.txt%;/recall /2000%;/log off%;\
    /endif%;\
    /set death=1%;\
    /set protectee=%;\
    /set aura=%;\
    1%;\
    aff%;\
    /set oldweapon=%{weapon}%;\
    /repeat -0:00:05 1 /spellup%;\
    /repeat -0:00:10 1 /buycorpse%;\
     /if ({hometown} =/ 'Karandras') \
        s%;\
    /elseif ({hometown} =/ 'Myrridon') \
        w%;w%;\
    /endif%;\
    /resetdamage%;\
    /reset_affects

/def buycorpse = \
    /if (idle()>30 & autobuy) \
        /if ({hometown} =/ 'Karandras') \
            s%;s%;w%;w%;w%;buy corpse%;\
        /elseif ({hometown} =/ 'Myrridon') \
            e%;e%;n%;n%;buy corpse%;\
        /endif%;\
    /endif%;\

/def -p3 -mregexp -t'^\[INFO\] ([A-z]+) (killed by|was|died|committed|cunningly|bled)' tank_killed= \
    /if ({P1}=~tank & oldtank=~char) \
        /echo -aBCcyan *** DOH DOH DOH DOH DOH DOH DOH DOH %;\
        /set oldtank=%{tank}%;\
        /set tankdied=1%;\
        /if (criticalbeep=1) \
            /beeper%;\
        /endif%;\
        /set wimpylevel2=%{wimpylevel}%;\
        /set wimpylevel=$[{wimpylevel}+{wimpyplus}]%;\
    /endif
