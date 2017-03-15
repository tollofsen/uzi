; // vim: set ft=tf:

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

/def uzi_locate_prompt = \
    /if (uzi_locating=1) \
        /set uzi_locating=0%;\
        /purge uzi_locate_grep_string%;\
        /if (uzi_locate_found=0) \
            tf %{uzi_locate_asker} emote &+yLocate&+Y: &+wItems found, but none matching your search pattern.%;\
        /endif%;\
    /endif


/def -E(uzi_locate_init) -F -msimple -t"Ok." uzi_locate_start_parsing = \
    /set uzi_locate_found=0%;\
    /set uzi_locating=1%;\
    /set uzi_locate_init=0%;\
    /def -F -p123133 -mregexp -t"%{uzi_locate_grep}" uzi_locate_grep_string = \
        /set uzi_locate_found=1%%;\
        tf %%{uzi_locate_asker} emote &+yLocate&+Y: &+w%%{PL}%%{P0}%%{PR}

/def -E(uzi_locating=1) -F -msimple -t"Nothing at all by that name." uzi_locate_none_found = \
    /set uzi_locating=0%;\
    tf %{uzi_locate_asker} emote &+yLocate&+Y: &+wNo matches!

/def -E(locating=1) -F -msimple -t"You are very confused." uzi_locate_overflow= \
    /set uzi_locating=0%;\
    tf %{locate_asker} emote &+yLocate&+Y: &+wThere are too many items to see all of them.


/def -F -E(uzi_locate_init=1) -msimple -t"In your dreams, or what?" uzi_locate_sleeping = \
    /set uzi_locating=0%;\
    /set uzı_locate_init=0%;\
    tf %{uzi_locate_asker} emote &+yLocate&+Y: &+wI'm asleep.

/def -E(uzi_locate_init=1) -F -msimple -t'You cant seem to do that here!' uzi_locate_nomag = \
    tf %{uzi_locate_asker} emote &+yLocate&+Y: &+wI'm in no magic!%;\
    /set uzi_locate_init=0%;\
    /set uzi_locating=0

