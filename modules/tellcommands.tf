; // vim: set ft=tf:

;;;;
/def -mregexp -p5 -F -t'^([A-z]+) tells the group, \':area spells' tellarea = \
    /if ({P1}=/tank) \
        /areas%;\
    /endif

/def -mregexp -p5 -F -t'^([A-z]+) tells the group, \'(:|)single spells' tellsingle = \
    /singles

/def -mregexp -p5 -F -t'^([A-z]+) tells the group, \':wild magic' tellwild = \
    /if ({P1}=/tank) \
        /set wildmagic=2%;\
    /endif

/def -mregexp -Fp1 -t"^([A-z]+) (tells you|tells the group,|issues the order) '(.*)'$" uzi_tellcommands_main = \
    /if ({P2}=~'tells you') \
        /let _channel=tell%;\
        /let _response=tf %{P1} emote%;\
        /let _full_tell=%{*}%;\
    /elseif ({P2}=~'tells the group,') \
        /let _channel=gtell%;\
        /let _response=gtf emote%;\
  /let _full_tell=%{*}%;\
    /endif%;\
    /let _issuer=%{P1}%;\
    /if (({P1}=~tank)|({P1}=~'someone')) \
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
    /elseif (regmatch('^aheal$', _tell_command) & (animist>1|priest>0|templar>1) & _tell_tank=1) \
        /if (autoheal=1) \
            /uzi_autoheal_toggler off %{_response}%;\
        /else \
            /uzi_autoheal_toggler on %{_response}%;\
        /endif%;\
    /elseif (regmatch('^assist (on|off)$', _tell_command) & _tell_tank=1)) \
        /as %{P1}%;\
    /elseif (regmatch('^assist$', _tell_command) & _tell_tank=1)) \
        /as%;\
    /elseif (regmatch('^damage (on|off)$', _tell_command) & _tell_tank=1)) \
        /fight %{P1}%;\
    /elseif (regmatch('^damage$', _tell_command) & _tell_tank=1)) \
        /fight%;\
    /elseif (regmatch('^unsneak$', _tell_command) & _tell_tank=1 & (rogue>0|nightblade>0)) \
        unsneak%;\
    /elseif (regmatch('^kill (.*)$', _tell_command) & _tell_tank=1 & ingroup=1 & assist=1) \
        /if (nightblade>0) \
            a %{P1}%;\
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
    /elseif (regmatch('^exp$', _tell_command) & _channel=~'tell') \
        /uzi_autojoin_afkexp %{_issuer}%;\
    /elseif (regmatch('^well$', _tell_command) & _channel=~'tell') \
        /uzi_autojoin_afkwell %{_issuer}%;\
    /elseif (regmatch('^disband$', _tell_command)) \
        disband %{_issuer}%;\
        follow %{_issuer}%;\
    /elseif (regmatch('^disband ([A-z]+)$', _tell_command)) \
        disband %{P1}%;\
        follow %{P1}%;\
    /elseif (regmatch('^disband ([A-z]+)$', _tell_command) & {P1}=~{_issuer}) \
        disband %{_issuer}%;\
        follow %{_issuer}%;\
    /elseif (regmatch('^(rest|stand|sleep|wake|sit)$', _tell_command) & _tell_tank=1) \
        /if (({P1}=~'sleep') & (acop=1) & well_waterroom<1) \
            rest%;\
        /elseif ({P1}=~'wake' & (position=~'rest'|position=~'sit')) \
            stand%;\
        /elseif (({P1}=~'sleep'|{P1}=~'rest'|{P1}=~'sit') & well_waterroom>0) \
            say I've got no plans on getting my ass wet in this room!%;\
        /else \
            %{P1}%;\
        /endif%;\
    /elseif (regmatch('^arescue', _tell_command) & _tell_tank=1 & fighter>0) \
        /if (regmatch('^arescue (on|off)', _tell_command)) \
            /uzi_resc_toggle %{P1} %{_channel}%;\
        /else \
            /uzi_resc_toggle %{_channel}%;\
        /endif%;\
    /elseif (regmatch('^locate (.*)$', _tell_command) & magician>0) \
        /uzi_locate %{_issuer} %{P1}%;\
    /elseif (regmatch('^acop$', _tell_command) & _tell_tank=1 & magician>0) \
        /acop %{_response}%;\
    /elseif (regmatch('^acop (on|agg|keep|bail|off|full)', _tell_command) & _tell_tank=1 & magician>0) \
        /acop %{P1} %{_response}%;\
    /elseif (regmatch('^popcheck ([A-z]+)', _tell_command) & priest>0) \
        /uzi_popcheck %{P1} %{_issuer}%;\
    /elseif (regmatch('^invoke ([A-z]+)', _tell_command)) \
        /uzi_well_invoke %{P1}%;\
    /elseif (regmatch('^invoke$', _tell_command)) \
        /uzi_well_invoke orb%;\
    /elseif (regmatch('^:quaff mixture', _tell_command) & ismember(_issuer, userlist)) \
        quaff mixture%;\
    /elseif (regmatch('^merge', _tell_command) & _tell_tank=1 & nightblade>0) \
        merge%;\
    /elseif (regmatch('^touch ([A-z]+)$', _tell_command) & _tell_tank=1) \
        touch %{P1}%;\
    /elseif (regmatch('^open ([A-z]+)$', _tell_command) & _tell_tank=1) \
        open %{P1}%;\
    /elseif (regmatch('^:pgmode (on|off)', _tell_command) & _tell_tank=1) \
        /pgmode %{P1}%;\
    /elseif (regmatch('top10', _tell_command) & _channel=~'gtell') \
        /top10_damlog%;\
    /elseif (regmatch('^(toggle|togg|tog) play', _tell_command) & _channel=~'tell') \
      toggle play%;\
    /elseif (regmatch('^use (.*)$', _tell_command) & _channel=~'gtell' & _tell_tank=1) \
      /leadercweap %{P1}%;\
    /elseif (regmatch('^horgar$', _tell_command) & _channel=~'gtell' & _tell_tank=1) \
      /weapon horgar%;\
    /elseif (regmatch('^peek (n|e|s|w|u|d)', _tell_command)) \
      /if (peek_peeking<1) \
        /if (_channel=~'tell') \
          /peek %{P1} tell %{_issuer}%;\
        /elseif (_channel=~'gtell') \
          /peek %{P1}%;\
        /endif%;\
      /endif%;\
    /elseif (regmatch('^peek $', _tell_command)) \
    /elseif (regmatch('^track ([A-z]+)$', _tell_command) & _tell_tank) \
      /if (_channel=~'tell') \
        /track %{P1} t %{tank}%;\
      /elseif (_channel=~'gtell') \
        /track %{P1}%;\
      /endif%;\
    /elseif (regmatch('^pick (.*)$', _tell_command) & _tell_tank) \
      /if (rogue>0) \
         pick %{P1}%;\
         /set picking=%{P1}%;\
      /endif%;\
    /elseif (regmatch('^thp (off|[-|0-9]+)', _tell_command) & _tell_tank) \
      /if (priest>0 | animist>1) \
        /thp %{P1}%;\
        /status %{tank}%;\
      /endif%;\
    /elseif (regmatch('^ghp (off|[-|0-9]+)', _tell_command) & _tell_tank) \
      /if (priest>0 | animist>1) \
        /ghp %{P1}%;\
        /status %{tank}%;\
      /endif%;\
    /elseif (regmatch('^gphp (off|[-|0-9]+)', _tell_command) & _tell_tank) \
      /if (priest>1) \
        /gphp %{P1}%;\
        /status %{tank}%;\
      /endif%;\
    /elseif (regmatch('^gmhp (off|[-|0-9]+)', _tell_command) & _tell_tank) \
      /if (templar>1) \
        /gmhp %{P1}%;\
        /status %{tank}%;\
      /endif%;\
    /elseif (regmatch('^mhp (off|[-|0-9]+)', _tell_command) & _tell_tank) \
      /if (priest>0 | templar>0) \
        /mhp %{P1}%;\
        /status %{tank}%;\
      /endif%;\
    /elseif (regmatch('^gate ([A-z]+)$', _tell_command) & _tell_tank) \
      /if (priest>1 & level>60) \
        /set castedholygate=1%;\
        cast 'holy gate' %{P1}%;\
      /endif%;\
    /elseif (regmatch('^You got forcefled! Walk (NORTH|EAST|SOUTH|WEST|UP|DOWN) to get back\!$', _tell_command) & _channel=~'tell') \
      /set forceflee_return=%{P1}%;\
    /elseif (regmatch('^leave quest$', _tell_command) & _tell_tank) \
      /leave_quest%;\
    /elseif (_channel=/'tell')\
      /log_tell %{_full_tell}%;\
    /elseif (_channel=/'gtell') \
      /loggrouptell %{_full_tell}%;\
;    /elseif (regmatch('^enter ([A-z]+)', _tell_command) & _tell_tank=1 & ingroup=1) \
;        enter %{P1}%;\
    /endif
