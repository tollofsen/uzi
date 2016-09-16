; // vim: set ft=tf:

;;;;Lloth
/def -mglob -t'Lloth\'s Time Stop comes to an end, and you shift back into the fabric of time\!' llothtimelock = \
    /ecko TIMELOCK!!! PANIC!!%;\
    /resetdamage%;\
    /if (aheal>0) \
        /set groupsent=0%;\
        gg%;\
    /endif

; Takhisis
/def -msimple -t'The Shoikan Grove' uzi_pgmob_takhisis_0 = \
    /if (magician>0 & ingroup=1 & tank!~char) \
        enwn%;\
    /endif

/def -F -ah -mregexp -t"^The eyes of the ([^ ]+) head glow with a " uzi_pgmob_takhisis_1 = \
    /if ({P1}=~'blue') \
        /d fire%;\
    /elseif ({P1}=~'red') \
        /d ice%;\
    /elseif ({P1}=~'green') \
        /d unlife%;\
    /elseif ({P1}=~'orange') \
        /d energy%;\
    /elseif ({P1}=~'purple') \
        /d heal%;\
    /endif

; Zandramas
/def -F -mregexp -t"^([^ ]+) looks rather pale and shaken as (he|she|it) jumps through the Flames\." uzi_pgmob_zandramas_0 = \
    /if ({P1}=~tank & ingroup=1) \
        enter flame%;\
    /endif

/def -F -ah -msimple -t"You are pushed into the claws of darkness, you feel a strange feeling." uzi_pgmob_zandramas_1 = \
    /if (ingroup=1) \
        3n2e3n2e%;\
        enter flame%;\
    /endif

; Ghalotiri
/def -F -t"{*} gets a huge mound of gold coins from Corpse of Ghalotiri, the leader of the Medjai\." uzi_pgmob_ghalotiri = \
    /if (ingroup=1) \
        /set areaspells=1%;\
    /endif

;;;; Azimer
/def -F -t"The Daedra Lord Azimer suddenly slams you with his tail. The force*" uzi_pgmob_azimer = \
    5e3u2e

