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
/def -mglob -F -p3 -t'{*} tells you \'protect *\'' tellProtect1 = \
        /let playertoprotect=$[replace('\'','',{5})]%;\
        /if (fighter>0 & playertoprotect!~char & (ismember({1}, blacklist) == 0)) \
                /if ((autoProtectV > 0 & (ismember({playertoprotect}, blacklist) == 0)) | (autoProtectV == 0 & {1}=~tank & (ismember({playertoprotect}, blacklist) == 0))) \
                        /if (ismember({playertoprotect},{gplist}) =~ 1) \
                                protect 0.playertoprotect%; \
                        /endif%; \
                /endif%; \
        /endif

