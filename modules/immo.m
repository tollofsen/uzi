; // vim: set ft=tf:
;;;;;;;;;;;;;;;;;;;;;;;;
; -- Aura of Despair
;;;;;;;;;;;;;;;;;;;;;;;;
/set autoaod=0

/def -p2 -aBCmagenta -mglob -t'You radiate pure evil as despair fills your heart.' gotaod = \
    /set aod=1%;\
    /gotspell aod

/def -p2 -aBCblack -mglob -t'Invisible evil radiates outward, engulfing * in despair.' aod_hilite1 = \
    /set aod=1%;\
    /gotspell aod

/def -p2 -aBCblack -mglob -t'* is overcome by despair, and lies down to die.' aod_hilite2 = \
    /set aod=1%;\
    /gotspell aod

/def -p2 -aBCmagenta -mglob -t'Your aura of despair dissolves.' stopaod = \
    /set aod=0

/def -Eautoaod -p2 -aBCmagenta -mglob -t'Your aura of despair turns into a cool wind and dissipates.' reaod = \
    /respell aod

/def despair = \
    /if (({1} =~ 'off') & (aod=1)) \
        cast 'aura of despair' off%;\
        /set autoaod=0%;\
    /elseif ((({1} =~ 'on') | ({1} =~ '')) & (aod=0)) \
        cast 'aura of despair'%;\
        /set autoaod=1%;\
    /endif

/def -Enightblade -p3 -F -mregexp -t"([A-z]+) tells the group, 'despair (on|off)'" despairtell = \
    /if ({P1} =~ tank) \
        /if ({P2} =~ 'off') \
            /despair off%;\
        /else \
            /despair on%;\
        /endif%;\
    /endif


;;;;;;;;;;;;;;;;;;;;;;;;
; -- Immolation
;;;;;;;;;;;;;;;;;;;;;;;;
/set autoimmo=0
/set immotype=off

; -- Immolation Fire
/def -p2 -aBCmagenta -mglob -t'You throw a handful of sulphur over your head and ignite it\!' gotimmof = \
    /set immo=1%;\
    /set immotype=fire%;\
    /gotspell immof

/def -p2 -aBCred -mregexp -t'^Flames lick .* scorching .* BBQ, get the ketchup\!$|^Your flames engulf .* and totally consume|^You are already a torch.$' immo_hilite1 = \
    /set immo=1%;\
    /set immotype=fire%;\
    /gotspell immof

/def -p2 -aBCmagenta -mglob -t'Hmmm... Seems like sulphur don\'t burn too long \:\(' reimmof = \
    /set immo=0%;\
    /respell immof

; -- Immolation Ice
/def -p2 -aBCmagenta -mglob -t'You burst into flames but suddenly realize your mistake and quickly transform fire to ice.' gotimmoc = \
    /set immo=1%;/set immotype=cold%;/gotspell immoc

/def -p2 -aBCcyan -mregexp -t'^Ah, .* doesn\'t seem to like the cold very much...$|turns into an ice statue, and taking advantage of this you kick out hard.$|^You know blue flames are hard to make, and you still have em going\!$' immo_hilite2 = \
    /set immo=1%;/set immotype=cold%;/gotspell immoc

/def -p2 -aBCmagenta -mglob -t'Water begins to flow from your shoulders, it\'s springtime\!' reimmoc = \
    /set immo=0%;\
    /if (autoimmo) \
        /respell immoc%;\
    /endif

/def -p2 -aBCmagenta -mglob -t'Fire and cold, ah back to normal\!' stopimmo = \
    /set immotype=off%;\
;	/set autoimmo=0%;\
/set immo=0

/def -Ewarlock -p3 -F -mregexp -t"([A-z]+) tells the group, 'immo (fire|cold|off)'" immotell = \
    /if ({P1} =~ tank) \
        /if ({P2} =~ 'off') \
            /immo off%;\
        /elseif ({P2} =~ 'fire') \
            /immo fire%;\
        /elseif ({P2} =~ 'cold') \
            /immo cold%;\
        /endif%;\
    /endif

/def immo = \
    /if (({1} =~ 'off') & (immo=1)) \
        /if ({immotype} =~ 'fire') \
            cast 'Immolation Cold'%;\
            /set spellup=immoc%;\
        /elseif ({immotype} =~ 'cold') \
            cast 'Immolation Fire'%;\
            /set spellup=immof%;\
        /endif%;\
        /set autoimmo=0%;\
    /elseif ({1} =~ 'cold') \
        /if (immo=0) \
            cast 'Immolation Cold'%;\
        /elseif (%{immotype} =~ 'fire' & immo=1) \
            cast 'Immolation Cold'%;\
            cast 'Immolation Cold'%;\
        /endif%;\
        /set spellup=immoc%;\
        /set autoimmo=1%;\
    /elseif ({1} =~ 'fire') \
        /if (immo=0) \
            cast 'Immolation Fire'%;\
        /elseif ({immotype} =~ 'cold' & immo=1) \
            cast 'Immolation Fire'%;\
            cast 'Immolation Fire'%;\
        /endif%;\
        /set spellup=immof%;\
        /set autoimmo=1%;\
    /endif


;;;;;;;;;;;;;;;;;;;;;;;;
; -- Holy Aura
;;;;;;;;;;;;;;;;;;;;;;;;

/set autohaura=0

/def -Etemplar -p3 -F -mregexp -t"([A-z]+) tells the group, 'aura (on|off)'" auratell = \
    /if ({P1} =~ tank) \
        /if ({P2} =~ 'off') \
            /haura off%;\
        /else \
            /haura on%;\
        /endif%;\
    /endif

/def haura = \
    /if (({1} =~ 'off') & (haura=1)) \
        cast 'holy aura' off%;\
        /set autohaura=0%;\
    /elseif ((({1} =~ 'on') | ({1} =~ '')) & (haura=0)) \
        cast 'holy aura'%;\
        /set autohaura=1%;\
    /endif

/def -p2 -aBCmagenta -mglob -t'May the god be with me.' gothaura = \
    /set haura=1%;\
    /gotspell haura

;Dam
/def -p2 -aBCwhite -mglob -t'Your holy aura engulfs * who screams in anguish.' haura_hilite = \
    /set haura=1%;\
    /gotspell haura

;takedown
/def -p2 -aBCmagenta -mglob -t'God is no longer with you and your holy aura fades away.' rehaura = \
    /set haura=0%;\
    /if (autohaura) \
        /respell haura%;\
    /endif
