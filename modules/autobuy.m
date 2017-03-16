/def -mregexp -Fp12333131 -t"^(Sheila|The secretary) says 'Sorry ([A-z]+), you don't have the ([0-9]+) gold coins that we would have to" autobuy_0 = \
    /if ({P2}=~char) \
        wit %{P3}%;\
        buy corpse%;\
    /endif

/def -mregexp -Fp13213 -t"^(Lionheart the Brave|Braveheart the Lion|Lionheart the Coward|Smallheart the Wuss) says 'There you go, ([A-z]+) - piece of cake!'" autobuy_1 = \
    /if ({P2}=~char) \
        cr%;\
    /endif

/def uzi_autocr_buy = \
    buy corpse

/def -mregexp -F -t"^(Sheila|The secretary) says 'Sorry ([A-z]+), we're booked full at the moment! Come back later.'" autobuy_2 = \
    /if ({P2}=~char) \
        /repeat -60 1 buy corpse%;\
    /endif

/def -mregexp -F -t"^(Shiela|the secretary) says 'Please form an orderly queue and ask for CR again.'" autobuy_3 = \
    buy corpse

