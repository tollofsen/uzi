; // vim: set ft=tf:


/def uzi_resc_toggle = \
    /if (fighter>0 & ingroup=1) \
        /if (regmatch('^on', {1})) \
            /set groupRescue=1%;\
        /elseif (regmatch('^off', {1})) \
            /set groupRescue=0%;\
        /elseif (groupRescue=1) \
            /set groupRescue=0%;\
        /elseif (groupRescue=0) \
            /set groupRescue=1%;\
        /endif%;\
        /if (groupRescue=1) \
            gtf emote will now come to his group members rescue!%;\
        /else \
            gtf emote will let his group members fend for themselves!%;\
        /endif%;\
    /endif
;======================================
;   Misc Tank Triggs
;======================================

/alias rescue \
    /if (norescue=~'') \
        /send rescue%;\
    /else \
        /send rescue %{*}%;\
    /endif

/def -mregexp -t'^([A-z]+) starts following you.$' groupfollower = \
  /if (leading=1|guallidurth_move_group>0) \
    group all%;\
  /endif%;\
  /if ({P1}=~tank) \
    disband %{P1}%;\
    follow %{P1}%;\
  /endif

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
        /tryrescue %_old_tryresc%;\
    /endif


;======================================
;   Autorescue Triggers
;======================================

/def -p2 -F -mregexp -t'(misses|notices|thinks that|tickles|pierces|pounds|crushes|slashes|whips|massacres|obliterates|annihilates|vaporizes\
    |pulverizes|atomizes|ultraslays|\*\*\*ULTRASLAYS\*\*\*|\*\*\*U\*L\*T\*R\*A\*S\*L\*A\*Y\*\S\*\*\*|\*\*\*SPANKS\*\*\*) ([^ ]*)' rescue2 = \
    /tryrescue %{P2}

/def -p2 -F -mregexp -t'(blindly and attacks|is here\, fighting) ([^\.]*)' rescue3 = \
    /tryrescue %{P2}

/def -p2 -mregexp -t'\'([^,]*), I will get you' rescue4 = \
    /tryrescue %{P1}

/def -p2 -F -mregexp -t'rushes to attack ([^\!]*)' rescue5 = \
    /tryrescue %{P1}

/def -mglob -t'*You fail the rescue*' rescue6 = \
    /if (lastresc=~char) \
        rescue %{lastresc2}%;\
    /else \
        rescue %{lastresc}%;\
    /endif

/def -p30 -mregexp -t'Banzai\! To the rescue\...' rescue7 = \
    /set lastresc=%char

/def -p2 -mregexp -t'thinks that ([^\.]*) deserves punishment.' rescue8 = \
    /tryrescue %{P1}

/def -p2 -F -mregexp -t'^Who do you want to rescue' deadtrigg = \
    /set lastresc=%char

/def -p2 -F -msimple -t'You take a quick glance around you, but find no-one in need of help.' norescuetrigg = \
    /set lasresc=%char

/def -mglob -t'{*} is now a member of your group.' addgrp = \
    /set gplist=%{gplist} %{1}

;======================================
;   Autorescue Functions
;======================================

/def onpromptrescue = \
    /if (groupRescue=1) \
        /if ({1}!~char & lastresc!~char) \
            /autorescue%;\
            /set lastresc2=%lastresc%;\
            /set lastresc=%char%;\
        /endif%;\
    /endif

/def tryrescue = \
    /if (ismember({1},{norescue}) = 0) \
        /if (groupRescue=1 & ismember({1}, gplist) = 1) \
            /if ({1}!~char) \
                /set lastresc=%{1}%; \
            /endif%;\
        /endif%;\
    /endif

/def autorescue = \
    /if (lastresc!~char) \
;        rescue%;\
        rescue %{lastresc}%; \
    /endif

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
    /if (groupRescue=0) \
        /ecko Auto-Rescue: %{htxt2}ON%; \
        /set groupRescue=1%; \
    /else \
        /ecko Auto-Rescue is now %{htxt2}OFF%; \
        /set groupRescue=0%; \
    /endif

/def leading = \
    /if (leading=1) \
        /set leading=0%;\
        /ecko Leading-Triggers are disabled.%;\
    /else \
        /set leading=1%;\
        /ecko In Leading mode. Rescue etc will work.%;\
    /endif


/if (groupRescue<1) \
    /set groupRescue=0%;\
/endif

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
