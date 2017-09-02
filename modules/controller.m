; // vim: set ft=tf:
;;;;;;;; Script for autoloding more script. (More machinelag!)

/lood modules/values.m
/lood modules/functions.m

; Who are we?
/def -p2147483647 -n1 -mregexp -t'Saving ([^\.]+).' GettingCharInfo01 = \
    /set char=%{P1}%;\
    /set tank=-%;\
    /eval /xtitle %{char}@BurningMUD [uzi %{uziversion}]%;\
    /lood modules/fixdefault.m%;\
    /file_exists %{uzidirectory}/saves/%{char}.sav%;\
    /if (file_exists == 1) \
        /lood saves/%{char}.sav%;\
        /lood modules/convertvalues.m%;\
        /purge GettingCharInfo02%;\
        /purge GettingCharInfo03%;\
        /purge GettingCharInfo04%;\
        /purge UhmGetCharInfo%;\
        /lood modules/loads.m%;\
        /lood saves/global.sav%;\
    /else \
        /set welcomemsg=There are no saved settings for the character %{htxt}%{char}%{ntxt}, I will now try to automatically fix default values for your class.%;\
        /unset welcomemsg%;\
        /send finger self%;\
    /endif

; Some test cases... the triggers must with with all of these cases:
; [ 1/50  Pr/Ro] Awesome the Peon [Dwa] [neutral] [Petty Purse-snatcher] (Male)
; [20/50  Ma/Te] Cyan Garamonde. [Hum] [good] [Humble Page] (Male)
; [52/52  Ma/Pr] Utility exp [Dwa] [neutral] [Silent Monk] (It)
; [65/65  Ma/Fi] Raptor Jesus Incarnate the Lord of the Realm [Ktv] [evil] [Dark Champion] (Male)
; [100/100  Pr/Pr] Syden the Lord of the Realm [Ktv] [neutral] [Master of Protection] (Male)

/def -p2147483646 -mregexp -t'^\[[ 0-9]+\/[0-9]+[ ]+([^\/]+)\/([A-z]+)\]' GettingCharInfo02 = \
    /let charclassI=%{P2}%;\
    /let charclassII=$[replace(" ", "", %{P1})]%;\
    /if (regmatch({char}, {*})) \
        /GettingCharClass %{charclassI}%;\
        /GettingCharClass %{charclassII}%;\
        /set charclass=%{charclassII}/%{charclassI}%;\
        /lood modules/loads.m%;\
        /autodefineautoass%;\
        /set welcomemsg2=You should run the new %{htxt2}/menu %{ntxt}command to fix all settings! ;)%;\
        /set welcomemsg3=Print %{htxt2}/uhelp %{ntxt}anytime to get a list of commands and short help. Since this script needs a %{htxt2}special prompt%{ntxt} on burning you can type '%{htxt2}newprompt%{ntxt}' to get it!%;\
        /set newprt display \\\%\r\\\%\h\(\\\%H\)H \\\%\p(\\\%\P)M \\\%\m(\\\%\M)V > \\\%\L%;\
        /not /alias newprompt /not \\\%newprt%;\
        /purge GettingCharInfo02%;\
        /purge GettingCharInfo03%;\
        /purge GettingCharInfo04%;\
        /purge GettingCharClass%;\
        /purge UhmGetCharInfo%;\
        /repeat -0:00:01 1 /welcomemsg%;\
    /endif

; Singleclassed

/def -p2147483647 -mregexp -t'\[[ 0-9]+[ ]+([A-z]+)[ ]+\]' GettingCharInfo03 = \
    /let charclassI=%{P1}%;\
    /if (regmatch({char}, {*})) \
        /GettingCharClass %{charclassI}%;\
        /set charclass=%{charclassI}%;\
        /lood modules/loads.m%;\
        /autodefineautoass%;\
        /set welcomemsg2=Since you are SINGLE classed, and not 50/50 this script won't run perfectly until you are lvl 50/50! (btw, when you multiclass, you need to tell the script you're a new class or pure classed. Do this with the command %{htxt2}/config c te/ro%{ntxt2}.)%;\
        /set welcomemsg3=Print %{htxt2}/uhelp %{ntxt}for some help, and %{htxt2}/menu %{ntxt}to change settings. Since this script needs a %{htxt2}special prompt%{ntxt} on burning you can type '%{htxt2}newprompt%{ntxt}' to get it!%;\
        /set newprt display \\\%\r\\\%\h\(\\\%H\)H \\\%\p(\\\%\P)M \\\%\m(\\\%\M)V > \\\%\L%;\
        /not /alias newprompt /not \\\%newprt%;\
        /purge GettingCharInfo02%;\
        /purge GettingCharInfo03%;\
        /purge GettingCharInfo04%;\
        /purge GettingCharClass%;\
        /purge UhmGetCharInfo%;\
        /repeat -0:00:01 1 /welcomemsg%;\
    /endif

/def -p2147483647 -mregexp -t'\[[0-9]+[ ]+([A-z]+)\]' GettingCharInfo04 = \
    /if (regmatch({char}, {*})) \
        /lood modules/loads.m%;\
        /set welcomemsg2=Since you are SINGLE classed, and not 50/50 this script won't run perfectly until you are lvl 50/50! (btw, when you multiclass, you need to tell the script you're a new class or pure classed. Do this with the command %{htxt2}/config c te/ro%{ntxt2}.)%;\
        /set welcomemsg3=Print %{htxt2}/uhelp %{ntxt}for some help, and %{htxt2}/menu %{ntxt}to change settings. Since this script needs a %{htxt2}special prompt%{ntxt} on burning you can type '%{htxt2}newprompt%{ntxt}' to get it!%;\
        /not /alias newprompt /not \\\%newprt%;\
        /purge GettingCharInfo02%;\
        /purge GettingCharInfo03%;\
        /purge GettingCharInfo04%;\
        /purge GettingCharClass%;\
        /purge UhmGetCharInfo%;\
        /repeat -0:00:01 1 /welcomemsg%;\
    /endif


/set animist=0
/set fighter=0
/set magician=0
/set nightblade=0
/set priest=0
/set rogue=0
/set warlock=0
/set templar=0

/def GettingCharClass = \
    /if ({1} =/ 'an') \
        /set animist=$[{animist}+1]%;\
    /elseif ({1} =/ 'fi') \
        /set fighter=$[{fighter}+1]%;\
    /elseif ({1} =/ 'ma') \
        /set magician=$[{magician}+1]%;\
    /elseif ({1} =/ 'nb') \
        /set nightblade=$[{nightblade}+1]%;\
    /elseif ({1} =/ 'te') \
        /set templar=$[{templar}+1]%;\
    /elseif ({1} =/ 'pr') \
        /set priest=$[{priest}+1]%;\
    /elseif ({1} =/ 'ro') \
        /set rogue=$[{rogue}+1]%;\
    /elseif ({1} =/ 'wl') \
        /set warlock=$[{warlock}+1]%;\
    /else \
        /ecko Error: Illegal Class: %htxt2%{1}%ntxt. (Bug in the script >;>).%;\
    /endif

;;;;;;; 
;Select a character:

/edit -p99999 ~login_hook_lp

/def -ip2147483647 -T'diku.uzi' -hLOGIN uzi_login = \
    /if (world_info("character") =/ 'old') \
        /send old%;\
        /send $[world_info("name")]%;\
        /send $[world_info("password")]%;\
    /else \
        /send $[world_info("character")]%;\
        /send $[world_info("password")]%;\
        /send $[world_info("name")]%;\
    /endif

/def -mglob -h"PROMPT *Press return to continue*" definesendsaveonprmpt = \
    /send  %;\
    /send 1%;\
    /repeat -0:00:20 1 /regag



/def -mglob -p99999 -t'Reconnecting.' UhmGetCharInfo = \
    /repeat -0:00:01 1 save
;    /repeat -0:00:01 1 /ecko   ...type %{htxt}SAVE %{ntxt}if you want Uzi to Kick in!%;\
;    /repeat -0:00:01 1 /ecko Uzi will not try to autoload anything at the moment... (Cause it looks like you just reconnected... can cause deaths.)

/def -mglob -p9 -t'Welcome to the land of Burning! May your visit here be... Interesting.' welcometoburning = \
    /send save%;\
    /if (playing=1 & death<1) \
        toggle play%;\
        south%;\
    /endif%;\
    /set death=0

/def welcomemsg = \
    /sstate%;\
    /d normal%;\
    /let _wrapsize=%{wrapsize}%;\
    /let _wrapspace=%{wrapspace}%;\
    /set wrapsize=55%;\
    /set wrapspace=5%;\
    /eval /echo -a -p %{ntxt}     %{welcomemsg}   %{welcomemsg2}   %{welcomemsg3}%;\
    /set wrapsize=%_wrapsize%;\
    /set wrapspace=%_wrapspace%;\
    /purge welcomemsg

/set uziversion=1.9
/set subversion=1
/def uziver = \
    /return %uziversion

/eval /cd %{uzidirectory}
/quote -S /set gitcommit=!git rev-parse --short HEAD
/eval /cd %{PWD}
;;;;;;;;;;Don't change these please ;)
