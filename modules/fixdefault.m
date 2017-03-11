; // vim: set ft=tf:
;;;;;;;

/def fixinghidamage = \
    /let _word=%1%;\
    /let _result=%;\
    /while (shift(), {#}) \
        /ifhisetlo %{1} %{_word}%;\
        /done

/def ifhisetlo = \
    /eval /set templo=%%{hi%{1}}%;\
    /if ({templo}!~'') \
        /set cdam_lo%{1}=%{2}%;\
    /endif%;\
    /unset templo

/def autodefineautoass = \
    /set autofight=1%;\
    /if (templar>0) \
        /set cdam_hipure=jdg%;\
        /set cdam_lopure=jdg%;\
        /set autochange=1%;\
        /if (templar>1) \
            /set sanctype=sanc%;\
            /set pr=self%;\
        /endif%;\
    /endif%;\
    /if (warlock>0) \
        /set cdam_hiunlife=nb%;\
        /set cdam_lounlife=nb%;\
        /set cdam_hifire=fb%;\
        /set cdam_lofire=fb%;\
        /set cdam_hiice=ib%;\
        /set cdam_loice=ib%;\
        /set cdam_hinormal=nb%;\
        /set cdam_lonormal=nb%;\
        /set autochange=1%;\
        /if (warlock>1) \
            /set cdam_hifire=tof%;\
            /set cdam_hiice=toi%;\
            /set cdam_hinormal=toi%;\
        /endif%;\
    /endif%;\
    /if (magician>0) \
        /set cdam_hifire=hf%;\
        /set cdam_hinormal=pwp%;\
        /set autochange=1%;\
        /if (magician>1) \
            /set cdam_hienergy=pb%;\
            /set cdam_loenergy=for%;\
            /set cdam_hifire=hf%;\
            /set cdam_lofire=for%;\
            /set cdam_hinormal=pb%;\
            /set cdam_lonormal=for%;\
        /endif%;\
    /endif%;\
    /if (nightblade>0) \
        /fixinghidamage murder %{spellist}%;\
        /set autochange=1%;\
        /set autofocus=1%;\
        /if (nightblade>1) \
            /set damage=murder%;\
            /set autochange=0%;\
        /endif%;\
    /endif%;\
    /if (rogue>0) \
        /if (rogue>1 | nightblade>0 | fighter>0) \
            /set autochange=0%;\
            /set damage=backstab%;\
        /else \
            /fixinghidamage backstab %{spellist}%;\
        /endif%;\
    /endif%;\
    /if (fighter>0) \
        /if (rogue=0 & nightblade=0) \
            /set autoberserk=1%;\
        /endif%;\
    /endif%;\
    /lood modules/autohealvalues.m%;\
    /set tank=-%;\
    /repeat -0:00:02 1 /autodefinelevels%;\

/def autodefinelevels = \
;;Autowimpy on 25% :P
    /set autowimpy=1%;\
    /set wimpylevel=$[{maxhp}*0.25]%;\
    /set wimpyplus=$[{maxhp}*0.15]
;;
