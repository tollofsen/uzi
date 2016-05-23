;;;;;;;;;;;;;;
; uzi Colors ;
;;;;;;;;;;;;;;
/set n=@{n}
/set g=@{nCgreen}
/set G=@{BCgreen}
/set e=@{nCred}
/set E=@{BCred}
/set q=@{nCblack}
/set Q=@{BCblack}
/set y=@{nCyellow}
/set Y=@{BCyellow}
/set c=@{nCcyan}
/set C=@{BCcyan}
/set b=@{nCblue}
/set B=@{BCblue}
/set m=@{nCmagenta}
/set M=@{BCmagenta}
/set w=@{nCwhite}
/set W=@{BCwhite}

/if ({pre_echo_char}=~'') /set pre_echo_char=***%;/endif
/if ({ntxt}=~'') /set ntxt=@{nCwhite}%;/endif
/if ({ntxt2}=~'') /set ntxt2=@{BCblack}%;/endif
/if ({htxt}=~'') /set htxt=@{BCred}%;/endif
/if ({htxt2}=~'') /set htxt2=@{BCyellow}%;/endif

/def ecko = \
  /eval /echo -an -p %htxt%pre_echo_char @{n}%ntxt%{*}

/def debug = \
  /if (debug=1) \
    /eval /echo -an -p %htxt2[%{htxt}debug%{htxt2}] @{n}%ntxt%*%;\
  /endif

/def uecko = \
  /eval /echo -an -p %{htxt2}[%{htxt}uzi%{htxt2}] @{n}%ntxt%{*}

;;;;
