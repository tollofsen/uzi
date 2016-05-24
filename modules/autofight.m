;// vim: set ft=tf:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;===================================
;   Autofight
;===================================

/if (fighter>0) \
    /def ber = \
        /if (autoberserk=0) \
            /set autoberserk=1%%;\
            /ecko Berserk ON (You will try until you succeed)%%;\
        /elseif ((autoberserk) & (!berserktryonce)) \
            /set berserktryonce=1%%;\
            /ecko Berserk ON (You will only try once)%%;\
        /else \
            /set autoberserk=0%%;\
            /set berserktryonce=0%%;\
            /ecko Berserk OFF%%;\
        /endif%;\
    /endif

/if (fighter>1) \
    /def dd = \
        /if (autodeathdance=0) \
            /set autodeathdance=1%%;\
            /ecko Deathdance ON%%;\
        /else \
            /set autodeathdance=0%%;\
            /ecko Deathdance OFF%%;\
        /endif%;\
    /endif

/def dodamage = \
    /if (autofight=1 & promptdamage=1) \
        /debug %Y DODAMAGE %damage attackspell=%attackspell fighting=%fighting promptdamage=%promptdamage%;\
        /if (fighter > 0) \
            /if (autodeathdance=1 & deathdance=0) \
                deathdance%;\
            /else \
                /if (autoberserk=1 & berserk=0) \
                    berserk%;\
                    /if (berserktryonce=1) \
                        /set berserk 1%;\
                    /endif%;\
                /else \
                    %damage%;\
                /endif%;\
            /endif%;\
        /elseif (magician > 0) \
            /debug [vampmist] mag>0%;\
            /if ($[(%{currenthp}*100)/%{maxhp}] < %{mistthres}) \
                /ecko HP less than mistthres (%{mistthres}), getting some back%;\
                cast 'vampiric mist'%;\
            /else \
                %damage%;\
            /endif%;\
        /elseif ((rogue|nightblade)&(!cantstab)) \
            /if (rogue) \
                backstab%;\
            /else \
                murder%;\
            /endif%;\
        /else \
            %damage%;\
        /endif%;\
        /set cantstab=0%;\
        /set promptdamage=0%;\
        /if (autodamlog=1) \
            /send damlog show%;\
        /endif%;\
    /endif

/def promptdamage = \
    /if (onpromptassist !~ '') \
        /assist %onpromptassist%;\
    /endif%;\
    /if (joinfight=1) \
        /adr%;\
        /dodamage%;\
    /endif%;\
    /set joinfight=0%;\
    /set promptdamage=1

/def repeatdamage = \
    /if (fighting=1) \
        /if (areaspells=1) \
            /if (aggmob=1) \
                /if (firstarea !~ 1) \
                    /ecko First do areaspell.%;\
                    /set firstarea=1%;\
                /else \
                    /ecko Now, turn areas off for this kill?%;\
                    /set areafight=0%;\
                /endif%;\
            /elseif (aggmob < 1) \
                /ecko No aggs. No areas?%;\
                /set areafight=0%;\
            /else \
                /ecko %aggmob Aggmobs, areas!%;\
                /set areafight=1%;\
                /set firstarea=0%;\
            /endif%;\
        /endif%;\
        /dodamage%;\
    /endif%;\
    /set tickison=0

/def joindamage = \
;  /debug %M JOIN DAMAGE attackspell=%attackspell autofight=%autofight dodamage=%dodamage fighting=%fighting joinfight=%joinfight%;\
/if (fighting=0) \
    /set endoffight=0%;\
    /set joinfight=1%;\
    /set fighting=1%;\
    /set position=stand%;\
    /set groupass=0%;\
    /set onrpomptassist=%;\
    /if (areaspells=1) \
        /set areafight=1%;\
    /endif%;\
    /if (dopromptdamage!=1) \
        /promptdamage%;\
    /endif%;\
/endif

/def resetdamage = \
    /debug %E RESET%;\
    /set groupass=1%;\
    /set tickison=0%;\
    /set fighting=0%;\
    /set berserk=0%;\
    /set deathdance=0%;\
    /set endoffight=1%;\
    /if (assist=0) \
        /set groupass=1%;\
    /endif

/def startarea = \
    /set sentassist=0%;\
    /set aggmob=0%;\
    /set didarea=1%;\
    /repeatdamage

/def repeatarea = \
    /set sentassist=1%;\
    /if (areaspells=1) \
        /set aggmob=$[aggmob + 1]%;\
    /endif%;\
    /repeatdamage

;;; patterns

/def -E%autofight -aBCred -t'Kinda hard right now*' dam_on_switch = \
    /if (nightblade = 0) \
        /repeat -0:00:01 1 /repeatdamage%;\
    /else \
        cast 'ATTACK'%;\
    /endif

/def -E%autofight -aBCred -mglob -t'You can\'t seem to sneak around the back of your target!' dam_on_switch2 = \
    /debug @{B}Retrying damage..%;\
    /set cantstab=1%;\
    /repeatdamage
;    /if (nightblade = 0) \
;        /repeat -0:00:01 1 /repeatdamage%;\
;    /else \
;        cast 'ATTACK'%;\
;    /endif

/def -mregexp -t'^(You join the fight|You rush to attack)' startfight = \
    /set onpromptassist=%;\
    /set sentassist=0%;\
    /joindamage

/def -mglob -t'No way! You are fighting for your life!' startfight4 = \
    /if (fighting=0 & areaspells=0) \
        /joindamage%;\
    /endif

/def -mglob -t'* shrugs off your pathetic magic.' mobshrug = \
    /repeatdamage

/def -mglob -p1 -F -aBCred -t'You retreat from the melee with *' mobretreat = \
    /set fighting=0%;/repeat -0:00:10 1 /resetdamage

/def -aBCred -mglob -t'Flames lick *\'s body, scorching *! BBQ, get the ketchup!' startfight2 = \
    /set immo=1%;/joindamage

/def -aBCcyan -mglob -t'Ah, * doesn\'t seem to like the cold very much...' startfight3 = \
    /set immo=2%;/joindamage

/def -aBCred -mglob -p999 -t'*you nearly cut you*' repeatdam01 = \
    /set successtab=0%;\
    /set deathstab=0%;\
    /repeatstab%;\
    /repeatdamage


/def -aBCgreen -mglob -p999 -t'*makes a strange sound as you place*' repeatdam02 = \
    /set successtab=1%;\
    /set deathstab=0%;\
    /repeatstab%;\
    /repeatdamage


/def -aBCgreen -mglob -p999 -t'*makes a strange sound but is suddenly very silent*' repeatdam03 = \
    /set successtab=0%;\
    /set deathstab=1%;\
    /repeatstab%;\
    /repeatdamage

/def repeatstab = \
    /if (countback=1) \
        /if ({successtab}=1) \
            /set backstabs=$[{backstabs}+1]%;\
            /if (ashowdl=1) \
                daml show%;/set lastbs=$[%{stabdam}-%{tempback}]%;\
                /if ((tlastbs!/'0')&(tlastbs!/'echo')&(lastbs!/'0')) \
                    %{tlastbs} &+cBackstabbed for &+R%{lastbs}&+c damage.%;\
                /elseif ((tlastbs=/'echo')&(lastbs!/'0')) \
                    /ecko One stab: %{lastbs}%;\
                /endif%;\
            /endif%;\
        /elseif (successtab=0 & deathstab=1) \
            /set deadlystabs=$[%deadlystabs+1]%;\
            /if (ashowdl=1) \
                damlog show%;\
                %{tlastbs} &+cBackstabbed for &+R%{lastbs}&+c damage.%;\
            /elseif ((tlastbs=/'echo')&(lastbs!/'0')) \
                /ecko One stab: %{lastbs}%;\
            /endif%;\
        /else \
            /set missedbs=$[{missedbs}+1]%;\
        /endif%;\
    /endif%;\
;  /if ((autofight=1)&(%{damage}=/ 'mix')) \
;    cast 'nether bolt'%;\
;  /elseif ((autofight=1)&(deathstab=0)) \
;    %{damage}%;\
;  /endif%;\
/set groupass=0


;;;;;;;;;;;;;;;;;;;;;;;
;;Immunity/Restistant;;
;;;;;;;;;;;;;;;;;;;;;;;

/def -msimple -t'You need more target practice!' ice_immune = \
    /if ((autofight=1)&({damage}=/'ib')) \
        /d fire%;\
    /endif%;\
    /repeatdamage

/def -mregexp -t'ducks your bolt effectively.' fire_immune = \
    /if ((autofight=1)&({damage}=/'fb')) \
        /d normal%;\
    /endif%;\
    /repeatdamage

/def -mglob -t'As I told ya, nothing can\'t do anything...' netherb_immune = \
    /if ((autofight=1)&({damage}=/'nb')) \
        /d fire ice normal%;\
    /endif%;\
    /repeatdamage

;;;;;;;;;;;;;;;;
;;Damage stuff;;
;;;;;;;;;;;;;;;;
/def resdam = \
    /set attackspell=0

; Adrenal focus
; -------------

/def foc = \
    /if (nightblade > 0) \
        /if (autofocus=0) \
            /set autofocus=1%;\
            /uecko Focus I: Casting focus when you are not fighting.%;\
        /elseif (autofocus=1) \
            /set autofocus=2%;\
            /uecko Focus II: Casting focus only in fights.%;\
        /elseif (autofocus=2) \
            /set autofocus=3%;\
            /uecko Focus III: Always cast focus.%;\
        /else \
            /set autofocus=0%;\
            /uecko Focus 0: Never cast Adrenal Focus!%;\
        /endif%;\
        /if (focusmana1 < 2) \
            /uecko %htxt2 Use /setfocus to set mana.%;\
        /endif%;\
    /else \
        /uecko This only works if you are Nightblade.%;\
    /endif

/def setfocus = \
    /if ({1} !~ '' & {2} !~ '') \
        /set focusmana1=%1%;\
        /set focusmana2=%2%;\
        /ecko Upper Mana: %1 Lower Mana: %2%;\
    /else \
        /ecko Usage: /setfocus <uppermana> <lowermana>%;\
    /endif


/def adr = \
    /if (didfoc = 0 & nightblade > 0) \
        /if (fighting=0 & currentmana>focusmana1 & (autofocus=1|autofocus=3) & focus=0) \
            cast 'adrenal focus'%;\
            /set didfoc=1%;\
        /elseif (fighting=1 & currentmana>focusmana2 & autofocus>1 & focus=0) \
            cast 'adrenal focus'%;\
            /set didfoc=1%;\
        /endif%;\
    /endif

;/def -mregexp -t'{Who should the spell be cast upon?|The wimp isn\'t here!|Backstab who?}' resettoass = \
;    /set groupass=1%;/if (spellup=~'null' | autofocus=1) /set didfoc=0%;/endif


/def -aBCblue -mglob -t'*{Your thoughts and body become as one\!|You continue your concentration.}*' gotfocus= \
    /set focus=1%;/gotspell focus

/def -mregexp -t'Your deadly concentration breaks.' refocus= \
    /set focus=0%;/set didfoc=0%;/adr

/def -mregexp -t'gets a deadly look' focus3= \
    /adr

; 

/def -mglob -t'You quickly focus your energy on a blow.' reattack = \
    /repeatdamage

/def -mregexp -t'Let\'s do nothing, nothing at all!' netherb= \
    /repeatdamage

/def -p2 -mglob -F -aBCred -t'Fry em!' tofb = \
    /repeatdamage

/def -p2 -mglob -F -aBCcyan -t'Ice em!' toib = \
    /repeatdamage        

/def -p2 -mglob -aBCred -t'Your bolt hits * hard, and leaves a burn mark big as a fist.' fireb= \
    /repeatdamage

/def -p2 -mglob -aBCred -t'You throw a fireball at * and have the satisfaction of seeing * enveloped in flames\!' fireb2= \
    /repeatdamage

/def -p2 -mglob -aBCred -t'You look after the blazing ball of flames that shoots out of your palm.' fireb3 = \
    /repeatdamage

/def -mregexp -aBCcyan -t'Your water bolt hits .* in the head, almost drowning' waterb = \
    /repeatdamage

/def -p2 -mglob -aBCred -t'You slam * with your meteor bolt, bullseye\!' meterorb = \
    /repeatdamage

/def -p2 -mglob -aBCwhite -t'You watch with self pride as your magic missile hits*' mmissile = \
    /repeatdamage

/def -F -p2 -mglob -aBCwhite -t"Ah, let's give * heartmassage." autofight_shockbolt = \
    /repeatdamage

/def -F -p2 -mglob -aBCwhite -t"Small sparks run up and down * chest..." autofight_shockbolt2 = \
    /repeatdamage

/def -F -p2 -aCred -mglob -t"You enshroud * in vampiric mists." vampiricmist = \
    /repeatdamage

/def -F -p2 -aCred -msimple -t"You are enshrouded in your own vampiric mists!" autofight_vampiricmist_fail = \
    /repeatdamage

/def -p2 -mglob -t'You circle around the back of your target and stab *' circle_1 = \
    /repeatdamage

/def -p2 -mglob -t'You try to circle around the back of *' circle_2 = \
    /repeatdamage

/def -p2 -mglob -t'You pummel *' pummel_1= \
    /repeatdamage

/def -p2 -mglob -t'You fail your pummel.' pummel_2= \
    /repeatdamage

/def -mregexp -aBCcyan -t'SPLAM! Bulls eye, the ice bolt hit .* right in .* face!' iceb= \
    /repeatdamage

/def -p2 -mglob -t'You {try to grab|grab} *\'s head *' headb= \
    /repeatdamage

/def -mregexp -t'You call forth raw elemental energy.|You focus your will.|You call forth the flames of HELL|\
    You utter a single arcane word of pain.' otherb=\
    /repeatdamage

/def -aBCblue -mregexp -t'You feel a HUGE adrenaline rush!!!  You will FIGHT TO THE DEATH!' berserk = \
    /set berserk=1%;\
    /repeatdamage

/def -F -mregexp -t'You become humble again.' berserk_off = /set berserk=0%;/set deathdance=0

/def -mregexp -t'You fail to find enough energy.' berserk2 = \
    /repeatdamage

/def -mglob -t'You call upon your gods to pass judgement.' judgment1 = \
    /repeatdamage

/def -p2 -mglob -t'You enshroud * in vampiric mists.' vampm = \
    /repeatdamage

/def -aCyellow -mglob -t'Ah, they are lovely, aren\'t they?' insectsplague = \
    /repeatdamage

/def -aCgreen -mglob -t'You chant for transformation.' sticksofsnakes = \
    /repeatdamage

/def -aCyellow -mglob -t'You make a blistering beam of light strike from the sky.' sunarrow = \
    /repeatdamage

/def -aCgreen -mglob -t'You make a handful of seeds glow fiery red and hurl them at *' fireseeds = \
    /repeatdamage

/def -mglob -t'As * avoids your bash, you topple over and fall to the ground!' bash1 = \
    /set fighting=1%;\
    stand%;\
    /repeatdamage

/def -mglob -t'Your bash at * sends * sprawling!' bash2 = \
    /set fighting=1%;\
    /repeatdamage

/def -p2 -mglob -aBCcyan -F -t"You chill *!" autofight_chilltouch = \
    /repeatdamage

/def -p2 -mglob -aBCcyan -F -t"The atmosphere turns chilly as you miss *!" autofight_chilltouch_2 = \
    /repeatdamage

/def -p2 -msimple -aBCcyan -F -t"Your fingers crackle as you concentrate on charging the air." autofight_shockinggrasp = \
    /repeatdamage

;;;;;;;;;;;;;;;
;AREA SECTIONS;
;;;;;;;;;;;;;;;
/alias ajoin /areatojoin
/def areatojoin = \
    /if (areatojoin=1) /set areatojoin=0%;/echo -aBCblue *** Won't area to join automatically.%;\
    /else /set areatojoin=1%;/echo -aBCred *** You will area in if you can't see the mob.%;/endif

/def -aCmagenta -mglob -t'You can\'t see who is fighting *!' areain = \
    /if ((areaspells)&(autofight)=1) \
        %{damage}%;/set lspell=%{damage}%;\
    /elseif ((areatojoin)&(autofight)=1) \
        %{areaspell}%;/set lspell=%{areaspell}%;\
    /endif

/def -mglob -t'You call forth swirling elemental energy.' pballarea =\
    /startarea

/def -mglob -t'*screams in pain as you cover {it|him|her} with raw elemental energy.' pballarea2=\
    /repeatarea

/def -mglob -t'You bring up black fire from hell to engulf all monsters!' hstarea = \
    /startarea

/def -mglob -t'* screams in pain as you hurl black flames at *' hstarea2 = \
    /repeatarea

/def areas = \
    /if (areaspells=1) \
        /ecko Single spells will be casted.%;\
        /set areaspells=0%;\
        /set areafight=0%;\
    /else \
        /ecko %htxt2\AREAS! AREA SPELLS %ntxt\will be casted. Turn off with /areas (This is in testing period, give me bug info ;-)%;\
        /set areaspells=1%;\
        /set areafight=1%;\
    /endif

; deathdances
/def -mregexp -aBCred -t'You feel too tired for a dance of death right now\.' deathdancetired = \
    /set deathdance=1%;\
    /repeatdamage

/def -mregexp -aBCgreen -t'You concentrate your thoughts and begin your deadly display of weapon prowess\.' deathdanceon = \
    /set deathdance=2%;\
    /repeatdamage

/def -msimple -t"You can't seem to get the right rhythm to it." deathdancefail = \
    /set deathdance=0%;\
    /repeatdamage

/def -aBCcyan -mregexp -t'With no opponents left, you end your dashing display of weapon skill' deathdanceoff = \
    /set deathdance=0


/def -mglob -t'The water weird is here, fighting*' rp_weird = \
    /if ((priest|nightblade|animist|templar) > 0) \
        retreat%;cast 'remove poison' weird%;\
    /endif

