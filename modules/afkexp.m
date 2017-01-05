; // vim: set ft=tf:

/if (autoJoinV=1) /set afkexp=1%;/unset autoJoinV%;/endif

/def afkexp = \
    /if ({1} =~ 'on') \
        /set afkexp=1%;\
        /ecko Autojoining exp!%;\
    /elseif ({1} =~ 'off') \
        /set afkexp=0%;\    
        /ecko No longer autojoining exp!%;\
    /else \
        /if (afkexp) \
            /afkexp off%;\
        /else \
            /afkexp on%;\
        /endif%;\
    /endif
/alias afkexp /afkexp %{1}


/def afkwell = \
    /if ({1} =~ 'on') \
        /set afkwell=1%;\
        /ecko Autojoining well groups!%;\
    /elseif ({1} =~ 'off') \
        /set afkwell=0%;\    
        /ecko No longer autojoining well groups!%;\
    /else \
        /if (afkwell) \
            /afkwell off%;\
        /else \
            /afkwell on%;\
        /endif%;\
    /endif
/alias afkwell /afkwell %{1}


/def uzi_autojoin_afkexp = \
    /if ((afkexp > 0 & (ismember({1}, blacklist) == 0)) | (afkexp == 0 & (ismember({1}, whitelist) == 1))) \
        follow %{1}%; \
    /endif

/def uzi_autojoin_afkwell = \
    /if ((afkwell > 0 & (ismember{1}, blacklist) == 0) | (afkwell == 0 & (ismember({1}, whitelist))) \
        follow %{1}%;\
    /endif
