; // vim: set ft=tf:

/def -msimple -t'You get a Key to Eternity from Corpse of A Medjai Warrior.' medjai_key = \
    unlock gate%;\
    open gate%;\
    don key

/def -msimple -t'You get a heavy bronze key from Corpse of The Gatekeeper of Alterac.' alterac_key = \
    unlock gate%;\
    open gate

/def -msimple -t'You get the key for the inner chambers from Corpse of A lieutenant of the Brettonian High Command.' alterac_key1 = \
    unlock door%;\
    open door

/def -msimple -t'You get a beautiful dark key from Corpse of The gate guard of Guallidurth.' guallidurth_key = \
    unlock gate%;\
    open gate

/def -msimple -t'You get a key made from the bones of a dragon from Corpse of A Draconian gatekeeper.' sarakesh_key = \
    unlock gate%;\
    open gate

/def -msimple -t'You get a complex key from Corpse of Lord Ceanyth.' ceanyth_key = \
    unlock door%;\
    open door



; EQ-vape
/def -msimple -aBCred -t'An eye of fear and flame fries you with a nasty breath of flames.' ud_vape

/def -mregexp -aBCred -t'^([A-z]+) burns up and disappears!' ud_vape1 = \
    /ecko %{P1} just got vaped!%;\
    /beeper
