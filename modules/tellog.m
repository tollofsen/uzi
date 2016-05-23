;===============================
; T e l l o g
;===============================

/if (beepontell=~'') /set beepontell=1%;/endif
/if (tellogger=~'') /set tellogger=1%;/endif
/if (icquin=~'') /set icquin=Unknown%;/endif
/if (pageicq=~'') /set pageicq=0%;/endif
/if (afkteller=~'') /set afkteller=1%;/endif
/if (afkmsg=~'') /set afkmsg=I'm currently &+RAFK&+g, try later.%;/endif
/if (showtellrows=~'') /set showtellrows=20%;/endif
/set tellswhileafk=0

/alias afk /if (isafk=0) /set isafk=1%;/ecko You are set afk: %*%;/set afkmsg=%*%;/else /set isafk=0%;/ecko You are now AK. Great! :)%;/endif

;Gagger for Whois
/def -p2147483646 -mglob -t'Whois tells you*' clientgagWhois

;===============================
; F u n c t i o n s
;===============================

/def -p99 -F -hMAIL mail_check = /set newmails=$[nmail()]%;/set status_redraw=1

/def logtell = \
  /if (beepontell=1) \
    /beep%;\
  /endif%;\
  /if (tellogger=1) \
    /set ttell=%{*}%;\
    /set tdate=$[ftime("%a %b %d", time())]%;\
    /set ttime=$[ftime("%H:%M:%S", time())]%;\
    /if (tdate!/tempdate) \
      /test fwrite("%{uzidirectory}/logs/%{char}.tells","=-=-=-=-=-=-=-=-= %{tdate} =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=")%;/set tempdate=%{tdate}%;\
    /endif%;\
    /test fwrite("%{uzidirectory}/logs/%{char}.tells" , "\[%{ttime}\] %{ttell}")%;\
    /let idlesec=$[ftime("%S", idle()-3600)]%;\
  /endif%;\
  /if (idlesec>10) \
    /set tellswhileafk=$[tellswhileafk+1]%;\
    /set status_redraw=1%;\
  /endif

/def scan4char = \
  /let temptell=%{*}%;\
  /let tempchar=$[strcat(tolower({char}))]%;\
  \
  /if (regmatch(tolower({char}),tolower({*}))) \
    /logtell $[replace('"', '\"', {*})]%;\
  /endif

/def tells = \
  /set status_redraw=1%;\
  /let _wrapspace=%{wrapspace}%;\
  /set wrapspace=15%;\
  /eval /echo -a -p %htxt=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- %htxt2\Uzi Tell Logs %htxt(%htxt2\Last%htxt\:%htxt2\%{showtellrows}%htxt) %htxt\-=-=-=-=-=-=%;\
  /quote -S /tellparser !tail -%{showtellrows} %{uzidirectory}/logs/%{char}.tells%;\
  /eval /echo -a -p %htxt=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%;\
  /set wrapspace=%{_wrapspace}%;/set tellswhileafk=0

/def tellparser = \
    /if ({1}=/'=-=-=-=-=-=-=-=-=') \
      /let tellparse1=%{htxt}%{1}%;\
      /let tellparse2=%{htxt2}%{2} %{3} %{4}%;\
      /let tellparse3=%{htxt}%{-4}%;\
    /else \
      /let tellparse1=%{ntxt2} %{1}%;\
      /let tellparse2=%{ntxt} %{2} %{3} %{4}%;\
      /let tellparse3=%{ntxt}%{-4}%;\
    /endif%;\
    /echo -a -p %tellparse1 %tellparse2 %tellparse3

/def rtells = \
 /ecko Are you sure you want to remove %htxt2%{char}%ntxt\'s tell-logs... %htxt[%htxt2\Y%htxt\/%htxt2\N%htxt]%ntxt\!?%;\
 /alias Y /quote -S /echo !rm logs/%{char}.tells\%;/ecko Ok, telllogs %htxt2\deleted%ntxt\.\%;/unalias Y\%;/unalias N\%;/set tempdate=0%;\
 /alias N /ecko As you wish, keeping all tells.\%;/unalias Y\%;/unalias N


;===================================
;   T r i g g e r s
;===================================
/set godlist2=Acheron Torain Raygar Stile Murfat Arcane Arbogastes Invil Metatron Bane Klaaw Sachy Andrax Smyger Beerwulf Gea Jess Thot Dharynn Lorgalis

/def -mregexp -F -p1 -t'^[A-z]+ tells the group, \'([^$]*)\'$' tellog = \
  /set ttell=%{P1}%;/scan4char %{*}

/set tellgagwords=mhp thp ghp gphp summon peek acop copon copoff gimp aholy kill :heal
/def -mregexp -F -p1 -t'^[A-z]+ tells you \'.*\'' tellog2 = \
  /ismember $[tolower(replace("'", "", {4}))] %{tellgagwords}%;\
  /if (inlist=0) \
    /logtell $[replace('"', '\"', {*})]%;\
    /ismember %{1} %{godlist2}%;\
    /if ((inlist=1)&(pageicq=1)) \
      /quote -S /echo !echo %{*} | mail -s BurningMUD %{icquin}@pager.mirabilis.com%;\
    /else \
      /let idledays=$[ftime("%d", idle()-3600)-1]%;\
      /let idlehour=$[ftime("%H", idle()-3600)]%;\
      /let idlemin=$[ftime("%M", idle()-3600)]%;\
      /let idlesec=$[ftime("%S", idle()-3600)]%;\
      /if (afkteller=1 & isafk=1 & (idlesec>20 | idlemin>0 | idlehour>0 | idledays>0)) \
        /if (tellogger=1) \
          /let telllogger=ON%;\
        /else \
          /let telllogger=OFF%;\
        /endif%;\
        tf %{1} emote is away: &+g%afkmsg&+L  &+L....&+G(&+gIdle&+L:\
            &+g%idledays&+Ld&+g%idlehour&+Lh&+g%idlemin&+Lm&+g%idlesec&+Ls \
            &+L..&+gLogger&+L:&+g%telllogger&+G) Uzi $(/uziver)%;\
      /endif%;\
    /endif%;\
  /endif

/def -mregexp -F -p1 -t'^[A-z]+ gossips, \'([^$]*)\'$' tellog3 = \
  /set ttell=%{P1}%;/scan4char %{*}

/set allowbeep=1
/def -F -mregexp -p8 -t'^[A-Za-z]+ tells you \'(BEEP|beep|Beep)\'' someonebeeped = \
  /if (allowbeep=1) \
    /beep%;\
    /repeat -0:00:01 1 /beep%;\
    /repeat -0:00:02 1 /beep%;\
    /set allowbeep=0%;\
    /repeat -0:01:10 1 /set allowbeep=1%;\
    tell %{1} Beep emitted, hopefully I'm not too far away and will be back to u shortly.%;\
    /if (pageicq=1) \
      /quote -S /echo !echo %{1} just beeped you. | mail -s BurningMUD %{icquin}@pager.mirabilis.com%;\
    /endif%;\
  /endif


;Your last 2 tells were:
;Your last tell was:

/def -mglob -t'{Your last * tells were\:|Your last tell was\:|You tell}*' triggonlasttell = \
  /set status_redraw=1%;\
  /set tellswhileafk=0
