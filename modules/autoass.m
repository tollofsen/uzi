;// vim: set ft=tf
;autoassist triggers
/set groupass=1
/set assist=1
/set aggmob=0

/def assist = \
    /if ({1}!~'' & groupass=1 & {1} !/'forceassist') \
        /if (ismember({1}, gplist) =~ 1) \
            /if ({1}=~tank & ass_tank=1) \
                /doassist %{1}%;\
            /elseif (ass_group=1) \
                /doassist %{1}%;\
            /endif%;\
        /elseif ({2}!~'') \
            /if (ismember({2}, gplist) =~ 1) \
                /if ({1}=~tank & ass_tank=1) \
                    /doassist %{1}%;\
                /elseif ({2}=~tank & ass_tank=1) \
                    /doassist %{2}%;\
                /elseif (ass_group=1) \
                    /doassist %{2}%;\
                /endif%;\
            /endif%;\
        /endif%;\
    /elseif (ass_tank=1 & assist=1 & {1}=/'forceassist') \
        /ecko Assisting %{htxt2}%{tank} %{ntxt}(Forced Tankass)%;\
        /doassist %{tank}%;\
    /endif%;\
    /set groupass=0%;\
    /if ((tickison=0)&(groupass=1)) \
        /set tickison=1%;\
    /elseif ((tickison=0)&(groupass=0)) \
    /endif%;\
    /set attackspell=1

/def doassist = \
    /if (position =~ 'sleep') \
        wake%;\
    /elseif (position !~ 'stand') \
        stand%;\
    /endif%;\
    /if (sentassist=0) \
        /set sentassist=1%;\
        /if (areaspells=1) \
            /joindamage%;\
        /elseif (!gameassist) \
            /if ({1} =~ tank) \
                /ecko Assisting %{htxt2}%{1} %{ntxt}(Tankass)%;\
            /else \
                /ecko Assisting %{htxt2}%{1} %{ntxt}(Groupass)%;\
            /endif%;\
            assist%;\
        /endif%;\
    /endif%;\
    /set groupass=0

;/def -mglob -p99 -t'*splits * coins among your group.  You receive * of them.' splitcash= \
;	/resetdamage
;Who should the spell be cast upon?|Whom do you wish to assist|and attempts to flee' ass2 = \


/def -aBCred -mglob -t'{Who should the spell be cast upon?*|Backstab who?*|Headbang who?*|The wimp isn\'t here!*}*' resass = \
    /set fighting=0%;\
    /if (spellup=~'null' | autofocus=1) \
        /set didfoc=0%;\
    /endif%;\
;    /if (endoffight=0) \
        /resetdamage%;\
        /set onpromptassist=%;\
;    /endif

/def -aBCred -mglob -t'{Whom do you wish to assist?*|But * is not fighting anybody!*}*' resass2 = \
    /set onpromptassist=%;\
    /set sentassist=0%;\
    /endoffight

/def -p99 -F -mregexp -t'You (miss|pierce|massacre|obliterate|annihilate|vaporize|pulverize|atomize|ultraslay|\*\*\*ULTRASLAY\*\*\*)' positionfighting = \
    /joindamage

/def -mregexp -p98 -F -t'You receive [0-9]+ experience points.|[^ ]* panics, and attempts to flee|You seem unable to recognise your foe....' ass2 = \
    /if ({2} =/ 'panics,' & ismember({1},gplist) = 1) \
    /else \
        /set endoffight=1%;\
        /if (fighting=1) \
            /set sentassist=0%;\
        /endif%;\
        /set groupass=1%;\
        /set tickison=0%;\
        /set fighting=0%;\
        /set berserk=0%;\
        /set deathdance=0%;\
        /set endoffight=1%;\
        /set aggmob=$[{aggmob}-1]%;\
        /if (aggmob>0 & assist=1 & !gameassist) \
            /if (sentassist=0 & damage!~areadam & areaspells!= 1) \
                /ecko Still %{htxt2}%{aggmob} aggs%{ntxt}! Assisting %{htxt2}%{tank}!%;\
                /doassist %{tank}%;\
            /else \
                /ecko Still %{htxt2}%{aggmob} aggs%{ntxt}! Not assisting now ;-)%;\
            /endif%;\
        /else \
            /set aggmob=0%;\
            /if (spellup=~'null') \
                /spellup%;\
            /endif%;\
        /endif%;\
        /summonqueue%;\
    /endif

; Re-assist after pet rescue
/def -E{assist} -F -p1 -mregexp -t'^You are rescued by ([A-z]+)\'s ([A-z ]+), you are confused!' _petrescue2 = \
    /assist%; /ecko Assisting..

; Pet Assists  (thx to Gorog)
/def -F -p1 -mregexp -t'^([A-z]+)\'s ([A-z]+)( Elemental|) (massacres|obliterates|annihilates|vaporizes|pulverizes|atomizes|ultraslays|\*\*\*ULTRASLAYS\*\*\*) ([A-Za-z]+)' autoassist1pet = \
    /if  (ismember({P1}, gplist)=1 & fighting=0 & assist=1) \
        /assist %{P2}%;\
    /endif

; Auto assist pets if they're fighting
/def -F -p1 -mregexp -t'([A-z]+) (massacres|obliterates|annihilates|vaporizes|pulverizes|atomizes|ultraslays|\*\*\*ULTRASLAYS\*\*\*) ([A-z]+)\'s ([A-z]+)( Elemental|)' autopetassist1 = \
    /if  (ismember({P2}, gplist)=1 & fighting=0 & assist=1) \
        /assist %{P3} %{P2}%;\
    /endif

/def -mregexp -p98 -F -t'is not fighting anybody' ass2_2 = \
    /set groupass=1%;/set tickison=0%;\
    /if (spellup=~'null' & aggmob=0) \
        /spellup%;\
    /endif%;\
    /set attackspell=1%;\
    /set fighting=0


/def -F -mregexp -t'^You are rescued by ([A-z]+)\, you are confused!' ass3 = \
    /set fighting=0%;/set groupass=1%;/set sentassist=0%;/assist %{P1}

/def -F -mglob -t'{*} tells the group, \'bs *\'' ass_gt = /assist %{tank}
/def -F -mglob -t'{*} {stabs|places|tries to backstab}*' ass_stab = /assist %{1}
/def -F -mglob -t'The room darkens as ([^ ]*) draws back his flickering blade to strike...' ass_dark = /assist %{4}

/def -F -mregexp -t'is here, fighting ([^\.]*)' ass_fight = \
    /if ((autocop=1)&(coppen=1)) /set coppen=0%;cop%;/endif%;\
    /if (ismember({P1},gplist) =~ 1) \
        /set aggmob=$[{aggmob}+1]%;\
        /if (aggmob>1 & areaspells=1) \
            /set areafight=1%;\
        /endif%;\
        /set onpromptassist=%{P1}%;\
    /endif

/def -mregexp -t'assists ([^\.]*)' ass_ass = /assist %{P1}

/def -mglob -t'{*} heroically' ass_rescue = /assist %{1}

/def -mregexp -t'detects ([^ ^\']*)\'s' ass_detecy = /assist %{P1}

/def -mregexp -t'sense ([^\']*)\'s presence' ass_pres = /assist %{P1}

/def -mregexp -t'([^ ]*)\'s (brings it down upon\
    |diamond edged sword\
    |emerald sword begin to\
    |mind flail sparkles with energy as it is swung through the air\
    |Runeblade \'Lawbringer\' thrusts into\
    |sword as (he|it|she) lashes out to strike.\
    |sword lets out a cry\
    |sword flares to life as flames engulf the blade on its downward arc\.\
    |Torture blade is jabbed towards it next)' ass_1 = \
    /assist %{P1}

/def -mregexp -t'([^ ]*) \
    (slashes at|lashes out towards\
    |as his gigantic maul descends with immense\
    |whirls his\
    |drives (her|his) mace towards\
    |lunges at|cackles gleefully as\
    |swings it in an arc down\
    |lashes out with a tendril of\
    |lifts the mighty sword best known as the dragon slayer high above\
    |brings it down upon (his|her|its) foes\.\
    |swings his sword of fire leaving a trail of flames behind as he strikes\.\
    |draws back his flickering blade to strike\
    |swings the Karliik Llar over\
    |lunges forward, trying to jab\
    |raises a fishing rod\
    |raises a huge iron scimitar in readiness for the coming battle\.\
    |who harnesses it to use an ungodly power\
    |gets ready for combat!\
    |calls upon powers from the youth of time!!)' ass_2 = /assist %{P1}


/def -mregexp -t'^as the little blade passes through the air you feel like committing a sin\
    |A black cloud erupts from the soul reaper as it whirls towards its next victim\!\
    |A dark cloud forms above\
    |A great waterfall emerges above\
    |a honed shortsword \'Zedraikis\' bursts into flames\
    |A stream of fire seemingly burns into\
    |A sudden rip appears in this plane of existance as the Claws of\
    |A large iron blade lunges forward into\
    |a wicked flaming bastard sword named Flametongue burns brightly as\
    |A shining light falls forth from the heavens to glorify the coming\
    |As the onyx dagger named \'Chakara the souldrainer\' drinks its victims first\
    |As the shadowblade slices through the air, a dark shape is faintly seen\
    |As the two-handed sword strikes its target it seems warp\
    |Blue light ripples like water from the flowing blue longsword\
    |Borimar\'s mace forms a head and sighs heavily\
    |Branches and trees shoot up through the ground as the force of the\
    |Dark purple energy circles the Skean-dhu and as it penetrates\
    |Flames leap from the mace of crimson towards it\'s awaiting\
    |Flames shoot across your face and strike the opponent as Pathweavers is\
    |Focused energy beams from the Pathweavers blade with the power\
    |For a second the wind stops howling, only to return with even more ferocity as\
    |Freezing cold aids the wielder of Frostbite - the sword of winter\
    |Ice shoots out of the earth as the royal ice dagger strikes down\.\
    |Oh nooo\!\!\! It\'s the Claw, nothing can stop the Claw from penetrating\
    |Poisons and acids sink deep into the flesh of\
    |Scenes from battles fought by Brightblades from ages past flash through\
    |shadows that slowly transfrorm into a blade of solid shadows\, known as Nemesis\
    |Sizzling bolts of pure, white energy streak forth like wildfire, as\
    |Sparks flies\
    |Swirling magical energy trails the strike made by the Halo\'ki\
    |Taxor begins to vibrate intensly with contained power, and a bright\
    |The atmosphere starts to shiver and suddenly an implosion\
    |The air turns cold and frosty as the power of Frigid is released\
    |The earth shivers and dark mist surrounds\
    |the Ethereal Slayer hums with power as tendrils of lightning dance along its length\
    |The hills of the earth shudder as power is unleashed by the\
    |The image of a great minotaur warrior momentarily flashes in the air as\
    |The immaculate Dirk deeply sinks into the flesh of its next victim\
    |The light dims as energy is dispelled from the red crystal staff\
    |The Mace of Wickedness cackles insanely\
    |The power of destiny strikes with the energy of ice on the prey of\
    |The screams of a legion of souls pierce the air as they await a new brethren\
    |the sword of the Sun channels raw sunlight has it hits\
    |The Skaven Fang tweaks the fabric of light as it strikes\!\
    |The sky turns crimson as serpents scream through the air as\
    |The wolf headed battle staff hums as it twirls in the air\!\
    |The world suddenly goes deadly silent...time seems to stand still\
    |The world turns\, shakes, and shudders as the blade of\
    |There is a crack as fire erupts from the blade causing the victim\
    |You hear a pitiful scream as\
    |You hear the wailing of a woman in the distance as\
    |With a faint swooshing sound, the ghostly spear pierce through the air\
    |You hear Umar\
    |With a faint swooshing sound, the ghostly sword slices through the air' ass4 = \
    /eval /assist %{tank}

/def -p1 -mregexp -t'([A-Za-z]+) rushes to attack ([A-Za-z]+)' autoass99 = \
    /if ((autocop=1)&(coppen=1)) /set coppen=0%;cop%;/endif%;\
    /if (fighting=0) \
        /if (ismember({P1}, gplist) = 1) \
            /set onpromptassist=%P1%;\
        /elseif (ismember({P2}, gplist) =1) \
            /set onpromptassist=%P2%;\
        /endif%;\
    /endif


/def -F -p1 -mregexp -t'([A-Za-z]+) (massacres|obliterates|annihilates|vaporizes|pulverizes|atomizes|ultraslays|\*\*\*ULTRASLAYS\*\*\*|\*\*\*U\*L\*T\*R\*A\*S\*L\*A\*Y\*S\*\*\*) ([A-Za-z]+)' autoassist1 = \
    /assist %{P3} %{P1}


;;;;;;;;;;;;;
;GroupAssist;
;;;;;;;;;;;;;
/def as = \
    /set aggmob=0%;\
    /if ({1} !~ '') /set ass_act=%{1}%;\
        /if (ass_act=~'t') \
            /set ass_tank=1%;/set ass_group=0%;/ecko Assisting %{htxt2}%tank Only.%; \
        /elseif (ass_act=~'g') \
            /set ass_tank=1%;/set ass_group=1%;/ecko Assisting %{htxt2}Group %{ntxt}and %{htxt2}%tank%{ntxt}.%;\
        /endif%;\
    /else \
        /set ass_act=toggle%;\
        /if ((ass_act=~'toggle')&(assist=0)) \
            /set assist=1%;/set ass_tank=1%;/set ass_group=1%;\
            /ecko Assisting %{htxt2}%tank %{ntxt}and %{htxt2}Group%{ntxt}.%;\
        /elseif ((ass_act=~'toggle')&(assist=1)) \
            /set assist=0%;/set ass_tank=0%;/set ass_group=0%; \
            /ecko Will %{htxt2}NOT %{ntxt}assisting %tank or Group.%;\
        /else \
            /set assist%;/set ass_tank%;/set ass_group%; \
        /endif%;\
    /endif

/def a_isinlist = /if (%{tankperson}=/%1) /set inassistlist=1%; /endif
/def a_checkingroup = \
    /mapcar /a_isinlist %{gplist}

/def assistgroup = /if (inassistlist=1) assist %tankperson%; \
    assist %tank%; /set groupass=0%;/echo -aBCmagenta Assisting %tankperson.
