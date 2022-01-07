; // vim: set ft=tf:

;;;;;;;;;;;;;;;;;;;;;;
;MAJOR USEFULL STUFFS;
;;;;;;;;;;;;;;;;;;;;;;
/def -p10 -mglob -F -t'* tells you \'corpse\'' acor = \
    /ecko Trying to LOOOOOOOTING...%;\
    cr%;

/def -mglob -t'*starts feebly trying to budge the huge mithril bar.' breakbar = \
    break bar

/def -mglob -t'*starts straining * muscles in an effort to push the boulder.' pushbould = \
    push boulder

;;;;;;;;;;;
;TARRASQUE;
;;;;;;;;;;;
/def -mregexp -t'tells the group, \'(REM|rem|Rem|REMOVE|Remove|remove|WEAR|wear|Wear) ([^ ]+)\'' tarra3 = \
    /if ({1}=~{tank}) \
        /if ({P2}=/'about' & abouteq!~'') \
            /if ({P1}=/'rem*' & (remabout=0)) \
                /ecko Removing About EQ (%{abouteq})%;\
                remove %{abouteq}%;\
                /set remabout=1%;\
            /elseif ({P1}=/'wear' & remabout=1) \
                /ecko Wearing About EQ again (%{abouteq})%;\
                wear %{abouteq}%;\
                /set remabout=0%;\
            /endif%;\
        /elseif ({P2}=/'boot*' & feeteq!~'') \
            /if ({P1}=/'rem*' & remfeet=0) \
                /ecko Removing your nice looking boots! (%{feeteq})%;\
                remove %{feeteq}%;\
                /set remfeet=1%;\
            /elseif ({P1}=/'wear' & remfeet=1) \
                /ecko Wearing Boots again (%{feeteq})%;\
                wear %{feeteq}%;\
                /set remfeet=0%;\
            /endif%;\
        /elseif ({P2}=/'shield' & shieldeq!~'') \
            /if ({P1}=/'rem*' & remshield=0) \
                /ecko Removing your heavy shield. (%{shieldeq}) %;\
                remove %{shieldeq}%;\
                /set remshield=1%;\
            /elseif ({P1}=/'wear' & remshield=1) \
                /ecko Wearing Shield again (%{shieldeq}) %;\
                wear %{shieldeq}%;\
                /set remshield=0%;\
            /endif%;\
        /elseif ({P2}=/'weapon' & weapon!~'') \
            /if ({P1}=/'rem*' & remweapon=0) \
                /ecko Removing your deadly weapon. (%{weapon}) %;\
                remove %{weapon}%;\
                /set remweapon=1%;\
            /elseif ({P1}=/'wear' & remweapon=1) \
                /ecko Wielding weapon again (%{weapon})%; \
                wield %{weapon}%;\
                /set remweapon=0%;\
            /endif%;\
        /endif%;\
    /endif

/def -mregexp -F -t'^The tarrasque|^Secret room' tarra = \
    /if (remabout=0) \
        /ecko Removing About body! (tarrasque can be around here)%;\
        remove %{aboutbody}%;\
        /set remabout=1%;\
    /endif

;;;;;;;;;;;;;;;;
;Auto well?
;;;;;;;;;;;;;;;;
/def -mglob -t'* climbs into The Well, looks around nervously, and slowly lowers' autowellscript = \
    /if ({1}=/{tank}) \
        enter well%;\
    /endif



;;;

/def -msimple -t'A haunting spirit roams the lands looking for reprisal. (invisible)' accused_spirit = \
    /ecko SPIRIT!!!%;\
    /beeper

/def -msimple -t'A strange man is here, grinning at you roguishly.' rover_spotted = \
    /ecko Riddling Rover!%;\
    /beeper

/def -msimple -t'A smelly old troll stands here upsetting the natural balance of the forest.' troll_spotted = \
    /ecko TROLL!!!

;;;

/def -msimple -F -t'Deep down in the ravine' drow_spec0 = \
    /set drow_spec=2

/def -msimple -Edrow_spec -t'Alas, your alignment forbids you to go that way...' drow_spec1 = \
    /if (magician>0 & ingroup=1 & tank!~char) \
        dd %{tank}%;\
    /endif


;; Summon teleported players
/def -mregexp -F -p1233 -t'^(.*) utters the words, \'(hzrzsafh|teleport)\'$' uzi_plus_teleported_player_1 = \
    /if (ismember({P1}, gplist)=0) \
        /set teleport_summon=1%;\
    /endif

/def -mregexp -Eteleport_summon -F -p1333 -t'([A-z]+) enters a magical portal, in the hope of finding another time and place.' uzi_plus_telepored_player_2 = \
    /if (priest>0 & ismember({P1}, gplist)>0) \
        summon 0.%{P1}%;\
    /endif%;\
    /set teleport_summon=0

;; We're in Underworld!
/def -msimple -F -t'He regains his composure and upon a mischievious grin you fall out of consciousness, and awaken on an eery path.' uzi_plus_underworld_0 = \
    /set in_underworld=1


;; Open gate in oblivion

/def -mregexp -F -t'^A tall Divine warrior is here, guarding the Gates of Oblivion*' uzi_plus_oblivion_0 = \
    /if (ingroup=1 & tank!~char & align=/'good') \
        follow self%;\
        say open%;\
        /def -msimple -Fp12223 -t'The Guardian of Oblivion opens the gates.' uzi_plus_oblivion_1 = \\
            south%%;\\
            /purge uzi_plus_oblivion_1%;\
            /def -mregexp -Fp12223 -t"^([A-z]+)'s group arrives" uzi_plus_oblivion_2 = \\
                follow %%{tank}%%;\\
                /purge uzi_plus_oblivion_2%;\
    /endif

/def -mregexp -F -t'^(A Pier|A landing-stage)$' uzi_boarding_helper_reset = \
    /set board_ship=0%;\
    /set at_harbor=0%;\
    /set ship_boarded=0

/def -msimple -Eat_harbor -F -t"You don't see anything like that to board." uzi_boarding_helper = \
    /set board_ship=1%;\
    /ecko Automatically boarding the ship when it arrives.

/def -msimple -F -t"You board The ship." uzi_boarding_boarded = \
    /if (board_ship=1 | ingroup=0 | tank=~char) \
        /set ship_boarded=1%;\
        /set board_ship=0%;\
        /set at_harbor=0%;\
    /endif

/def -Eboard_ship -F -mregexp -t'^The ship arrives from the (east|south).$' uzi_boarding_board_ship = \
    board ship%;\
    /set board_ship=0

/def -msimple -Eship_boarded -F -t'You disembark.' uzi_boarding_disembark = \
    /set ship_boarded=0

/def -mregexp -F -t'^(A Ferry Dock in Myrridon|The landing-stage of the inter-continental ferry)$' uzi_boarding_harbor = \
    /set at_harbor=1%;\
    /if (ship_boarded=1) \
        leave ship%;\
    /endif

/def -mglob -aBCred -F -t'* is blind.' foe_blinded

;; Report on someone arriving through a holy gate.
/def -mregexp -F -t'^([A-z]+) arrives through a red field of energy.' uzi_report_successful_gate = \
    /if ({P1}=~tank) \
        /set no_gate_report=1%;\
    /elseif (ingroup=1 & tank!~char & no_gate_report<1) \
        /set gate_report=%{gate_report} %{P1}%;\
    /endif

/def -msimple -F -t'You follow your master through a red field of energy.' uzi_dont_report_successful_gate = \
    /set no_gate_report=2

/def prompt_gate_report = \
    /let _count=$(/length gate_report)%;\
    /if (_count<5 & _count>0) \
        /mapcar /gate_report %{gate_report}%;\
    /endif%;\
    /set gate_report=

/def gate_report = \
    /if ({1}!~'') \
        gtf emote sees &+W%{1}&+g arriving through a &+rred&+g field of energy.%;\
    /endif

;/def .msimple -F -t'You enter a red field of energy.' uzi_dont_report_successful_gate2 = \
;    /set no_gate_report=2

/def -mregexp -F -aBCwhite -t'^You get (.*) from Corpse of (.*).' loot_hilite = \
    /if ({P2}!~char) \
        /if ({P1}=~'Soul Crystal') \
            drop crystal%;\
        /elseif ({P1}=~'a compass') \
            drop compass%;\
        /elseif ({P1}=~'a magical flask') \
            drop flask%;\
        /endif%;\
    /endif


/def -msimple -t'The Deep Blue' graven_vape_wimp = \
    /if (ingroup=1 & leading<1) \
        /tele%;\
        gtf emote skips out on these freaking vapers!%;\
    /endif

/def -msimple -t'Before The Deep Blue' graven_vape_warn = \
  /if (ingroup=1 & leading<1) \
    gtell Vapers south from here!%;\
  /endif

/def -mregexp -t'^A dangerous man is walking along with a limp here.' keyser_soze = \
	/beeper%;\
	/ecko KEYSER SOZE!


/def -mregexp -E(_group_walk_gag=1) -Fp2210011 -t'([A-z]+) the (Half-Elf|Orc|Troll|Human|Elf|Dwarf|Drow elf|K\'ta\'viir|Goblin|Half-Orc|Gnome|Hobbit).* (is here circling around in the air.|is here, fighting |is standing here.)' group_walk_gag = \
  /if (ismember({P1}, gplist)=1 & {P1}!~{tank}) \
    /substitute%;\
  /endif
  
/def -msimple -Fp1222 -t'Deep down in the ravine' move_group_drows = \
  /set guallidurth_move_group=2



/def -mregexp -F -p3132 -t'^You start to use (.*) as a shield.' wearing_shield =\
  /set remshield=0%;\
  /if (regmatch('^the Sphere of Defence$', %{P1})) \
    /set shieldeq=sphere%;\
  /elseif (regmatch('^the defiled body of a paladin$', %{P1})) \
    /set shieldeq=defiled%;\
  /else \
    /set shieldeq=shield%;\
  /endif

;; Update on tell!
/def -mregexp -F -p1332329 -t'^([A-z]+) (tells you|gossips\,) \':upgrade\'$' uzi_plus_upgrade_tell = \
    /if (ismember({P1}, userlist)) \
        /quote -S /let gitresponse=!cd %{uzidirectory}&&git pull%;\
        /if (gitresponse!~'Already up-to-date.') \
            /purge *%;\
            /load %{uzidirectory}/uzi%;\
            /repeat -1 1 save%;\
        /endif%;\
    /endif


/def -mregexp -F -t'^(Scorched crater)$' uzi_plus_wildmagrooms = \
    /set wildmagic=2

;; Superwhitelist
/set super_whitelist= Tiberius Brutus Charlemagne Baracus Magamedov Crixus Danimal Dreadlock Maul Zelm Naega Miriam
/set whitelist= Tiberius Brutus Charlemagne Baracus Magamedov Crixus Pathos Magnum Tesla Laorth Beaumanoir Cincinnatus Caffeine Worthless Sriracha
/set userlist= Tiberius Brutus Charlemagne Baracus Magamedov Crixus Pathos Magnum Tesla Laorth Beaumanoir Cincinnatus Caffeine Worthless Sriracha
