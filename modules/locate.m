; botting.tf

/def uzi_locate = \
    /if (magician>0 & {1}!~'' & {2}!~'' & fighting=0) \
        /set uzi_locate_asker=%{1}%;\
        /set uzi_locate_item=%{2}%;\
        /if ({2}!~'') \
            /set uzi_locate_grep=%{3}%;\
        /else \
            /set uzi_locate_grep=%{uzi_locate_item}%;\
        /endif%;\
        cast 'locate object' %{uzi_locate_item}%;\
        /set uzi_locate_init=1%;\
    /endif

/def -E(uzi_locate_init) -F -msimple -t"Ok." uzi_locate_start_parsing = \
    /set uzi_locate_found=0%;\
    /set uzi_locating=1%;\
    /set uzi_locate_init=0%;\
    /def -F -p123133 -mregexp -t"%{uzi_locate_grep}" uzi_locate_grep_string = \
        /set locatefound=1%%;\
        tf %%{uzi_locate_asker} emote : %%{PL}%%{P0}%%{PR}

/def -F -p50 -mregexp -t"^([A-z]+) (asks|tells) you 'locate ([^ ]+)[ ]?(.*)'$" spellbotlo = \
    /set locate_asker=%{P1}%;\
    /set locate_init=1%;\
    locate %{P3}%;\
    drop locatedone%;\
    /if ({P4} =~ '') \
        /eval /set locate_find_pattern=$[{P3}]%; \
    /else \
        /eval /set locate_find_pattern=$[{P4}]%; \
    /endif



/def -E(uzi_locating=1) -F -msimple -t"Nothing at all by that name." uzi_locate_none_found = \
    /set uzi_locating=0%;\
    tf %{uzi_locate_asker} emote no items found!

/def -E(locating=1) -F -msimple -t"You are very confused." uzi_locate_overflow= \
    /set uzi_locating=0%;\
    tf %{locate_asker} emote : There are too many items to see all of them.

/def -F -ag -msimple -t"You don't seem to have a locatedone." spellbotlohelperfinal = \
    /purge locate_getstring%;\
    /set locating=0%;\
    /if (!locatefound) \
        tf %{locate_asker} emote : Items found, but none matching the string "%{locate_find_pattern}".%; \
    /endif\

/def -F -ag -msimple -t"In your dreams, or what?" spellbotlohelperfinal2 = \
    /set locating=0%;\
    /set locate_init=0



