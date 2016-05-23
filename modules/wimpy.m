;;;;;;;
;Wimpy;
;;;;;;;

/def wimpy = \
  /if ({1} =/ 'on') \
    /set autowimpy=1%;/wimpstatus%;\
  /elseif ({1} =/ 'off') \
    /set autowimpy=0%;/wimpstatus%;\
  /else \
    /if (autowimpy=1) \
      /set autowimpy=0%;/wimpstatus%;\
    /else \
      /set autowimpy=1%;/wimpstatus%;\
    /endif%;\
  /endif

/def wimpstatus = \
  /if (autowimpy=1) \
    /ecko You will now try to recall from battle at %htxt2%{wimpylevel} %{ntxt}hps. (Use %{htxt}/setwimp %{ntxt}to change Wimp Level)%;\
  /else \
    /ecko Autowimpy is now %htxt\disabled%ntxt\, you will fight to the death.%;\
  /endif

/def setwimp=/set wimpylevel=%{1}%;/set wimpylevel2=%{1}%;/ecko Wimpylevel set to: %{1}.

/def checkwimp = \
  /if (selfmhp=~'' | selfmhp=0) \
    /let selfmhp=20%;\
  /endif%;\
  /let miraselfhp=$[{maxhp}*({selfmhp}/100.0)]%;\
  /if ((0) & (currenthp <= miraselfhp) & (selfmira=1) & (miraingself!=1) & (priest>1)) \
    /if (currentmana>0) \
      mira self%;\
      /ecko Trying to Miracle self! %{currenthp} is lower than %{miraselfhp}!%;\
      /set miraingself=1%;/repeat -0:00:20 1 /set miraingself=0%;\
    /else \
      /ecko You got negative mana and can't mira self!!!!%;\
      ps%;\
      /set miraingself=1%;\
      /repeat -0:00:20 1 /set miraingself=0%;\
    /endif%;\
  /endif%;\
  /if (autowimpy=1 & fighting=1) \
    /if ((currenthp <= wimpylevel) & (xsdamage!=1)) \
      /ecko %{htxt2}TRYING TO WIMP OUT!!!!!!!!!!!! ARGHAA!!%;\
      /set xsdamage=1%;\
      /if (panicrecallcmd !~ '') \
	/eval %panicrecallcmd%;\
      /else \
        tele%;\
      /endif%;\
      /set autowimpy=0%;\
      /repeat -0:00:20 1 /set autowimpy=1%;\
      /repeat -0:01:00 1 /set xsdamage=0%;\
    /endif%;\
  /endif

/if (priest>1) \
  /def selfmira = \
   /if (selfmira) \
    /set selfmira=0%%;\
    /ecko Turning SelfMIRA OFF%%;\
   /else \
    /set selfmira=1%%;\
    /ecko Turning SelfMIRA ON%%;\
   /endif%;\
/endif
