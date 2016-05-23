
;==========================================================================
;   Trigger for joining exp groups while afk
;   3 settings : -1 off : 0 follow whitelist : 1 follow unless blacklist
;==========================================================================

;Alias to set and show status on autojoin
/alias autojoin \
    /if ({*} =~ '1' | {*} =~ 'on') \
      /ecko Ok. AutoJoin exp is ON.%; \
      /set autoJoinV 1%; \
    /elseif ({*} =~ '-1' | {*} =~ 'off') \
      /ecko Ok. AutoJoin exp is OFF.%; \
      /set autoJoinV -1%; \
    /elseif ({*} =~ '0') \
      /ecko Ok. Only AutoJoining safe exp.%; \
      /set autoJoinV 0%; \
    /else \
      /ecko autojoin -1/0/1? (off/whitelist/on)%; \
      /if (autoJoinV == -1) \
        /ecko Not autojoining any exp!%; \
      /elseif (autoJoinV == 0) \
        /ecko Only autojoining safe exp!%; \
      /elseif (autoJoinV == 1) \
        /ecko Joining any exp unless blacklisted!%; \
      /endif%; \
   /endif
/def autojoin = autojoin %1


;Follow on tell with blacklist and whitelist
/def -F -mregexp -t"^([A-z]+) tells you 'exp'$" autoJoinExp = \
    /if ((autoJoinV > 0 & (ismember({P1}, blacklist) == 0)) | (autoJoinV == 0 & (ismember({P1}, whitelist) == 1))) \
      delay 2 fol %{P1}%; \
    /endif
