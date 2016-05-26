;======================================
;   Misc Tank Triggs
;======================================

/def -mregexp -t'starts following you.' groupfollower = /if (leading=1) group all%;/endif
/def -mregexp -t'tells the group, \'(el|EL)\'' showel = /if (leading=1) explog show group %;/endif
/def -mregexp -t'tells the group, \'(fl|FL)\'' showfl = /if (leading=1) fraglog show group%;/endif

/def -aBCyellow -mregexp -t'([^ ]*) is left behind.' leftbehind = \
        /if (welling=1 & leading=1) \
          /if (_lastwalkdir =~ 'n') /set _lastwalkdir=north%;\
          /elseif (_lastwalkdir =~ 's') /set _lastwalkdir=south%;\
          /elseif (_lastwalkdir =~ 'w') /set _lastwalkdir=west%;\
          /elseif (_lastwalkdir =~ 'e') /set _lastwalkdir=east%;\
          /elseif (_lastwalkdir =~ 'u') /set _lastwalkdir=up%;\
          /elseif (_lastwalkdir =~ 'd') /set _lastwalkdir=down%;\
          /endif%;\
          tell %{1} &+cYou got &+yleft behind &+cas I walked &+R%{_lastwalkdir}!%;\
        /endif  

/def peeker = \
        /set peeker=%{*}%;\
        /ecko Peeker set to: %htxt2%{*}.

/def -aBCred -mglob -t'You fall down on your butt, from the force of the hit.' standfirst3 = \
	/standresc

/def standresc = \
      /if (leading=1) \
        wake%;\
 	stand%;\
        /let old_tryresc=%lastresc%;\
	/let old_tryresc2=%lastresc2%;\
	/set lastresc=%char%;\
	/set lastresc2=%char%;\
        /if (rescuetype2) \
          /tryrescue %_old_tryresc%;\
        /else \
  	  /tryrescue %_old_tryresc2%;\
        /endif%;\
      /endif


;======================================
;   Autorescue Triggers
;======================================

/def -p2 -F -mregexp -t'(misses|notices|thinks that|tickles|pierces|pounds|crushes|slashes|whips|massacres|obliterates|annihilates|vaporizes\
                       |pulverizes|atomizes|ultraslays|\*\*\*ULTRASLAYS\*\*\*) ([^ ]*)' rescue2 = \
        /tryrescue %{P2}

/def -p2 -F -mregexp -t'(blindly and attacks|is here\, fighting) ([^\.]*)' rescue3 = \
        /tryrescue %{P2}

/def -p2 -mregexp -t'\'([^,]*), I will get you' rescue4 = \
        /tryrescue %{P1}

/def -p2 -F -mregexp -t'rushes to attack ([^\!]*)' rescue5 = \
        /tryrescue %{P1}

/def -mglob -t'*You fail the rescue*' rescue6 = \
    /if (rescuetype=2) \
      rescue %{lastresc2}%;\
    /else \
      rescue %{lastresc}%;\
    /endif

/def -p30 -mregexp -t'Banzai\! To the rescue\...' rescue7 = \
    /set lastresc=%char

/def -p2 -F -mregexp -t'^You receive|Who do you want to rescue' deadtrigg = \
    /set lastresc=%char

/def -mglob -t'{*} is now a member of your group.' addgrp = \
    /set gplist=%{gplist} %{1}

;======================================
;   Autorescue Functions
;======================================

/def onpromptrescue = \
    /if (rescuetype=2 & groupRescue=1) \
      /if ({1}!~char & lastresc!~char) \
        /autorescue %{gplist} YOU%;\
        /set lastresc2=%lastresc%;\
        /set lastresc=%char%;\
      /endif%;\
    /endif

/def tryrescue = \
   /if (ismember({1},{norescue}) = 0) \
     /if (rescuetype=2 & groupRescue=1) \
        /if ({1}!~char) \
          /set lastresc=%{1}%; \
        /endif%;\
      /elseif (groupRescue=1) \
        /if ({1}!~char & {1}!~lastresc) \
          /set lastresc=%{1}%; \
          /if (groupRescue=1) \
            /autorescue %{gplist}%; \
          /endif%; \
        /endif%;\
      /endif%;\
    /endif

/def autorescue = \
    /let i=1%; \
    /while (i <= {gpsize}) \
      /if (lastresc!~char) \
	/if (lastresc=~{1}) \
          rescue %{lastresc}%; \
        /elseif (lastresc=~'YOU') \
          /set lastresc=%char%;\
        /endif%; \
        /shift%; \
      /endif%; \
      /let i=$[i + 1]%; \
    /done

/def -mregexp -t'^([A-Za-z]+) tells you \'rescue (on|off)\'' selectiverescue = \
      /if (fighter>0 | templar>0) \
	/if ({P2} =/ 'on') \
 	  /addresc %P1%;\
	  tell %P1 Will now rescue you.%;\
	/else \
	  /remresc %P1%;\
	  tell %P1 Won't rescue you anymore. Tell me 'rescue on' to enable it again.%;\
	/endif%;\
      /endif

/def addresc = \
    /set norescue=$(/remove %1 %norescue)%;\
    /ecko No Rescues for: %htxt2%norescue

/def remresc = \
    /set norescue=$(/unique %1 %norescue)%;\
    /ecko No Rescues for: %htxt2%norescue

/def resc= \
    /if (rescuetype=0) \
      /ecko Auto-Rescue I: %{htxt2}ON %{ntxt}and Type: %{htxt2}1 %{ntxt}(Rescue on prompt, less spam with fast connection)%; \
      /set groupRescue=1%; \
      /set rescuetype=1%;\
      /if (leading=0) \
	/ecko Autorescue won't work, type /leading to make it work.%;\
      /endif%;\
    /elseif (rescuetype=1) \
      /ecko Auto-Rescue II: %{htxt2}ON %{ntxt}and Type: %{htxt2}2 %{ntxt}(Rescues when new person get hitted, might spam)%; \
      /set groupRescue=1%; \
      /set rescuetype=2%;\
    /else \
      /ecko Auto-Rescue is now %{htxt2}OFF%; \
      /set groupRescue=0%; \
      /set rescuetype=0%;\
    /endif

/def leading = \
  /if (leading=1) \
    /set leading=0%;\
    /ecko Leading-Triggers are disabled.%;\
  /else \
    /set leading=1%;\
    /ecko In Leading mode. Rescue etc will work.%;\
  /endif


/set groupRescue=0
/set rescuetype=0

/def rescue = /resc %*

/def lead_command = \
    /if ({1}=/'use') \
        gtell use &+R%{-1}%;\
    /elseif ({1}=/'recall') \
        emote issues the order 'RECALL'.%;\
    /else \
        gtell %{*}%;\
    /endif

/alias , /lead_command %{*}
