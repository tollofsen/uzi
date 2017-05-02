; // vim: set ft=tf:

/def uzi_popcheck = \
    /if (priest>0 & {1}!~'' & fighting=0) \
        /set uzi_popcheck_zone=%{1}%;\
        /set uzi_popcheck_asker=%{2}%;\
        /uzi_popcheck_handler %{1}%;\
    /endif

/alias popcheck=/uzi_popcheck %{*}
/def popcheck = /uzi_popcheck %{*}

/set uzi_popcheck_zones=Laboratory Ceanyth Underworld Graveyard Kaltor Coven Snakes Shadowdwell Medjai Alterac Guallidurth Dragontail
/set uzi_popcheck_zones_oc=Laboratory Ceanyth Underworld Graveyard Kaltor Coven Snakes Shadowdwell
/set uzi_popcheck_zones_nc=Medjai Alterac Guallidurth Dragontail


/def uzi_popcheck_handler = \
    /set uzi_popcheck=1%;\
    /if (regmatch('^(soul|laboratory|soulies)', {1})) \
        /do_popcheck Laboratory%;\
    /elseif (regmatch('^(monsters|beasts|ceanyth|dungeon|dungeons)$', {1})) \
        /do_popcheck Ceanyth%;\
    /elseif (regmatch('^(uw|underworld|jason)$', {1})) \
        /do_popcheck Underworld%;\
    /elseif (regmatch('^(dragons|graveyard)$', {1})) \
        /do_popcheck Graveyard%;\
    /elseif (regmatch('^(charred|charreds|kaltor)$', {1})) \
        /do_popcheck Kaltor%;\
    /elseif (regmatch('^(coven|witch|witches)$', {1})) \
        /do_popcheck Coven%;\
    /elseif (regmatch('^(snakes|snake|snakelair)$', {1})) \
        /do_popcheck Snakes%;\
    /elseif (regmatch('^(shadow|shadowdwell)$', {1})) \
        /do_popcheck Shadowdwell%;\
    /elseif (regmatch('^(medjai|medjais|cohnshar)$', {1})) \
        /do_popcheck Medjai%;\
    /elseif (regmatch('^(waywatcher|waywatchers|alterac)$', {1})) \
        /do_popcheck Alterac%;\
    /elseif (regmatch('^(drow|drows|guallidurth)$', {1})) \
        /do_popcheck Guallidurth%;\
    /elseif (regmatch('^(sarakesh|bodak|bodaks|dragontail)$', {1})) \
        /do_popcheck Dragontail%;\
    /elseif (regmatch('^(decapitated|decap|decaps|khronatio)$', {1})) \
        /do_popcheck Khronatio%;\
    /elseif (regmatch('^(oc|nc|all)$', {1})) \
        /do_popcheck %{P1}%;\
    /else \
        /if (uzi_popcheck_asker!~'') \
            tf %{uzi_popcheck_asker} emote : Invalid zone. Valid ones are: Laboratory Ceanyth Underworld Graveyard Kaltor Coven Snakes Shadowdwell Medjai Alterac Guallidurth Dragontail OC NC%;\
        /endif%;\
        /set uzi_popcheck=0%;\
        /set uzi_popcheck_asker=%;\
    /endif


/def do_popcheck = \
    /set uzi_popcheck=1%;\
    /set uzi_popcheck_zone=%{1}%;\
    /set uzi_popcheck_zone_list=%{-1}%;\
    /if ({1}=~'Laboratory') \
        summon 50.soulcrusher%;\
    /elseif ({1}=~'Ceanyth') \
        summon ceanyth%;\
    /elseif ({1}=~'Underworld') \
        summon jason%;\
    /elseif ({1}=~'Graveyard') \
        summon 5.dracolich%;\
    /elseif ({1}=~'Kaltor') \
        summon 5.charred%;\
    /elseif ({1}=~'Coven') \
        summon 5.crone%;\
    /elseif ({1}=~'Snakes') \
        summon 5.rattlesnake%;\
    /elseif ({1}=~'Shadowdwell') \
        summon goristro%;\
    /elseif ({1}=~'Medjai') \
        summon 20.medjai%;\
    /elseif ({1}=~'Alterac') \
        summon 10.waywatcher%;\
    /elseif ({1}=~'Guallidurth') \
        summon 260.drow%;\
    /elseif ({1}=~'Dragontail') \
        summon 5.bodak%;\
    /elseif ({1}=~'Khronatio') \
        summon 10.decapitated%;\
    /elseif ({1}=~'oc') \
        /do_popcheck %{uzi_popcheck_zones_oc}%;\
    /elseif ({1}=~'nc') \
        /do_popcheck %{uzi_popcheck_zones_nc}%;\
    /elseif ({1}=~'all') \
        /do_popcheck %{uzi_popcheck_zones}%;\
    /endif

/def -p222 -msimple -E(uzi_popcheck=1) -t"Nobody playing by that name." uzi_popcheck_no_pop = \
    /set uzi_popcheck=0%;\
    /if (uzi_popcheck_asker!~'') \
        tf %{uzi_popcheck_asker} emote &+yPopcheck&+Y: &+W%{uzi_popcheck_zone}&+w is as &+rdesolate&+w as a hillbilly MENSA gathering!%;\
    /else \
        /ecko %{uzi_popcheck_zone} @{bCred}NO%;\
    /endif%;\
    /if (uzi_popcheck_zone_list!~'') \
        /do_popcheck %{uzi_popcheck_zone_list}%;\
    /else \
        /set uzi_popcheck_asker=%;\
    /endif

/def -p222 -mregexp -E(uzi_popcheck=1) -t"^(You can't summon creatures to a safe area!|You failed.|That person is in a safe area!|You can't summon mobs to .*|As the words escape your lips and .*|.* arrives suddenly.)$" uzi_popcheck_popped = \
    /set uzi_popcheck=0%;\
    /if (uzi_popcheck_asker!~'') \
        tf %{uzi_popcheck_asker} emote &+yPopcheck&+Y: &+W%{uzi_popcheck_zone}&+w is &+mready&+w for harvesting!%;\
    /else \
        /ecko %{uzi_popcheck_zone} @{bCgreen}YES%;\
    /endif%;\
    /if (uzi_popcheck_zone_list!~'') \
        /do_popcheck %{uzi_popcheck_zone_list}%;\
    /else \
        /set uzi_popcheck_asker=%;\
    /endif

/def -F -E(uzi_popcheck=1) -msimple -t"Nah... You feel too relaxed to do that..." uzi_popcheck_resting = \
    /set uzi_popcheck=0%;\
    /if (uzi_popcheck_asker!~'') \
        tf %{uzi_popcheck_asker} emote : Can't check pop while &+mresting&+g.%;\
    /endif%;\
    /set uzi_popcheck_asker=

/def -F -E(uzi_popcheck=1) -msimple -t"In your dreams, or what?" uzi_popcheck_sleeping = \
    /set uzi_popcheck=0%;\
    /if (uzi_popcheck_asker!~'') \
        tf %{uzi_popcheck_asker} emote : Can't check pop while &+msleeping&+g.%;\
    /endif%;\
    /set uzi_popcheck_asker=

/def -E(uzi_popcheck=1) -F -msimple -t'You cant seem to do that here!' uzi_popcheck_nomag = \
    /set uzi_popcheck=0%;\
    /if (uzi_popcheck_asker!~'') \
        tf %{uzi_popcheck_asker} emote : I'm in no magic!%;\
    /endif%;\
    /set uzi_popcheck_asker=

/def -E(uzi_popcheck=1) -p222 -msimple -t"Impossible!  You can't concentrate enough!" uzi_popcheck_fighting = \
    /set uzi_popcheck=0%;\
    /if (uzi_popcheck_asker!~'') \
        tf %{uzi_popcheck_asker} emote : I'm fighting, can't summon anything!%;\
    /endif%;\
    /set uzi_popcheck_asker=

