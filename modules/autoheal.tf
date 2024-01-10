; // vim: set ft=tf:
;=============================
;   Basic Autoheal Script
;=============================

;;;Fix variables by default.
/lood modules/autohealvalues.tf

;;;Group Thingie
/def gg = \
	/if (aheal=1 & ingroup=1) \
		/if (atthp!~'off' & atthp >= atmhp & atthp>=atghp & atthp>=atgphp) \
			/let _groupinterval=%atthp%;\
		/elseif (atghp!~'off' & atghp >= atmhp & atghp>=atgphp) \
			/let _groupinterval=%atghp%;\
		/elseif (atmhp!~'off' & atmhp >= atgphp) \
			/let _groupinterval=%atmhp%;\
		/elseif (atgphp!~'off' & atgphp>0) \
			/let _groupinterval=%atgphp%;\
		/else \
			/let _groupinterval=100%;\
		/endif%;\
		group 0-%{_groupinterval}%;\
	/endif

;;;Main Script
/def status = \
	/unset st1%;\
	/if (priest > 0 | templar > 1 | animist > 1) \
		/let _st1=1%;\
		/if (aheal=1) \
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
				/if (miragroup=1) \
					/set st1=%{st1} gmhp: %{atgmhp}\%%;\
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
;            /if (priest>1) \
;                /if (ghealblind=1) \
;                    /set st1=%{st1} agheal: on%;\
;                /else \
;                    /set st1=%{st1} agheal: off%;\
;                /endif%;\
;            /endif%;\
		/elseif (priest>1) \
			/set st1=All healing is disabled!%;\
		/endif%;\
	/endif%;\
;    /if (magician>0 & coptype>1) \
;        /let _st1=1%;\
;        /if (coptype=2) \
;            /let _st2=cop: agg+keep%;\
;        /elseif (coptype=3) \
;            /let _st2=cop: keep%;\
;        /elseif (coptype=4) \
;            /let _st2=cop: agg%;\
;        /endif%;\
;        /if (st1!~'') \
;            /set st1=%{st1} %{_st2}%;\
;        /else \
;            /set st1=%{_st2}%;\
;        /endif%;\
;    /endif%;\
/if (priest>0) \
	/if (autoholy=1) \
		/set st1=%{st1} aholy: on%;\
	/else \
		/set st1=%{st1} aholy: off%;\
	/endif%;\
/endif%;\
/if (_st1=1 & ingroup=1) \
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
	/if ({1} =~ "off") \
		/set miratank=0%;\
	/else \
		/set miratank=1%;\
	/endif%;\
	/set atmhp=$[strip_attr(%1)]%;\
	/ecko Miracling %{tank} at %{atmhp}.

/def thp = \
	/if ({1} =~ "off") \
		/set truetank=0%;\
	/else \
		/set truetank=1%;\
	/endif%;\
	/set atthp=$[strip_attr(%1)]%;\
	/ecko Healing %{tank} at %{atthp}.

/def ghp = \
	/if ({1} =~ "off") \
		/set truegroup=0%;\
	/else \
		/set truegroup=1%;\
	/endif%;\
	/set atghp=$[strip_attr(%1)]%;\
	/ecko Healing group at %{atghp}.

/def gphp= \
	/if ({1} =~ "off") \
		/set gpowgroup=0%;\
	/else \
		/set gpowgroup=1%;\
	/endif%;\
	/set atgphp=$[strip_attr(%1)]%;\
	/ecko Grouppowerheal at %{atgphp}. (%{maxgpowcount})

/def gmhp= \
	/if ({1} =~ "off") \
		/set miragroup=0%;\
	/else \
		/set miragroup=1%;\
	/endif%;\
	/set atgmhp=$[strip_attr(%1)]%;\
	/ecko Groupmiracle at %{atgmhp}.


;/def wildmagic = \
;    /set miratank=0%;\
;    /set truetank=0%;\
;    /set truegroup=0%;\
;    /set autogpow=1%;\
;    /echo -aBCred Now using GPOWS forhealing ONLY! No singletarget spells

;/def area = \
;    /wildmagic

;/def single = \
;    /set miratank=1%;\
;    /set truetank=1%;\
;    /set truegroup=1%;\
;    /set autogpow=1%;\
;    /echo -aBCred Now using singletarget spells again!

;/def noarea = \
;    /single

/def gh = \
	/status

/def gth = \
	/status

;/def -F -q -mregexp -t"^([A-Za-z]+) tells you 'mhp (off|[-|0-9]+)'" cmhp = \
;    /if ({P1}=~tank & (priest>1 | templar>1)) \
;        /mhp %{P2}%;\
;        /status %{P1}%;\
;    /endif

;/def -F -q -mregexp -t"^([A-Za-z]+) tells you 'thp (off|[-|0-9]+)'" cthp = \
;    /if ({P1} =~ tank & (priest>0 | animist>1)) \
;        /thp %{P2}%;\
;        /status %{P1}%;\
;    /endif

;/def -F -q -mregexp -t"^([A-Za-z]+) tells you 'ghp (off|[-|0-9]+)'" cghp = \
;    /if ({P1} =~ tank & (priest>0 | animist>1)) \
;        /ghp %{P2}%;\
;        /status %{P1}%;\
;    /endif

;/def -F -q -mregexp -t"^([A-Za-z]+) tells you 'gmhp (off|[-|0-9]+)'" cgmhp = \
;    /if ({P1} =~ tank & (templar>1)) \
;        /gmhp %{P2}%;\
;        /status %{P1}%;\
;    /endif

;/def -F -q -E(priest>1) -mregexp -t'^([A-Za-z]+) tells you \'gphp (off|[-|0-9]+)\'' cgphp = \
;    /if ({P1}=~tank) \
;        /gphp %{P2}%;\
;        /status %{P1}%;\
;    /endif

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
	/uzi_autoheal_toggler %{1}

/def uzi_autoheal_toggler = \
	/if (priest>0|animist>0|templar>1) \
		/if ({-1}=~'') \
			/let _channel=/ecko%;\
		/else \
			/let _channel=%{-1}%;\
		/endif%;\
		/if ({*}=~'') \
			/if (aheal=1) \
				/uzi_autoheal_toggler off%;\
			/else \
				/uzi_autoheal_toggler on%;\
			/endif%;\
		/else \
			/if (regmatch('(on|off)', {1})) \
				/if ({P1}=~'on') \
					/set aheal=1%;\
					/eval %{_channel} Autohealing: ON%;\
					/status%;\
					/if (ingroup) \
						/set sentgroup=1%;\
						group%;\
;                    /else \\
;                        gg%;\
					/endif%;\
				/else \
					/set aheal=0%;\
					/eval %{_channel} Autohealing: OFF%;\
				/endif%;\
			/else \
				/ecko AHEAL: Syntax error! <aheal [on|off] [communcation]>%;\
			/endif%;\
		/endif%;\
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
	/set blind_handler=1%;\
	/if ((priest|animist|templar)) \
		/if ({1}=~{tank}) \
			heal %{tank}%;\
		/elseif (ismember({1}, gplist)) \
			/set blind_list=%{1} %{blind_list}%;\
			/set blind_list=$(/unique %{blind_list})%;\
			/set blinded=$(/length %{blind_list})%;\
		/elseif (blind=1) \
			/test ++blinded%;\
		/endif%;\
	/endif

/def -Fp100 -mregexp -t'^([A-z]+)heals ([A-z+]).$' blind_cure_heal =\
	/set blind_list=$(/remove %{P2} %{blind_list})%;\
	/set blinded=$(/length %{blind_list})

;/def -mregexp -p1000 -F -t'You receive [0-9]+ experience points.|[^ ]* panics, and attempts to flee\
;|You seem unable to recognise your foe....|You can\'t gain more experience.' cure_blind = \
;    /if (animist>1 & blinded>0) \
;        /if (currentmana>100) \
;            cast 'tranquility'%;\
;            /set lspell=cast 'tranquility'%;\
;            /set blinded=0%;\
;            /set blind_list=%;\
;        /endif%;\
;    /endif

;; Wound-bleed.
/def -p1 -aBCred -mglob -t'You bleed from your wounds.' acurebleed = \
	/set curecritic=1%;\
	/dospellup curecritic

/def -p1 -aBCwhite -msimple -t'You feel somewhat better.' bleed_cured = \
	/set curecritic=0%;\
	/gotspell curecritic

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
	/if (priest>0) \
		/if (awithered=1) \
			/set remit=0%;/set askperson=%{1}%; \
			/autorem %{askperson} %;\
			/if (remit=1) pow %{askperson}%;/set lspell= pow %{askperson}%;/endif%;\
		/elseif ((awithered=3)&({1}=/{tank})) \
			/set remit=0%;/set askperson=%{1}%;\
			/autorem %{askperson}%;\
			/if (remit=1) pow %{askperson}%;/set lspell= pow %{askperson}%;/endif%;\
		/endif%;\
	/elseif (animist>1) \
		/if (ismember({1}, gplist)|blind=1) \
			/set withered_list=%{1}%;\
			/set withered_list=$(/unique %{withered_list})%;\
			/set withered=$(/length %{withered_list})%;\
		/endif%;\
	/endif

/def -mglob -aBCred -t'You are blind!' cureblindself = \
	/set blind=1%;\
	/set blind_list=%{char} %{blind_list}%;\
	/set blind_list=$(/unique %{blind_list})%;\
	/set blinded=$(/length %{blind_list})%;\
	/if (nyx_spec>0) \
		use ciquala%;\
	/elseif (priest > 1) \
		cast 'groupheal'%;\
	/endif

/def -msimple -aBCwhite -F -t'Your vision returns!' blind_cured = \
	/set blind=0%;\
	/set blind_list=$(/remove %{char} %{blind_list})%;\
	/set blinded=$(/length %{blind_list})%;\
	/if (spellup='cb') \
		/gotspell cb%;\
	/endif%;\

;    /set blind_list=%;\
;    /set blinded=0


/def -msimple -aBCwhite -F -t'You concentrate to create a strong field of positive energy.' tranq1
/def -msimple -aBCwhite -F -t'Your tranquility banishes all chaotic and disharmonic forces.' tranq2 = \
	/set blind=0%;\
	/set blind_list=%;\
	/set blinded=0%;\
	/set wither=0%;\
	/set withered_list=%;\
	/set withered=0%;\
	/gotspell tranq

/def -mregexp -aBCwhite -F -t'^([A-z]+) emits a strong field of positive energy, banishing all chaotic forces.' tranq3 = \
	/tranq2

;*********************** Utilities *********************;

;/def -p999 -F -mglob -aCmagenta -t'You join the fight!*' joinedfdf = \
;    /if (tickison=0 & gager>0) /set tickison=1%; gg%; /endif

;/def -F -p999 -mregexp -t'assists|rushes to attack|is here, fighting|heroically rescues' assasdf4 = \
;    /if (tickison=0 & gager>0) /set tickison=1%; gg%; /endif

;/def -F -p999 -mregexp -t'No way\! You are fighting for your life' ass1asdf = \
;    /if (tickison=0 & gager > 0) /set tickison=1%; gg%; /endif

;/def -p99 -F -q -mregexp -t'([^ ]*) (misses|hits|pounds|crushes|tickles|pierces|cuts|blasts|slashes\
;    |massacres|obliterates|annihilates|vaporizes|pulverizes|atomizes|ultraslays\
;    |\*\*\*ULTRASLAYS\*\*\*|\*\*\*U\*L\*T\*R\*A\*S\*L\*A\*YS\*\*\*|\*\*\*SPANKS\*\*\*) ([^ ]*)' autoassist1asdf = \
;    /set who1=%{P1}%; /set who2=%{P3}%; \
;    /if (tickison=0 & aheal=1 & gager > 0) /set tickison=1%; gg%; /endif

;/def -mregexp -t'No way\! You are fighting for your life' ass1 = /set fighting=0
;/def -Egimpmira -mregexp -t'([^ ]*) tells you \'gimp\'' priestmir=mira %{P1}

/def -mregexp -t'tells the group, \'status\'' gtstatus = /status
/def -mregexp -t'([A-z]+)tells you \'status\'' tellonstatus = /status %{P1}

;/def -mregexp -t'tells you \'vis\'' leadervis = \
;    /if ({1}=~tank) \
;        visible%;\
;    /endif

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

;; Cure critical wounds
/def -E(priest>0|templar>0|animist>0) -Fp1000 -mregexp -t'^([A-z]+) is bleeding from his critical wounds.$' uzi_cure_critic0 = \
	/if (fighting=0 & ismember({1}, gplist) & manalevel!~'low') \
		/if (rand(3)=1) \
			cc %{P1}%;\
		/endif%;\
	/endif

;; Cast gheal upon mob death to cure mass blindness

;/def -Epriest>1 -mregexp -F -p102311 -t'^(A Lich of Sarakesh|A fanatic Grolim priest|The mystical soulcrusher) is dead\! R.I.P.$' uzi_autoheal_gheal_on_death = \
;    /if (promana>30 & ghealblind>0 & ingroup=1) \
;        cast 'groupheal'%;\
;    /endif

/def uzi_autoheal_ghealblind = \
	/let _input=%{*}%;\
	/let _channel=%{-1}%;\
	/if (priest=2) \
		/if (regmatch('(on|off)', _input)=0) \
			/if (ghealblind=1) \
				/uzi_autoheal_ghealblind off%;\
			/else \
				/uzi_autoheal_ghealblind on%;\
			/endif%;\
		/else \
			/if ({P1}=~'on') \
				/set ghealblind=1%;\
				/if ({_channel}!~'') \
					%{_channel} is now casting groupheal to cure blindness!%;\
				/else \
					/ecko Now casting groupheal to cure blindness!%;\
				/endif%;\
			/else \
				/set ghealblind=0%;\
				/if ({_channel}!~'') \
					%{_channel} won't cast groupheal to cure blindness!%;\
				/else \
					/ecko No longer casting groupheal to cure group blindness.%;\
				/endif%;\
			/endif%;\
		/endif%;\
	/endif


/def agheal = \
	/uzi_autoheal_ghealblind %{*}


/def -mregexp -Fp2333 -ag -t'^([A-z]+) looks MUCH better as you invoke your true healing powers.$' trueheal_hilite = \
	/echo -an -p @{nCyellow}%{P1}@{BCwhite} looks MUCH better as @{BCmagenta}you@{BCwhite} invoke your true healing powers. @{nCwhite}(@{BCmagenta}trueheal@{nCwhite})

/def -mregexp -Fp2333 -ag -t'^(.*) looks MUCH better as (.*) invokes a heal-formula.$' trueheal_hilite2 = \
	/echo -an -p @{nCyellow}%{P1}@{BCwhite} looks MUCH better as @{nCmagenta}%{P2}@{BCwhite} invokes a heal-formula. @{nCwhite}(@{nCmagenta}trueheal@{nCwhite})

/def -mregexp -Fp2333 -ag -t'^You feel MUCH better as (.*) utters some strange words.$' trueheal_hilite3 = \
	/echo -an -p @{nCyellow}You@{BCwhite} feel MUCH better as @{nCmagenta}%{P1}@{BCwhite} utters some strange words. @{nCwhite}(@{nCmagenta}trueheal@{nCwhite})

/def -mregexp -ag -Fp2333 -t'^You feel much better as (.*) utters some strange words.' gpow_hilite = \
	/echo -an -p @{nCyellow}You@{BCwhite} feel much better as @{nCmagenta}%{P1}@{BCwhite} utters some strange words. @{nCwhite}(@{nCmagenta}grouppowerheal@{nCwhite})

/def -mregexp -ag -Fp2333 -t'^You feel better as (.*) utters some strange words.' gheal_hilite = \
	/echo -an -p @{nCyellow}You@{BCwhite} feel better as @{nCmagenta}%{P1}@{BCwhite} utters some strange words. @{nCwhite}(@{nCmagenta}groupheal@{nCwhite})%;\
	/set blinded=0%;\
	/set blind_list=

/def -mregexp -ag -Fp2333 -t'^You feel better as (.*) heals you.' heal_hilite = \
	/echo -an -p @{nCyellow}You@{BCwhite} feel better as @{nCmagenta}%{P1}@{BCwhite} heals you. @{nCwhite}(@{nCmagenta}heal@{nCwhite})%;\


	/def -mregexp -ag -Fp2333 -t'^A warm feeling surges through your body as (.*) solemnly chants.' powerheal_hilite2 = \
		/echo -an -p @{BCwhite}A warm feeling surges through @{nCyellow}your@{BCwhite} body as @{nCmagenta}%{P1}@{BCwhite} solemnly chants. @{nCwhite}(@{nCmagenta}powerheal@{nCwhite})

/def -mregexp -Fp2333 -ag -t'^As (.*) solemnly chants, (.*) is powerhealed.$' powerheal_hilite = \
	/echo -an -p @{nCwhite}As @{nCmagenta}%{P1}@{BCwhite} solemnly chants, @{nCyellow}%{P2}@{BCwhite} is powerhealed. @{nCwhite}(@{nCmagenta}powerheal@{nCwhite})

/def -msimple -Fp2333 -ag -t'You chant loudly for the well being of your group.' gwow_hitlite= \
	/echo -an -p @{BCmagenta}You@{BCwhite} chant loudly for the well being of your @{nCyellow}group@{BCwhite}. @{nCwhite}(@{nCmagenta}grouppowerheal@{nCwhite})

/def -mregexp -Fp2333 -ag -t'^(.*) raises (her|his|its) palm and unleashes a burst of raw life energy on (.*).$' burst_hilite = \
	/echo -an -p @{nCmagenta}%{P1}@{BCwhite} raises %{P2} palm and unleashes a burst of raw life energy on @{nCyellow}%{P3} @{nCwhite}(@{nCmagenta}burst of life@{nCwhite})

/def -mregexp -Fp2333 -ag -t'^You feel newfound power as ([A-z]+) releases a burst of life energy on you.' burst_hilite2 = \
	/echo -an -p @{nCyellow}You@{BCwhite} feel newfound power as @{nCmagenta}%{P1}@{BCwhite} releases a burst of life energy on you. @{nCwhite}(@{nCmagenta}burst of life@{nCwhite})

/def -msimple -Fp2333 -ag -t'You feel newfound power as you let your charged life energy burst on yourself.' burst_hilite4 = \
	/echo -an -p @{BCmagenta}You@{BCwhite} feel newfound power as you let your charged life energy burst on @{nCyellow}yourself@{BCwhite}. @{nCwhite}(@{nCmagenta}burst of life@{nCwhite})

/def -mregexp -Fp233 -ag -t'^You release a powerful burst of life on (.*).$' burst_hilite5 = \
	/echo -an -p @{BCmagenta}You@{BCwhite} release a powerful burst of life on @{nCyellow}%{P1}.
