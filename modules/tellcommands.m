; // vim: set ft=tf:

;;;;
/def -mregexp -p5 -F -t'^([A-z]+) tells the group, \':area spells' tellarea = \
    /if (ismember({P1}, super_whitelist)>0) \
        /areas%;\
    /endif

/def -mregexp -p5 -F -t'^([A-z]+) tells the group, \'(:|)single spells' tellsingle = \
    /singles


/def -mregexp -F -t"^([A-z]+) (tells you|tells the group,|issues the order) '(.*)'$" uzi_tellcommands_main = \
    /if ({P2}=~'tells you') \
        /let _channel=tell%;\
        /let _response=tf %{P1} emote%;\
    /elseif ({P2}=~'tells the group,') \
        /let _channel=gtell%;\
        /let _response=gtf emote%;\
    /endif%;\
    /let _issuer=%{P1}%;\
    /if ({P1}=~tank) \
        /let _tell_tank=1%;\
    /endif%;\
    /if (ismember({P1}, gplist)>0) \
        /let _tell_group=1%;\
    /endif%;\
    /let _tell_command=%{P3}%;\
    /if (regmatch('^buy corpse$', _tell_command)) \
        /uzi_autocr_buy%;\
    /elseif (regmatch('^gheal (on|off)$', _tell_command) & priest=2 & _tell_tank=1) \
        /uzi_autoheal_ghealblind %{P1} %{_response}%;\
    /elseif (regmatch('^aheal (on|off)$', _tell_command) & (animist>1|priest>0|templar>1) & _tell_tank=1) \
        /uzi_autoheal_toggler %{P1} %{_response}%;\
    /elseif (regmatch('^unsneak$', _tell_command) & _tell_tank=1 & (rogue>0|nightblade>0)) \
        unsneak%;\
    /elseif (regmatch('^kill ([A-z]+)$', _tell_command) & _tell_tank=1 & ingroup=1 & assist=1) \
        /if (nightblade>0) \
            m %{P1}%;\
        /elseif (rogue>0) \
            ba %{P1}%;\
        /else \
            k %{P1}%;\
        /endif%;\
    /elseif (regmatch('^summon ([A-z]+)$', _tell_command)) \
        /if ({P1}=~'me') \
            /uzi_summon_action %{_issuer} %{_issuer} %{_channel}%;\
        /else \
            /uzi_summon_action %{P1} %{_issuer} %{_channel}%;\
        /endif%;\
    /elseif (regmatch('^summon$', _tell_command)) \
        /uzi_summon_action %{_issuer} %{_issuer} %{_channel}%;\
    /elseif (regmatch('^squeue$', _tell_command)) \
        /uzi_summon_squeue %{_issuer}%;\
    /elseif (regmatch('^wellsubs$', _tell_command) & _tell_tank=1) \
        /uzi_wellsubs_toggle %{_channel}%;\
    /endif
