; // vim: set ft=tf:
;autoassist triggers
/set assist=1
/set aggmob=0

/def assist = \
    /if ((fighting=0 & assist=1 & sentassist=0 & (coptype=2|coptype=4))|(assist=1 & {1}=~'forceassist')) \
        /send assist%;\
        /set sentassist=1%;\
    /endif

/def -aBCred -mregexp -t'^Who should the spell be cast upon\?$|^Backstab who\?$|^Headbang who\?$|^The wimp isn\'t here!$' resass = \
    /set fighting=0%;\
    /resetdamage

/def -aBCred -mregexp -t'^Whom do you wish to assist\?$|^But .* is not fighting anybody!$' resass2 = \
    /set onpromptassist=%;\
    /set fighting=0%;\
    /set sentassist=0%;\
    /endoffight

/def -p99 -F -mregexp -t'You (miss|pierce|massacre|obliterate|annihilate|vaporize|pulverize|atomize|ultraslay|\*\*\*ULTRASLAY\*\*\*)' positionfighting = \
    /joindamage

/def -mregexp -p98 -F -t'You receive [0-9]+ experience points.|[^ ]* panics, and attempts to flee|You seem unable to recognise your foe....' ass2 = \
    /if ({2} =/ 'panics,' & ismember({1},gplist) = 1) \
    /else \
        /set endoffight=1%;\
        /set sentassist=0%;\
        /set tickison=0%;\
        /set fighting=0%;\
        /set berserk=0%;\
        /set deathdance=0%;\
        /set aggmob=$[{aggmob}-1]%;\
        /if (aggmob=0) \
            /if (spellup=~'null') \
                /spellup%;\
            /endif%;\
        /endif%;\
        /summonqueue%;\
    /endif

; Re-assist after pet rescue
/def -E{assist} -F -p1 -mregexp -t'^You are rescued by ([A-z]+)\'s ([A-z ]+), you are confused!' _petrescue2 = \
    /set fighting=0%;\
    /set sentassist=0%;\
    /assist

; Pet Assists  (thx to Gorog)
/def -F -p1 -mregexp -t'^([A-z]+)\'s ([A-z]+)( Elemental|) (massacres|obliterates|annihilates|vaporizes|pulverizes|atomizes|ultraslays|\*\*\*ULTRASLAYS\*\*\*) ([A-Za-z]+)' autoassist1pet = \
    /if  (ismember({P1}, gplist)=1 & fighting=0 & assist=1) \
        /assist%;\
    /endif

; Auto assist pets if they're fighting
/def -F -p1 -mregexp -t'([A-z]+) (massacres|obliterates|annihilates|vaporizes|pulverizes|atomizes|ultraslays|\*\*\*ULTRASLAYS\*\*\*) ([A-z]+)\'s ([A-z]+)( Elemental|)' autopetassist1 = \
    /if  (ismember({P3}, gplist)=1 & fighting=0 & assist=1) \
        /assist%;\
    /endif

/def -mregexp -p98 -F -t'is not fighting anybody' ass2_2 = \
    /set tickison=0%;\
    /if (spellup=~'null' & aggmob=0) \
        /spellup%;\
    /endif%;\
    /set attackspell=1%;\
    /set fighting=0


/def -F -mregexp -t'^You are rescued by ([A-z]+)\, you are confused!' ass3 = \
    /set fighting=0%;\
    /set sentassist=0%;\
    /assist

/def -F -mglob -t'{*} tells the group, \'bs *\'' ass_gt = /assist

/def -F -mregexp -t'is here, fighting ([^\.]*)' ass_fight = \
    /if ((autocop=1)&(coppen=1)) \
        /set coppen=0%;\
        cop%;\
    /endif%;\
    /if (ismember({P1},gplist) =~ 1) \
        /set aggmob=$[{aggmob}+1]%;\
        /if (aggmob>1 & areaspells=1) \
            /set areafight=1%;\
        /endif%;\
    /endif

/def -mregexp -t'assists ([^\.]*)' ass_ass = /assist


/def -p1 -mregexp -t'([A-Za-z]+) rushes to attack ([A-Za-z]+)' autoass99 = \
    /if ((autocop=1)&(coppen=1)) \
        /set coppen=0%;\
        cop%;\
    /endif


/def -F -p1 -mregexp -t'([A-Za-z]+) (massacres|obliterates|annihilates|vaporizes|pulverizes|atomizes|ultraslays|\*\*\*ULTRASLAYS\*\*\*|\*\*\*U\*L\*T\*R\*A\*S\*L\*A\*Y\*S\*\*\*) ([A-Za-z]+)' autoassist1 = \
    /assist


;;;;;;;;;;;;;
;GroupAssist;
;;;;;;;;;;;;;
/def as = \
    /set aggmob=0%;\
    /if (assist=0) \
        /set assist=1%;\
        /ecko Assisting %{htxt2}%tank %{ntxt}and %{htxt2}Group%{ntxt}.%;\
        /if (coptype=2|coptype=4) \
            toggle aggressive off%;\
            toggle autoassist off%;\
        /else \
            toggle aggressive on%;\
            toggle autoassist on%;\
        /endif%;\
    /elseif (assist=1) \
        /set assist=0%; \
        /ecko Will %{htxt2}NOT %{ntxt}assisting %tank or Group.%;\
        toggle aggressive off%;\
        toggle autoassist off%;\
    /endif%;\

