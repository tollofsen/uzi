;;;;; Just some list over diff things.

;temp vars (won't affect saved chars)
/set container=knapsack
/set food=bread
/set foodcont=knapsack
/set watercont=barrel
/set abouteq=sinister
/set feeteq=boots
/set shieldeq=shield
/set heldeq=overlord
/set weapon=dirk
/set normslay=dirk


;uptime
/test tf_start_time := (tf_start_time | time())

/def uptime =\
  /let seconds=$[time() - tf_start_time]%;\
  /if ({1}=~'') \
    /ecko Current uptime%{ntxt2}: \
       %{htxt2}$[seconds/86400] %{ntxt}days \
       %{htxt2}$[mod(seconds/3600,24)] %{ntxt}hours \
       %{htxt2}$[mod(seconds/60,60)] %{ntxt}mins \
       %{htxt2}$[mod(seconds,60)] %{ntxt}secs.%;\
  /else \
     %{*} TinyFugue have been running for \
       $[seconds/86400] days \
       $[mod(seconds/3600,24)] hours \
       $[mod(seconds/60,60)] mins \
       $[mod(seconds,60)] secs.%;\
  /endif

;xterm

/eval /xtitle BurningMUD
