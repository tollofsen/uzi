; // vim: set ft=tf:

;;;;;;;;;;;;;;;;;;;;;;
;MAJOR USEFULL STUFFS;
;;;;;;;;;;;;;;;;;;;;;;
/def -p10 -mglob -F -t'* tells you \'corpse\'' acor = \
    /ecko Trying to LOOOOOOOTING...%;\
    cr%;

/def -mglob -t'*starts feebly trying to budge the huge mithral bar.' breakbar = \
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
        /elseif ({P2}=/'weapon' & weaponeq!~'') \
            /if ({P1}=/'rem*' & remweapon=0) \
                /ecko Removing your deadly weapon. (%{weapon}) %;\
                remove %{weapon}%;\
                /set remweapon=1%;\
            /elseif ({P1}=/'wear' & remweapon=1) \
                /ecko Wielding weapon again (%{weapon})%; \
                wield %{weapon}%;\
                /set remweawpon=0%;\
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


;;;

/def -msimple -F -t'Deep down in the ravine' drow_spec0 = \
    /set drow_spec=2

/def -msimple -Edrow_spec -t'Alas, your alignment forbids you to go that way...' drow_spec1 = \
    /if (magician>0 & ingroup=1 & tank!~char) \
        dd %{tank}%;\
    /endif


;; Summon teleported players
/def -mregexp -F -p1233 -t'(.*) utters the words, \'hzrzsafh\'' uzi_plus_teleported_player_1 = \
    /ecko %{P1}%;\
    /if (ismember({P1}, gplist)=0) \
        /set teleport_summon=1%;\
    /endif

/def -mregexp -F -p1333 -t'([A-z]+) enters a magical portal, in the hope of finding another time and place.' uzi_plus_telepored_player_2 = \
    /if (priest>0 & ismember({P1}, gplist)>0) \
        summon 0.%{P1}%;\
    /endif%;\
    /set teleport_summon=0

;; Superwhitelist
/set super_whitelist= Tiberius Brutus Charlemagne Baracus Magamedov Crixus
/set whitelist= Tiberius Brutus Charlemagne Baracus Magamedov Crixus
/set userlist= Tiberius Brutus Charlemagne Baracus Magamedov Crixus
