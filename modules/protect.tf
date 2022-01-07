; // vim: set ft=tf:

;=================================================================================
;   Protect on tells triggers with whitelist and blacklist
;   3 settings : -1 off : 0 Tank can use : 1 Everyone can use unless blacklist
;================================================================================
;set default
/set autoProtectV 0%;\

;Alias to show and set status on protect trigger
/alias autoprotect \
    /if ({*} =~ '1' | {*} =~ 'on') \
        /ecko Ok. Everyone can use protect trigger.%; \
        /set autoProtectV 1%; \
    /elseif ({*} =~ '-1' | {*} =~ 'off') \
        /ecko Ok. Protect trigger is OFF.%; \
        /set autoProtectV -1%; \
    /elseif ({*} =~ '0') \
        /ecko Ok. Only leader can use protect trigger.%; \
        /set autoProtectV 0%; \
    /else \
        /ecko tellProtect  -1/0/1? (off/tank/all)%; \
        /if (autoProtectV == -1) \
            /ecko Not protecting anyone!%; \
        /elseif (autoProtectV == 0) \
            /ecko Only leader can use protect trigger!%; \
        /elseif (autoProtectV == 1) \
            /ecko Everyone can use protect trigger!%; \
        /endif%; \
    /endif

;Trigger for protect person telling protect with blacklist
/def -mglob -p3 -F -t'{*} tells you \'protect\'' tellProtect = \
    /if (fighter>0) \
        /if ((autoProtectV > 0 & (ismember({1}, blacklist) == 0)) | (autoProtectV == 0 & {1}=~tank)) \
            /if (ismember({1},{gplist}) =~ 1) \
                protect 0.%1%;\
            /endif%; \
        /endif%; \
    /endif

;Trigger for protect other person on tell with blacklist
/def -mregexp -F -p3 -t'^([A-z]+) tells you \'protect ([A-z]+)\'' tellProtect1 = \
    /if ({P2}=~'me') \
        /let playertoprotect=$[replace('\'','',{P1})]%;\
    /else \
        /let playertoprotect=$[replace('\'','',{P2})]%;\
    /endif%;\
    /if (fighter>0 & playertoprotect!~char & (ismember({P1}, blacklist) == 0)) \
        /if ((autoProtectV > 0 & (ismember({playertoprotect}, blacklist) == 0)) | (autoProtectV == 0 & {1}=~tank & (ismember({playertoprotect}, blacklist) == 0))) \
            /if (ismember({playertoprotect},{gplist}) =~ 1) \
                protect 0.%{playertoprotect}%; \
            /endif%; \
        /endif%; \
    /elseif (fighter>0 & (playertoprotect=~char|playertoprotect=~'self') & {P1}=~tank) \
        protect self%;\
    /endif

/def -mregexp -F -p3 -t'^You now protect ([A-z]+).$' uzi_protect_protectee = \
    /set protectee=%{P1}

/def -mregexp -F -p3 -t'^You stop protecting ([A-z]+).$' uzi_protect_unset_protectee = \
    /set protectee=
