; // vim: set ft=tf:
/set cop=0
/def acop = \
    /if (regmatch('^(agg|all|keep|bail|on|off)$', {1})) \
        /if ({2}=~'') \
            /let _channel=/ecko ACOP: %;\
        /else \
            /let _channel=%{-1} is now: %;\
        /endif%;\
        /if ({P1}=~'on'|{P1}=~'all') \
            /eval %{_channel} Automatically copping + keeping cops up.%;\
            toggle aggressive off%;\
            toggle autoassist off%;\
            /set autocop=1%;\
            /set acop=1%;\
            /set coptype=2%;\
            /set acopp=on%;\
            /if (gager!=1) \
                /dogag%;\
            /endif%;\
        /elseif ({P1}=~'keep'|{1}=~'bail') \
            /eval %{_channel} Keeping cops if they bail.%;\
            /set acop=1%;\
            /set autocop=0%;\
            /set coptype=3%;\
            /set acopp=bail%;\
            /if (assist=1) \
                toggle aggressive on%;\
                toggle autoassist on%;\
            /endif%;\
        /elseif ({P1}=~'agg') \
            /eval %{_channel} Automatically copping aggro rooms.%;\
            /set acop=0%;\
            /set autocop=1%;\
            togg aggressive off%;\
            togg autoassist off%;\
            /set coptype=4%;\
            /set acopp=aggro%;\
             /if (gager!=1) \
                /dogag%;\
            /endif%;\
        /elseif ({P1}=~'off') \
            /eval %{_channel} Letting someone else will do the copping.%;\
            /set acop=0%;\
            /set autocop=0%;\
            /if (assist=1) \
                togg aggressive on%;\
                togg autoassist on%;\
            /endif%;\
            /set coptype=1%;\
            /set acopp=off%;\
        /endif%;\
    /else \
        /if ({1}=~'') \
            /let _channel=/ecko%;\
        /else \
            /let _channel=%{*}%;\
        /endif%;\
        /if (coptype=4) \
            /acop off %{_channel}%;\
        /elseif (coptype=1) \
            /acop on %{_channel}%;\
        /elseif (coptype=2) \
            /acop keep %{_channel}%;\
        /else \
            /acop agg %{_channel}%;\
        /endif%;\
    /endif

