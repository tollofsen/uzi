/def -mregexp -F -t'^Host   : [0-9]+.[0-9]+.[0-9]+.[0-9]+$' immortal_whois_init = \
    /set immortal_whois=1

/def -mregexp -Eimmortal_whois -F -t'^\[ ([0-9 ]+)  ([A-z\/]+)[ ]+\] ([A-z]+) [  ]+ \[[A-z\-]+ \[[A-z]\] \[[A-z ]* \(([0-9]+)\)\]( | \(private\))$' immortal_whois = \
    /set account_rep=$[account_rep + {P4}]%;\
    /if ({P5}=/ '*private*') \
        /set account_private_rep=$[account_private_rep + {P4}]%;\
    /else \
        /set account_public_rep=$[account_public_rep + {P4}]%;\
    /endif

/def -mregexp -Eimmortal_whois -F -t'^([0-9]+) characters displayed.$' immortal_whois_end = \
    /if (account_rep) \
        /eval /echo Reputation Total: %{account_rep}  Public: %{account_public_rep}  Private: %{account_private_rep}%;\
    /endif%;\
    /unset account_rep%;\
    /unset account_private_rep%;\
    /unset account_public_rep%;\
    /unset immortal_whois
