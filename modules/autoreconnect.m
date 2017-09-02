;// vim: set ft=tf
;========================
;   Autoreconnect 
;========================

/if (autoreconnect=~'') /set autoreconnect=1%;/endif

/def -ag -p2147483647 -h'CONFAIL|DISCONNECT' autoreconnect = \
  /if (autoreconnect=1) \
    /uecko Lost connection to World: %{htxt2}%1%{ntxt}. Reconnecting in 5 seconds.%;\
    /repeat -0:00:05 1 /connect %1%;\
  /else \
    /uecko Lost connection to World: %{htxt2}%1%;\
  /endif%;\
  /if (uziautosave=1) \
    /saveall q%;\
  /endif

/def -F -p2147483647 -h'SIGHUP|SIGTERM' autosaveoncrash = \
  /if (uziautosave=1) \
    /saveall q%;\
  /endif

/def -mglob -p2 -F -t'\[0\] Exit from Burning.' dontreconnect = \
  /if (autoreconnect=1) \
    /set autoreconnect=0%;\
    /repeat -0:01:00 1 /set autoreconnect=1%;\
  /endif

/def -mglob -n1 -h"PROMPT *Press return to continue*" alogin = \
  /if (autoreconnect=1) \
    /send  %;/send 1%;\
    /regag%;\
  /endif

/def -msimple -F -T"Reconnecting." reconnected = \
    affects

;/def -mglob -p2 -F -t'\[REBOOT\] Rebooting. Burning will be back up in about 60 seconds!' autosonr=\
;  /if (autoreconnect=1) \
;    /let idledays=$[ftime("%d", idle()-3600)-1]%;\
;    /let idlehour=$[ftime("%H", idle()-3600)]%;\
;    /let idlemin=$[ftime("%M", idle()-3600)]%;\
;    /let idlesec=$[ftime("%S", idle()-3600)]%;\
;    /if (idlesec>20 | idlemin>0 | idlehour>0 | idledays>0) \
;      /repeat -0:02:00 1 south%;\
;    /endif%;\
;  /endif

;;;
