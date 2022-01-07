;// vim: set ft=tf:


/def top10_damlog = \
    /if (damage_analyzer=1) \
        /ecko Top10 not compatible with damage analyzer.%;\
    /else \
        /unset top10_damlog_list%;\
        /set top10_channel=gtell%;\
        damlog show group%;\
    /endif

/alias top10 /top10_damlog

/def onprompt_uzi_top10 = \
    /if (top10_damlog=1) \
        /top10_sort%;\
        /top10_show 10%;\
        /set top10_damlog=0%;\
    /endif

/def top10_sort = \
    /set top10_damlog_list=$(/qsort_list %{top10_damlog_list})

/def qsort_list = \
    /if ({#} <= 1) \
        /_echo %{*} %; \
    /else \
        /if (regmatch('([A-z]+)\#([0-9]+)', {R})) \
            /let _damage=%{P2}%;\
            /let _entry=%{P0}%;\
            /let key=%{_damage} %;\
            /let same=%;\
            /let small=%;\
            /let large=%;\
            /let diff=%;\
            /while ({#}) \
                /if (regmatch('([A-z]+)\#([0-9]+)', {1})) \
                    /test diff:=intcmp({P2}, key) %;\
                    /if (!diff) \
                        /let same=%same %1 %; \
                    /elseif (diff < 0) \
                        /let small=%small %1 %; \
                    /else \
                        /let large=%large %1 %; \
                    /endif %; \
                /endif%;\
                /shift %; \
            /done %; \
            /_echo $(/qsort_list %large) %same $(/qsort_list %small) %; \
        /endif%;\
    /endif

/def -mregexp -Fp12300 -t'^Damlog$' top10_damlog_init = \
    /set top10_damlog=1%;\
    /unset top10_damlog_list%;\
    /set damlog_total=0


/def -mregexp -Etop10_damlog -Fp12300 -t'^([A-z]+)[ ]+[0-9]+[ ]+[0-9]+[ ]+[0-9]+[ ]+[0-9]+[ ]+[0-9]+[ ]+[0-9]+[ ]+([0-9]+)[ ]+[0-9]+$' top10_damlog_gather = \
    /set damlog_total=$[damlog_total + {P2}]%;\
    /top10_damlog_list_add %{P1} %{P2}


/def top10_damlog_list_add = \
    /let _name=%{1}%;\
    /let _value=%{2}%;\
    /set top10_damlog_list=%{top10_damlog_list} %{P1}#%{P2}

/def top10_show = \
    /if (top10_channel=~'gtell' | (ingroup=1 & leading=1)) \
        /let _channel=gtf emote &+yDamAvg&+Y: &+w%;\
    /else \
        /let _channel=/ecko%;\
    /endif%;\
    /if ({1}=~'') \
        /let _count=10%;\
    /else \
        /let _count=%{1}%;\
    /endif%;\
    /let _i=0%;\
    /let _list=%{top10_damlog_list}%;\
    /let _output=%;\
    /while (_list!~'' & _i<_count) \
        /test ++_i%;\
        /if (regmatch('([A-z]+)\#([0-9]+)', {_list})) \
            /let _output=%_output %{_i}. %{P1} (%{P2}) %;\
        /else \
        /endif%;\
        /if (mod(_i, 5)=0) \
            /eval %{_channel} %{_output}%;\
            /let _output=%;\
        /endif%;\
        /let _list=$(/remove %{P0} %{_list})%;\
    /done%;\
    /if (_output & _i>1) \
        /eval %{_channel} %{_output}%;\
    /endif%;\
    /set top10_channel=

/def intcmp = /test {1} - {2}
