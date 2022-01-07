;// vim: set ft=tf:

/def -mregexp -t'^[ ]+ (Earth|Air)\:([ ]+)([0-9]+)\/([0-9]+) .* (Water|Fire)\:([ ]+)([0-9]+)\/([0-9]+)' fragcount = \
    /if ({P1} =/ 'Earth') \
        /set earthfrag=%{P3}%;/set waterfrag=%{P7}%;\
        /test earthp:=((%{P3}*100)/%{P4})%;\
        /test waterp:=((%{P7}*100)/%{P8})%;\
;        /echo -a -p @{Cgreen}    Earth@{Cwhite}: %{P2} %{earthfrag}/%{P4} @{Cgreen}(@{Cyellow}%{earthp}\%@{Cgreen}) %{P6} @{Cblue}Water@{Cwhite}: %{waterfrag}/%{P8} @{Cgreen}(@{Cyellow}%{waterp}\%@{Cgreen})%;\
    /elseif ({P1} =/ 'Air') \
        /set airfrag=%{P3}%;/set firefrag=%{P7}%;\
        /test airp:=((%{P3}*100)/%{P4})%;\
        /test firep:=((%{P7}*100)/%{P8})%;\
;        /echo -a -p @{Ccyan}      Air@{Cwhite}: %{P2} %{airfrag}/%{P4} @{Cgreen}(@{Cyellow}%{airp}\%@{Cgreen}) %{P6}  @{Cred}Fire@{Cwhite}: %{firefrag}/%{P8} @{Cgreen}(@{Cyellow}%{firep}\%@{Cgreen})%;\
    /endif
/alias fs /fragstate %{*}
/def fragstate = \
    /if ({1}=~'') \
        /echo -ah -p @{Cwhite}************  @{Cyellow}Frag Log @{Cwhite} ****************%;\
        /echo -ah -p @{Cwhite}*** \
        @{Cgreen}Earth@{Cwhite}: %{earthp}\% \
        @{Cblue}Water@{Cwhite}: %{waterp}\% \
        @{Ccyan}Air@{Cwhite}: %{airp}\% \
        @{Cred}Fire@{Cwhite}: %{firep}\%%;\
    /else \
        /send %{*} &+gEarth&+w: &+y%{earthp}&+w\% \
        &+bWater&+w: &+y%{waterp}&+w\% \
        &+cAir&+w: &+y%{airp}&+w\% \
        &+rFire&+w: &+y%{firep}&+w\%%; \
    /endif
