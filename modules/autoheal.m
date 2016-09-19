; // vim: set ft=tf:
;=============================
;   Basic Autoheal Script
;=============================

;;;Fix variables by default.
/lood modules/autohealvalues.m

;;;Group Thingie
/def gg = \
    /if (sentgroup=0 & aheal=1) \
        group %{groupinterval}%;\
        /set sentgroup=1%;\
    /endif

;;;Main Script
/def status = \
    /if (priest > 0 | templar > 1 | animist > 1) \
        /if (aheal=1) \
            /unset st1%;\
            /set st1=Tank: %{tank},%;\
            /if (healcontrol !~ '') \
                /set st1=%{st1} HealC: %{healcontrol}, %;\
            /endif%;\
            /if (templar>1 | priest>1) \
                /if (miratank=1) \
                    /set st1=%{st1} mhp: %{atmhp}\%%;\
                /else \
                    /set st1=%{st1} mhp: off%;\
                /endif%;\
            /endif%;\
            /if (priest>0 | animist>1) \
                /if (truetank=1) \
                    /set st1=%{st1} thp: %{atthp}\%%;\
                /else \
                    /set st1=%{st1} thp: off%;\
                /endif%;\
                /if (truegroup=1) \
                    /set st1=%{st1} ghp: %{atghp}\%%;\
                /else \
                    /set st1=%{st1} ghp: off%;\
                /endif%;\
            /endif%;\
            /if (priest>1) \
                /if (gpowgroup=1) \
                    /set st1=%{st1} gphp: %{atgphp}\%(%{maxgpowcount})%;\
                /else \
                    /set st1=%{st1} gphp: off%;\
                /endif%;\
            /endif%;\
	    /if (priest>1) \
		/if (autoholy=1) \
		    /set st1=%{st1} aholy: on%;\
		/else \
		    /set st1=%{st1} aholy: off%;\
		/endif%;\
	    /endif%;\
        /else \
            /set st1=all autohealing is disabled.%;\
        /endif%;\
        /if ({1} !~ '') \
            tf %{1} , is set to, '%{st1}' (uzi %uziversion)%;\
        /else \
            gtf , is set to, '%{st1}' (uzi %uziversion)%;\
        /endif%;\
    /endif

; Mana threshold - start saving mana if below this
/def th = \
    /set thresh=%{1}%;\
    /ecko Thresh: %{htxt2}%{1}

/def hstate = \
    /if (miratank=1) \
        /set atmhp%;\
    /endif%;\
    /set thresh

/def mhp = \
    /if (%1 =~ "off") \
        /set miratank=0%;\
    /else \
        /set miratank=1%;\
    /endif%;\
    /set atmhp=%1%;\
    /ecko Miracling %{tank} at %{atmhp}.

/def thp = \
    /if (%1 =~ "off") \
        /set truetank=0%;\
    /else \
        /set truetank=1%;\
    /endif%;\
    /set atthp=%1%;\
    /ecko Healing %{tank} at %{atthp}.

/def ghp = \
    /if (%1 =~ "off") \
        /set truegroup=0%;\
    /else \
        /set truegroup=1%;\
    /endif%;\
    /set atghp=%1%;\
    /ecko Healing group at %{atghp}.

/def gphp= \
    /if (%1 =~ "off") \
        /set gpowgroup=0%;\
    /else \
        /set gpowgroup=1%;\
    /endif%;\
    /set atgphp=%1%;\
    /ecko Grouppowerheal at %{atgphp}. (%{maxgpowcount})

/def wildmagic = \
    /set miratank=0%;\
    /set truetank=0%;\
    /set truegroup=0%;\
    /set autogpow=1%;\
    /echo -aBCred Now using GPOWS forhealing ONLY! No singletarget spells

/def area = \
    /wildmagic

/def single = \
    /set miratank=1%;\
    /set truetank=1%;\
    /set truegroup=1%;\
    /set autogpow=1%;\
    /echo -aBCred Now using singletarget spells again!

/def noarea = \
    /single

/def gh = \
    /status

/def gth = \
    /status

/def -F -q -mregexp -t"^([A-Za-z]+) tells you 'mhp (off|[-|0-9]+)'" cmhp = \
    /if ({P1}=~tank & (priest>1 | templar>1)) \
        /mhp %{P2}%;\
        /status %{P1}%;\
    /endif

/def -F -q -mregexp -t"^([A-Za-z]+) tells you 'thp (off|[-|0-9]+)'" cthp = \
    /if ({P1} =~ tank & (priest>0 | animist>1)) \
        /thp %{P2}%;\
        /status %{P1}%;\
    /endif

/def -F -q -mregexp -t"^([A-Za-z]+) tells you 'ghp (off|[-|0-9]+)'" cghp = \
    /if ({P1} =~ tank & (priest>0 | animist>1)) \
        /ghp %{P2}%;\
        /status %{P1}%;\
    /endif

/def -F -q -E(priest>1) -mregexp -t'^([A-Za-z]+) tells you \'gphp (off|[-|0-9]+)\'' cgphp = \
    /if ({P1}=~tank) \
        /gphp %{P2}%;\
        /status %{P1}%;\
    /endif

/def -F -q -E(priest>1) -mregexp -t'^([A-Za-z]+) tells you \'gpc ([0-9]+)\'' cgphpc = \
    /if ({P1}=~tank) \
        /set maxgpowcount=%{P2}%;\
        /status %{P1}%;\
    /endif


/def -F -mregexp -p999999 -t'^([A-Za-z]+) tells you \'(aholy|sanc|autoholy|holy)(| on| off)\'' asancself = \
    /if ({1}=~tank) \
        /if (autoholy=1) \
            /if (templar>1) \
                /set autoholy=0%;\
                /set sanctype=sanc%;\
                tell %1 Autosanc self &+RDeactivated.%;\
            /elseif (priest>0) \
                /set autoholy=0%;\
                /set sanctype=holyword%;\
                tell %1 Autoholy &+RDeactived.%;\
            /endif%;\
        /else \
            /if (templar>1) \
                /set autoholy=1%;\
                /set sanctype=sanc%;\
                tell %1 Autosanc self &+GActivated.%;\
            /elseif (priest>0) \
                /set autoholy=1%;\
                /set sanctype=holyword%;\
                tell %1 Autoholy &+GActivated.%;\
            /endif%;\
        /endif%;\
    /endif

/def ah = \
    /if (aheal=0) \
        /ecko Autohealing: %{htxt2}ON%; \
        /set aheal=1%; \
    /else \
        /ecko Autohealing: %{htxt2}OFF%; \
        /set aheal=0%; \
    /endif


/def autorem = \
    /mapcar /autoperson %{gplist}

/def autoperson = \
    /if (%{askperson}=/%1) \
        /set remit=1%;\
    /endif

/def bless = \
    /if (blessme=0) \
        /set blessme=1%;\
        /if (priest>1) \
            /ecko You think this gang needs blessings, groupblessings coming up.%;\
            /set groupbless=1%;\
        /else \
            /ecko Casting bless on urself.%;\
            /set groupbless=0%;\
        /endif%;\
    /else \
        /set blessme=0%;\
        /ecko You will bless on request.%;\
        /set groupbless=0%;\
    /endif

/set aregen=0
/def autoregen = \
    /if (aregen=0) \
        /set aregen=1%; \
        /echo -aCred You will regen anyone in group.%; \
    /else \
        /set aregen=0%; \
        /echo -aCred You will let them regen theirselves.%; \
    /endif

/def -mregexp -Earegen -t'[^ ] suddenly shivers slightly.' regend = \
    /set remit=0%;\
    /set askperson=%{1}%;\
    /autorem %{askperson} %;\
    /if (remit=1) \
        cast 'regenerate' %{askperson}%;\
        /set lspell=regen %{askperson}%;\
    /endif

/set grouparm=0
/def garm = \
    /if (grouparm=0) \
        /set grouparm=1 %; \
        /ecko You will auto Armor the group.%; \
    /else \
        /set grouparm=0 %; \
        /ecko You will let them cast their own armor spells!%; \
    /endif

/set abless=0
/def autobless = \
    /if (abless=0) \
        /set abless=1%; \
        /echo -aCred You will bless people when they lose they way.%; \
    /else \
        /set abless=0%; \
        /echo -aCred You don't think people deserve to be blessed without asking.%; \
    /endif

/set ablind=3

/def autoblind = \
    /if (ablind=0) \
        /set ablind=1%; \
        /echo -aCred You will cure anyone who's blinded.%; \
    /else \
        /set ablind=0%; \
        /echo -aCred You will leave those blinded to suffer.%; \
    /endif

/def -p1 -aBCred -mregexp -t'[^ ] seems to be blinded.*' blindd = \
    /if ((ablind=1)&(priest|templar|animist>0)) \
        /set remit=0%;\
        /set askperson=%{1}%; \
        /autorem %{askperson} %;\
        /if (remit=1) \
            heal %{askperson}%;\
            /set lspell=heal %{askperson}%;\
        /endif%;\
    /elseif ((ablind=3)&({1} =/ {tank})&(priest|templar|animist>0)) \
        /set remit=0%;\
        /set askperson=%{1}%; \
        /autorem %{askperson} %;\
        /if (remit=1) \
            heal %{askperson}%;\
            /set lspell=heal %{askperson}%;\
        /endif%;\
    /endif

;; Wound-bleed.
/def -p1 -aBCred -mglob -t'You bleed from your wounds.' acurebleed = \
    /if (priest|templar|animist>0) \
        cast 'cure critic' self%;\
    /elseif (askpr!~'') \
        ask %askpr cc%;\
    /endif

/def -p1 -aBCred -mglob -t'You feel burning poison in your blood, and suffer.' arempoison = \
    /if (priest|templar|animist|nightblade>0) \
        cast 'remove poison' self%;\
    /elseif (askpr!~'') \
        ask %askpr rp%;\
    /endif

/set acurse=0
/def autocurse = \
    /if (acurse=0) \
        /set acurse=1%; \
        /echo -aCred You will autocure those cursed.%; \
    /else \
        /set acurse=0%; \
        /echo -aCred You think those cursed will have to ask you.%; \
    /endif


/def -mregexp -aCbgmagenta -t'[^ ] briefly reveal a red aura!' cursd = \
    /if (acurse=1) \
        /set remit=0%;/set askperson=%{1}%; \
        /autorem %{askperson} %;\
        /if (remit=1) rc %{askperson}%;/set lspell= rc %{askperson}%;/endif%;\
    /endif

/set awithered=3

/def -mregexp -aBCcyan -t'[^ ] appears brittle.' witherd = \
    /if (awithered=1) \
        /set remit=0%;/set askperson=%{1}%; \
        /autorem %{askperson} %;\
        /if (remit=1) pow %{askperson}%;/set lspell= pow %{askperson}%;/endif%;\
    /elseif ((awithered=3)&(%{1}=/{tank})) \
        /set remit=0%;/set askperson=%{1}%;\
        /autorem %{askperson}%;\
        /if (remit=1) pow %{askperson}%;/set lspell= pow %{askperson}%;/endif%;\
    /endif

/def -mglob -aBCred -t'You are blind!' cureblindself = \
    /if (priest > 0 & !fighting) \
        cast 'cure blind' self%;\
    /elseif (templar|priest|animist>0) \
        cast 'heal' self%;\
    /endif


;*********************** Utilities *********************;

/def -p999 -F -mglob -aCmagenta -t'You join the fight!*' joinedfdf = \
    /if (tickison=0) /set tickison=1%; gg%; /endif

/def -F -p999 -mregexp -t'assists|rushes to attack|is here, fighting|heroically rescues' assasdf4 = \
    /if (tickison=0) /set tickison=1%; gg%; /endif

/def -F -p999 -mregexp -t'No way\! You are fighting for your life' ass1asdf = \
    /if (tickison=0) /set tickison=1%; gg%; /endif

/def -p99 -F -q -mregexp -t'([^ ]*) (misses|hits|pounds|crushes|tickles|pierces|cuts|blasts|slashes\
    |massacres|obliterates|annihilates|vaporizes|pulverizes|atomizes|ultraslays\
    |\*\*\*ULTRASLAYS\*\*\*|\*\*\*U\*L\*T\*R\*A\*S\*L\*A\*YS\*\*\*|\*\*\*SPANKS\*\*\*) ([^ ]*)' autoassist1asdf = \
    /set who1=%{P1}%; /set who2=%{P3}%; \
    /if (tickison=0 & aheal=1) /set tickison=1%; gg%; /endif

/def -mregexp -t'No way\! You are fighting for your life' ass1 = /set fighting=0
/def -Egimpmira -mregexp -t'([^ ]*) tells you \'gimp\'' priestmir=mira %{P1}

/def -mregexp -t'tells the group, \'status\'' gtstatus = /status
/def -mregexp -t'([A-z]+)tells you \'status\'' tellonstatus = /status %{P1}

/def -mregexp -t'tells you \'vis\'' leadervis = \
    /if ({1}=~tank) \
        visible%;\
    /endif

;*********************** Dynamic Heals *********************;
/set mod_min=0
/set mod_max=0 
/set mod_thr=40 

/def hmod=\
    /if ({#}==3 & {1}<=0 & {2}>=0 & {3}>=0) \
        /set mod_min=%{1}%;\
        /set mod_max=%{2}%;\
        /set mod_thr=%{3}%;\
    /elseif ({#}==1) \
        /if ({1}=/'off') \
            /set mod_min=0%;\
            /set mod_max=0%;\
            /set mod_thr=40%;\
        /elseif ({1}=/'low') \
            /set mod_min=-5%;\
            /set mod_max=5%;\
            /set mod_thr=50%;\
        /elseif ({1}=/'med') \
            /set mod_min=-10%;\
            /set mod_max=10%;\
            /set mod_thr=40%;\
        /elseif ({1}=/'high') \
            /set mod_min=-15%;\
            /set mod_max=10%;\
            /set mod_thr=35%;\
        /endif%;\
    /else \
        /ecko Syntax: /hmod <min> <max> <floor>%;\
        /ecko Syntax: /hmod <low|med|high|off>%;\
    /endif%;\
    /if (mod_min==0 & mod_max==0) \
        /ecko HMOD:   DISABLED!%;\
    /else \
        /ecko HMOD:   Min: %{mod_min} Max: %{mod_max} Floor: %{mod_thr}%;\
    /endif

/def -Eaheal -p199999 -mregexp -t"^([A-Za-z]+) tells you 'hmod ([\-]*[0-9]+) ([0-9]+) ([0-9]+)'" hmod_tell1 = \
    /if ({P1}=~tank) \
        /hmod %{P2} %{P3} %{P4}%;\
        /hmodstat%;\
    /endif

/def -Eaheal -p199999 -mregexp -t"^([A-Za-z]+) tells you 'hmod ([A-z]+)'" hmod_tell2 = \
    /if ({P1}=~tank) \
        /hmod %{P2}%;\
        /hmodstat%;\
    /endif

/def -Eaheal -mregexp -t"tell[s]* the group, 'hmod'" hmod_gtell_status = \
    /hmodstat

/def hmodstat = \
    /if (mod_min==0 & mod_max==0) \
        gtf , has dynamic heals set to: OFF!%;\
    /else \
        gtf , has dynamic heals set to: Min: %{mod_min} Max: %{mod_max} Floor: %{mod_thr}%;\
    /endif

/def dynaheal = \
    /if (mod_min==0 & mod_max==0) \
        /return "dheal: off"%;\
    /else \
        /return "dheal: %{mod_min} to %{mod_max}, floor: %{mod_thr}\%"%;\
    /endif


/def dynamic_mod = \
    /let _manaratio=$[(currentmana / (maxmana*1.0))-(mod_thr / 100.)]%;\
    /if (_manaratio < 0) \
        /let _manaratio=0%;\
    /endif%;\
    /let _manaratio=$[_manaratio / (1.0-(mod_thr / 100.))]%;\
    /let _mod=$[mod_min + ((mod_max-mod_min)*_manaratio)]%;\
    /return $[trunc(_mod)]


/def mod_list = \
    /let _bakcurrentmana=%{currentmana}%;\
    /let _bakmaxmana=%{maxmana}%;\
    /set currentmana=0%;\
    /set maxmana=100%;\
    /echo :: Dynamic Heals : Min=%{mod_min}  Max=%{mod_max} : Thresh %{mod_thr}%;\
    /while (currentmana <= 100) \
        /echo :: %{currentmana}\% mana -> Mod: $[dynamic_mod()]%;\
        /set currentmana=$[currentmana + 10]%;\
    /done%;\
    /set currentmana=%{_bakcurrentmana}%;\
    /set maxmana=%{_bakmaxmana}

; :heal syntax
/def -F -Eaheal -mregexp -t"^([A-Z][a-z]+) tells you ':heal (.+)'$" multi_set_heal = \
    /let _person=%{P1}%;\
    /if ((_person =~ tank) | (_person =~ healcontrol)) \
        /let _matched=$[tolower({P2})]%;\
        /let _heals=%{_matched}%;\
        /while (regmatch("(^| )(m|g|t|gp)=([0-9]+|off)( |$)",_heals)) \
            /let _label=%{P2}%;\
            /let _value=%{P3}%;\
            /let _heals=%{PR}%;\
            /if (_value =~ 'off' | ((_value >= 0) & (_value <= 100))) \
                /eval /%{_label}hp %{_value}%;\
            /endif%;\
        /done%;\
        /let _heals=%{_matched}%;\
        /if (_person =~ tank) \
            /while (regmatch("(^| )c=([A-z]+|off)( |$)",_heals)) \
                /let _value=%{P2}%;\
                /let _heals=%{PR}%;\
                /if (_value =~ 'off') \
                    /set healcontrol=%;\
                /else \
                    /set healcontrol=$[strcat(toupper(substr(_value,0,1)),substr(_value,1))]%;\
                /endif%;\
            /done%;\
        /endif%;\
        /status %{_person}%;\
    /endif



;; 
/def -Epriest>1 -mregexp -F -p102311 -t'^(A fanatic Grolim priest|The mystical soulcrusher) is dead\! R.I.P.$' uzi_autoheal_gheal_on_death = \
    /if (promana>30 & ghealblind>0 & ingroup=1) \
        cast 'groupheal'%;\
    /endif
