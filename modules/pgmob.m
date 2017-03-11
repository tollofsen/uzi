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

/def -F -mregexp -t"^The eyes of the ([^ ]+) head glow with a " uzi_pgmob_takhisis_1 = \
    /set uzi_pgmob_spec_kiki=0%;\
    /if ({P1}=~'blue') \
        /d fire%;\
    /elseif ({P1}=~'red') \
        /d ice%;\
    /elseif ({P1}=~'green') \
        /d unlife%;\
    /elseif ({P1}=~'orange') \
        /d energy%;\
    /elseif ({P1}=~'purple') \
        /set uzi_pgmob_spec_kiki=1%;\
    /endif

/def -F -mglob -t"Takhisis slashes *'s throat wide open!" uzi_pgmob_takhisis_2 = \
    /set uzi_pgmob_spec_kiki=0%;\
    /w slaydragon%;\
    /d slaydragon

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
/def -F -mregexp -t"^The Daedra Lord Azimer suddenly slams you with his tail. The force" uzi_pgmob_azimer = \
    5e3u2e

/def -F -mregexp -p12003 -t'^The Daedra Lord Azimer is here, fighting' uzi_pgmob_azimer1 = \
    /set uzi_pgmob_azimer=1

;;;; Gith
/def -F -msimple -t'The Torture Master of the Gith utters some strange words and transforms into a HUGE blood-suckying bat soaring overhead.' uzi_pgmob_gith0 = \
    /set pgmob_spec_gith=1

/def -F -msimple -t'A vampiric bat with HUGE wings settles back to the room floor and bellows with anger!' uzi_pgmob_gith1 = \
    /unset pgmob_spec_gith


;;;; Worm

/def -F -msimple -t'The breeding chamber' uzi_pgmob_worm1 = \
    /set uzi_pgmob_spec_1=1%;\
    /areas

/def -F -msimple -t'Being digested by the Primeval Worm' uzi_pgmob_worm2 = \
    /set uzi_pgmob_spec_worm_2=1%;\
    flee

/def -F -E(uzi_pgmob_spec_worm_2=1) -msimple -p12300 -t"PANIC! You couldn't escape!" uzi_pgmob_worm3 = \
    flee

/def -F -E(uzi_pgmob_spec_worm_2=1) -msimple -p12300 -t"It is too crowded to move that way!" uzi_pgmob_worm4 = \
    flee


;;;; Draconian Jailor
/def -F -ah -mregexp -t'^The Draconian Jailor picks up ([^ ]+) and runs away from battle.$' uzi_pgmob_sarakesh = \
    /if (priest>0) \
        summon %{P1}%;\
    /endif


;;;; Thorn Demon
/def -F -msimple -t'Thorny Plain' uzi_pgmob_thorndemon = \
    /areas


;;;; Taon
/def -F -mregexp -p21300 -t'^Celebros, the Embodiment of Control is here, fighting' uzi_pgmob_taon0 = \
    /set wildmagic=1

/def -F -msimple -t'The Chamber of Running Water' uzi_pgmob_taon1 = \
    remove %{weapon}%;\
    /set remweapon=1


;; Solus
/def -F -msimple -t'The Solus gateway' uzi_pgmob_solus = \
    /areas
