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

/def -mregexp -t'^The tarrasque|^Secret room' tarra = \
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

/def -mglob -F -t'A tall Divine warrior is here, guarding the Gates of Oblivion*' uzi_plus_oblivion_0 = \
    /if (ingroup=1 & tank!~char & (align=~'Good' | align=~'good')) \
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

;; Update on tell!
/def -mregexp -F -p1332329 -t'^([A-z]+) (tells you|gossips\,) \':upgrade\'$' uzi_plus_upgrade_tell = \
    /if (ismember({P1}, userlist)) \
        /quote -S /let gitresponse=!git %{uzidirectory}&&git pull%;\
        /if (gitresponse!~'Already up-to-date.') \
            /purge *%;\
            /load %{uzidirectory}/uzi%;\
            /repeat -1 1 save%;\
        /endif%;\
    /endif

;; Superwhitelist
/set super_whitelist= Tiberius Brutus Charlemagne Baracus Magamedov Crixus Danimal Dreadlock Maul Zelm Naega Miriam
/set whitelist= Tiberius Brutus Charlemagne Baracus Magamedov Crixus Pathos Magnum Tesla Laorth Beaumanoir
/set userlist= Tiberius Brutus Charlemagne Baracus Magamedov Crixus Pathos Magnum Tesla Laorth Beaumanoir
