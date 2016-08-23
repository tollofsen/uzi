; // vim: set ft=tf:
;;;;;;;Autochange script.

/if ({cweap}=~'') /set cweap=1%;/endif
/if ({pweap}=~'') /set pweap=1%;/endif

/def w = \
    /let _w_input=$[replace('slay ', 'slay', {*})]%;\
    /d %*%;\
    /weapon %_w_input

/def tdam = \
    /if ({1}=~'horgar') \
        gt use &+Rfire%;\
        gt &+Rhorgar%;\
    /elseif ({*}=~'') \
        gtell use &+Rnormal%;\
    /else \
        gtell use &+R%{*}%;\
    /endif%;\
    /w %{*}

/alias tdam /tdam %{*}

/def -mregexp -p9999 -F -t'([A-z]+) tells the group, \'(H|h)(ORGAR|orgar)\'' cweaphorgar = \
    /if ({horgarslay} !~ '') \
        /weapon horgar%;\
    /else \
        /weapon fire%;\
    /endif%;\
    /d fire

/def -mregexp -p9999 -F -t'^You tell the group, \'(H|h)(ORGAR|orgar)\'' cweaphorgar2 = \
    /if ({horgarslay} !~ '') \
        /weapon horgar%;\
    /else \
        /weapon fire%;\
    /endif%;\
    /d fire


/def -mregexp -p9999 -F -t'([A-z]+) tells the group, \'(USE|use) ([A-Za-z/\ ]*)\'' leadercweap = \
    /if ({P1}=/{tank}) \
        /let _newdam=$[replace('/',' ', {P3})]%;\
        /let _newdam=$[replace('or',' ', {_newdam})]%;\
        /let _newdam=$[replace('slay ','slay', {_newdam})]%;\
        /let _newdam=$[replace('  ',' ', {_newdam})]%;\
        /let _newdam=$[replace('  ',' ', {_newdam})]%;\
        /if (_newdam =/ 'iron') \
            /d %_newdam%;\
            /weapon %_newdam%;\
        /elseif (_newdam =/ 'unlife') \
            /d %_newdam dark slaymagical%;\
            /weapon unlife dark slaymagical%;\
        /elseif (_newdam =/ 'pure') \
            /d %_newdam light%;\
            /weapon %_newdam light slaydemon%;\
        /else \
            /d %_newdam%;\
            /weapon %_newdam%;\
        /endif%;\
    /endif

;/def -mregexp -p9999 -F -t'([A-z]+) tells the group, \':dam ([A-Za-z/\ ]*)\'' leadercweapbps = \
;    /if ({P1}=/{tank}) \
;        /let _newdam=$[replace('/',' ', {P2})]%;\
;        /let _newdam=$[replace('or',' ', {_newdam})]%;\
;        /let _newdam=$[replace('slay ','slay', {_newdam})]%;\
;        /let _newdam=$[replace('  ',' ', {_newdam})]%;\
;        /let _newdam=$[replace('  ',' ', {_newdam})]%;\
;        /if (_newdam =/ 'iron') \
;            /d %_newdam%;\
;            /weapon %_newdam%;\
;        /elseif (_newdam =/ 'unlife') \
;            /d %_newdam dark magical%;\
;            /weapon unlife dark magical%;\
;        /elseif (_newdam =/ 'pure*') \
;            /d %_newdam light%;\
;            /weapon %_newdam light slaydemon%;\
;        /else \
;            /d %_newdam%;\
;            /weapon %_newdam%;\
;        /endif%;\
;    /endif


;;;;;;;;;;;;;;;;;;
;PathWeaver
;;;;;;;;;;;;;;;;;;
/def weaver = \
    /if ({1}=/'fire'|{1}=/'slayorc'|{1}=/'slaygoblin'|{1}=/'slaytroll'|{1}=/'slaylugroki') \
        /if ({pweavertype}!/'death') \
            /ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2\Pathweaver%htxt)%;\
            say baru goth deathflame%;wield pathweaver%;/set pweavertype=death%;\
        /elseif (weapon!/'pathweaver') \
            /ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2\Pathweaver%htxt)%;\
        /endif%;\
    /elseif ({1}=/'ice'|{1}=/'slayde'|{1}=/'slaydrow'|{1}=/'slaydrow-elf'|{1}=/'slaydrowelf') \
        /if ({pweavertype}!/'hail') \
            /ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2\Pathweaver%htxt)%;\
            say bwaihna cur hailstrike%;wield pathweaver%;/set pweavertype=hail%;\
        /elseif (weapon!/'pathweaver') \
            /ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2\Pathweaver%htxt)%;\
        /endif%;\
    /else \
        /if ({pweavertype}!/'normal') \
            /ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2\Pathweaver%htxt)%;\
            say cuntoh magu%;wield pathweaver%;/set pweavertype=normal%;\
        /elseif (weapon!/'pathweaver') \
            /ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2\Pathweaver%htxt)%;\
        /endif%;\
    /endif




;;;;;;;;;;;;;;;;;
;WEAPON SWITCHER;
;;;;;;;;;;;;;;;;;
/def cweap = \
    /if ({1} =/ 'on') \
        /set cweap=1%;\
        /ecko Will now autochange Weapon.%;\
    /elseif ({1} =/ 'off') \
        /set cweap=0%;\
        /ecko Won't autochange Weapon.%;\
    /else \
        /if (rogue>0 & quickdraw=1 & fighting=1) \
            /let _wieldcmd=quickdraw%;\
        /else \
            /let _wieldcmd=wield%;\
        /endif%;\
        /if ({2}!~('')|(' ')|('0')) \
            /if (({2}!/weapon)|({2}=/'pathweaver')) \
                /if ({2}=/'mord*') \
                    mord%;\
                /elseif ({2}=/'pathweaver') \
                    /if ({weapon}!/'pathweaver') \
                        /if (pweap=1) \
                            gc %{2} weapon!%;\
                            /if (quickdraw=1 & fighting=1) \
                                quickdraw %2%;\
                            /else \
                                remove %weapon%;\
                            /endif%;\
                            wield %2%;\
                            /repeat -0:00:01 1 pc %{weapon} weapon!%;\
                        /else \
                            /if (quickdraw=1 & fighting=1) \
                                quickdraw %2%;\
                            /else \
                                remove %weapon%;\
                            /endif%;\
                            wield %2%;\
                        /endif%;\
                    /endif%;\
                    /weaver %1%;\
                /else \
                    /if (pweap=1) \
                        gc %{2} weapon!%;\
                        /if (quickdraw=1 & fighting=1) \
                            quickdraw %2%;\
                        /else \
                            remove %weapon%;\
                        /endif%;\
                        wield %2%;\
                        /repeat -0:00:01 1 pc %{weapon} weapon!%;\
                    /else \
                        /if (quickdraw=1 & fighting=1) \
                            quickdraw %2%;\
                        /else \
                            remove %weapon%;\
                        /endif%;\
                        wield %2%;\
                    /endif%;\
                    /ecko %htxt(%htxt2\CWEAP%htxt) %ntxt\Weapon Slay%ntxt2: %htxt%1 %htxt(%htxt2%2%htxt)%;\
                /endif%;\
                /set weapon=%{2}%;\
            /endif%;\
        /else \
            /if (slayalt1!~''|slayalt1!~' '|slayalt1!~'0') \
                /weapon %slayalt1 %slayalt2%;\
            /elseif (normslay!~('')|(' ')|('0')) \
                /weapon%;\
            /endif%;\
        /endif%;\
    /endif

/def weapon = \
    /if (cweap=1) \
        /set slayalt1=0%;/set slayalt2=0%;\
        /set slayalt1=%{2}%;\
        /set slayalt2=%{3}%;\
        /if ({1} =/ 'acid') \
            /cweap Acid %acidslay%;\
        /elseif ({1} =/ 'air') \
            /cweap Air %airslay%;\
        /elseif ({1} =/ 'bleed') \
            /cweap Bleed %bleedslay%;\
        /elseif ({1} =/ 'dark') \
            /cweap Dark %darkslay%;\
        /elseif ({1} =/ 'earth') \
            /cweap Earth %earthslay%;\
        /elseif ({1} =/ 'electricity') \
            /cweap Electricity %electricityslay%;\
        /elseif ({1} =/ 'energy') \
            /cweap Energy %energyslay%;\
        /elseif ({1} =/ 'fire') \
            /cweap Fire %fireslay%;\
        /elseif ({1} =/ 'horgar') \
            /cweap HorgarWeapon %horgarslay%;\
        /elseif ({1} =/ 'gas') \
            /cweap Gas %gasslay%;\
        /elseif ({1} =/ 'ice') \
            /cweap Ice %iceslay%;\
        /elseif ({1} =/ 'iron') \
            /cweap Iron %ironslay%;\
        /elseif ({1} =/ 'light') \
            /cweap Light %lightslay%;\
        /elseif ({1} =/ 'normal') \
            /cweap Normal %normalslay%;\
        /elseif ({1} =/ 'magic') \
            /cweap Magic %magicslay%;\
        /elseif ({1} =/ 'mental') \
            /cweap Mental %mentalslay%;\
        /elseif ({1} =/ 'poison') \
            /cweap Poison %poisonslay%;\
        /elseif ({1} =/ 'pure') \
            /cweap Pure %pureslay%;\
        /elseif ({1} =/ 'silver') \
            /cweap Silver %silverslay%;\
        /elseif ({1} =/ 'stun') \
            /cweap Stun %stunslay%;\
        /elseif ({1} =/ 'superlarge') \
            /cweap Superlarge %superlargeslay%;\
        /elseif ({1} =/ 'unlife') \
            /cweap Unlife %unlifeslay%;\
        /elseif ({1} =/ 'water') \
            /cweap Water %waterslay%;\
        /elseif ({1} =/ 'wood') \
            /cweap Wood %woodslay%;\
        /elseif ({1} =/ 'slayanimal') \
            /cweap SlayANIMAL %animalslay%;\
        /elseif ({1} =/ 'slaybotanic') \
            /cweap SlayBOTANIC %botanicslay%;\
        /elseif ({1} =/ 'slaydemon') \
            /cweap SlayDEMON %demonslay%;\
        /elseif ({1} =/ 'slaydinosaur') \
            /cweap SlayDINOSAUR %dinosaurslay%;\
        /elseif ({1} =/ 'slaydragon') \
            /cweap SlayDRAGON %dragonslay%;\
        /elseif ({1} =/ 'slayde' | {1} =/ 'slaydrowelf' | {1} =/ 'slaydrow-elf' | {1} =/ 'slaydrow') \
            /cweap SlayDROW-ELF %drowelfslay%;\
        /elseif ({1} =/ 'slaydwarf') \
            /cweap SlayDWARF %dwarfslay%;\
        /elseif ({1} =/ 'slayelemental') \
            /cweap SlayELEMENTAL %elementalslay%;\
        /elseif ({1} =/ 'slayelf') \
            /cweap SlayELF %elfslay%;\
        /elseif ({1}=/ 'slayfairie'| {1} =/ 'slayfairy') \
            /Cweap SlayFAIRIE %fairieslay%;\
        /elseif ({1} =/ 'slaygiant') \
            /cweap SlayGIANT %giantslay%;\
        /elseif ({1} =/ 'slaygnome') \
            /cweap SlayGNOME %gnomeslay%;\
        /elseif ({1} =/ 'slaygoblin') \
            /cweap SlayGOBLIN %goblinslay%;\
        /elseif ({1} =/ 'slayhe' | {1} =/ 'slayhalfelf') \
            /cweap SlayHALF-ELF %halfelfslay%;\
        /elseif ({1} =/ 'slayho' | {1} =/ 'slayhalforc') \
            /cweap SlayHALF-ORC %halforcslay%;\
        /elseif ({1} =/ 'slayhobbit') \
            /cweap SlayHOBBIT %hobbitslay%;\
        /elseif ({1} =/ 'slayhuman') \
            /cweap SlayHUMAN %humanslay%;\
        /elseif ({1} =/ 'slayinsect') \
            /cweap SlayINSECT %insectslay%;\
        /elseif ({1} =/ 'slayinsubstantial') \
            /cweap SlayINSUBSTANTIAL %insubstantialslay%;\
        /elseif ({1} =/ 'slaylugroki') \
            /cweap SlayLUGROKI %lugrokislay%;\
        /elseif ({1} =/ 'slaymythical') \
            /cweap SlayMYTHICAL %mythicalslay%;\
        /elseif ({1} =/ 'slaymagical') \
            /cweap SlayMAGICAL %magicalslay%;\
        /elseif ({1} =/ 'slayorc') \
            /cweap SlayORC %orcslay%;\
        /elseif ({1} =/ 'slayrodent') \
            /cweap SlayRODENT %rodentslay%;\
        /elseif ({1} =/ 'slaysnake') \
            /cweap SlaySNAKE %snakeslay%;\
        /elseif ({1} =/ 'slaytroll') \
            /cweap SlayTROLL %trollslay%;\
        /elseif ({1} =/ 'slayundead') \
            /cweap SlayUNDEAD %undeadslay%;\
        /elseif ({1} =/ 'slayvampire') \
            /cweap SlayVAMPIRE %vampireslay%;\
        /elseif ({1} =/ 'fireslash') \
            /cweap Fireslash %fireslash%;\
        /else \
            /eval /set _tmpweap=%%{%{1}slay}%;\
            /if (_tmpweap !~ '') \
                /cweap $[toupper({1})] %_tmpweap%;\
            /elseif (slayalt1 !~ '') \
                /weapon %slayalt1 %slayalt2%;\
            /else \
                /if (weapon!~normslay) \
                    /cweap Normal %normslay%;\
                /endif%;\
            /endif%;\
        /endif%;\
    /endif

/def addweapon = \
    /if ({1} !~ '' & {2} !~ '') \
        /let _newdamtype=$[tolower({1})]%;\
        /eval /set %{_newdamtype}slay=%{2}%;\
        /ecko Added:%htxt2 %_newdamtype%ntxt To use it type%htxt2 /w %_newdamtype%;\
    /else \
        /uecko Usage: /addweapon <type> <weapon-name>%;\
    /endif

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;Mob/Room name triggs;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Gorm
/def -mglob -F -t'A gorm {mage|priestess|warrior}*' cweap1 = \
    /weapon acid poison fire%;\
    /d fire light poison

/def -msimple -F -t'A huge, ancient tree towers above you.' cweap2 = \
    /weapon slaybotanic acid%;\
    /d slaybotanic normal

; The soulstealers laboratory
/def -F -mregexp -t'^A soulcrusher lurks in the shadows here.$|^The soulcrusher glances at you with fear.$|^A blurred figure stands here.$|^Entrance to the SoulCrusher\'s Laboratory$' cweap3 = \
    /weapon slaydemon pure iron light%;\
    /d slaydemon light pure

/def -F -mregexp -t'^A great soulcrusher stands here.$|^A Long Hallway in the Twisted Laboratory$' cweap4 = \
    /weapon slaydemon pure iron light%;\
    /d slaydemon light pure

; Dungeons of Ceanyth
/def -F -mregexp -t'^Entrance to the Dark Dungeons$\
|^A worn out guard stands watch here.$\
|^A prisoner looks angrily around him.$\
|^An orc merchant is standing here.$\
|^A young prisoner looks wearily at you.$\
|^A skinny man hides in the shadows.$' cweap5 = \
    /weapon beast fire pure light%;\
    /d beast pure light fire

; Dragonspyre
/def -F -mregexp -t'^Walking through DragonSpyre|The star spawn|The deep one|The hunting horror' cweap6 = \
    /weapon normal%;\
    /d normal

; Obelisk
/def -F -mglob -t'*rubs the*' cweap7 = \
    /weapon normal%;\
    /d normal

; Antiriad
/def -mregexp -F -t'^Entrance to the City of Antiriad$|^Outside Ye Olde Shoppe$' cweap8 = \
    /weapon slaylugroki%;\
    /d slaylugroki fire pure light

; Antiriad - Poltergeist
/def -msimple -F -t'The abandoned shop' cweap9 = \
    /weapon energy%;\
    /d energy

; Upper Argo (black and white trolls)
/def -msimple -F -t'Mt. Ulmo Pass' cweap10 = \
    /weapon slaytroll fire acid mental%;\
    /d slaytroll fire light pure

; Dragons graveyard
/def -msimple -F -t"The dragons' graveyard" cweap11 = \
    /weapon slaydragon%;\
    /d slaydragon

; The Citadel
/def -msimple -F -t'The Gatehouse of the Citadel' cweap12 =\
    /weapon slayelf unlife dark iron%;\
    /d slayelf unlife dark

; Kaltor
/def -msimple -F -t'Entrance to the Ruins of Kaltor' cweap13 = \
    /weapon slaymagical unlife%;\
    /d slaymagical unlife

; Earthsea
/def -msimple -F -t'The Entrance To EarthSea' cweap15 = \
    /weapon slaymagical unlife%;\
    /d slaymagical unlife

; Inglestone
/def -msimple -F -t'The entrance to the great Dwarven kingdom, Inglestone' cweap16 =\
    /weapon slaydwarf magic superlarge water%;\
    /d slaydwarf magic water

; Alterac - Entrance
/def -msimple -F -t'The Gatekeeper of the stronghold stands here proudly' cweap17 = \
    /weapon slayhuman%;\
    /d slayhuman normal

; Drow City/Shadowdwell
/def -msimple -F -t'Outside the City Gates' cweap18 = \
    /weapon slaydrowelf pure light ice%;\
    /d slaydrowelf pure light ice

; Kaltor - Skeletons (does anyone kill these nowadays?)
/def -mglob -t'You {*} The Skeleton with your *' cweap19 = \
    /weapon slayundead pure light silver%;\
    /d slayundead heal

; The desolate plains
/def -msimple -p2 -F -t'The slope down.' cweap20 = \
    /weapon slaymagical unlife%;\
    /d slaymagical unlife

; The amphitheatre
/def -msimple -F -t'The upper seatings' cweap21 =\
    /weapon slayhuman iron light%;\
    /d light

; Great red wyrm
/def -msimple -F -t'A huge red dragon lies on a huge hoard of treasures, sleeping. (hidden)' cweap22 = \
    /weapon slaydragon%;\
    /d slaydragon normal

; Olympus
/def -msimple -F -t'The Temple of Olympus' cweap23 = \
    /weapon slaymythical%;\
    /d slaymythical normal

; FS
;/def -msimple -F -t'The Fountain Square of Karandras' cweap24 =\
;    /weapon slayhuman%;\
;    /d normal

; Leviathan, entrance to ice wall
/def -msimple -F -t'Leviathan is here, looking at you with a quizzical expresion.' cweap25 = \
    /weapon slaymagical unlife%;\
    /d slaymagical unlife

/def -msimple -t'Western Manyfolk' cweap26 = \
    /weapon slaydemon pure light iron%;\
    /d slaydemon pure light

/def -mglob -t'An ugly orc stands here.' cweap27 =\
    /weapon slayorc fire pure light%;\
    /d slayorc fire light

; Sarakesh
/def -msimple -F -t'The temple of Sarakesh' cweap28 =\
    /weapon sarakesh slayundead silver mental light%;\
    /d sarakesh slayundead light

; Myrridon
;/def -msimple -F -t'Temple square of Myrridon' cweap29 =\
;    /weapon slayhuman%;\
;    /d normal

; Khronatio
/def -msimple -F -t'Inside a ruined Gatehouse' cweap30 = \
    /weapon decap water%;\
    /d decap water

/def -msimple -F -t'The den of the Black Dragon' cweap32 = \
    /weapon slaydragon%;\
    /d slaydragon normal

/def -msimple -F -t'A dark cell' cweap33 = \
    /weapon bodak silver slash%;\
    /d bodak

/def -mregexp -F -p1000 -t'^Deep down in the ravine$|^A drow is here, guarding the hallways.$|^A drow guard is here, playing cards.$|^A drow warrior is here, training.$|^A huge drow is here, clad in the finest azur and silver armor$' cweap41 = \
 /weapon slaydrowelf ice pure light%;\
 /d slaydrowelf ice pure light

/def -mregexp -t'Korr, the Overlord of Chaos stands here grinning wickedly.\
    |A Chaos Knight Sergeant stands here pondering the boulders situation' cweap42 = \
    /weapon slayhuman%;\
    /d normal

/def -F -msimple -t'The Grand Hallway.' cweap50 =\
    /weapon slayelf unlife dark iron%;\
    /d slayelf unlife

/def -F -msimple -t'Entrance to the King\'s Castle' cweap52 =\
    /weapon slayhuman%;\
    /d slayhuman normal

/def -F -msimple -t'You feel a sensation as you travel through the essence flows.' cweap53 = \
    /weapon normal%;\
    /d normal

; Cohn Shar
/def -F -mregexp -t'A warrior stands here overseeing the protection of Egypt.\
    |A warrior stands here protecting the gates of the palace.\
    |A warrior stands here protecting the palace.\
    |A warrior stands here looking at antiquity.\
    |A warrior lies here resting.' cweap54 = \
    /weapon medjai slayhuman iron light%;\
    /d medjai light

; Snake Lair
/def -F -msimple -t'A Path In The Mountains' cweap55 = \
    /weapon slaysnake%;\
    /d slaysnake normal

; Oblivion
/def -msimple -F -t'A frozen tundra' cweap56 = \
    /weapon fire slaydemon pure light%;\
    /d fire slaydemon pure light

/def -msimple -F -t'A burning inferno' cweap58 = \
    /weapon ice slaydemon pure light%;\
    /d ice slaydemon pure light

/def -msimple -F -t'Floating in the void' cweap57 = \
    /weapon slaymagical unlife%;\
    /d slaymagical unlife

;; Hit cweaps
/def -mglob -F -p10000 -t'You {*} A ghost of a decapitated woman with your *' hit_cweap0 = \
    /if (quickdraw) \
        /weapon decap water%;\
    /endif%;\
    /d decap water

/def -mglob -F -p10000 -t'You {*} A Guard of Khron with your *' hit_cweap1 = \
    /if (quickdraw) \
        /weapon khron slayhuman water%;\
    /endif%;\
    /d khron water

; Alterac - waywatchers
/def -mglob -F -t'You * An Elven waywatcher with *' hit_cweap2= \
    /if (quickdraw) \
        /weapon slayelf unlife dark iron%;\
    /endif%;\
    /d slayelf unlife dark

; Alterac - human mobs
/def -mregexp -F -t'^You ([a-z]+) (A Brettonian man-at-arms|An Ofcol mercenary|A Brettonian Guard|A lieutenant of the Brettonian High Command|A captain of the Brettonian High Command) with your ([^ ]*).' hit_cweap3=\
    /if (quickdraw) \
        /weapon slayhuman%;\
    /endif%;\
    /d slayhuman normal


