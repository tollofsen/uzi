;// vim: set ft=tf

;;;simple gager

/def gags = \
    /if (gager>0) \
        /dogag all%;\
    /else \
        /dogag%;\
    /endif

/def regag = \
    /if (gager=0 & gager!~'') \
        /dogag all%;\
    /else \
        /dogag%;\
    /endif

/def dogag = \
    /if ({1}=~'all') \
        gag all all set%;\
        gag all get rem%;\
        /if (fighter|templar>0) \
            /ecko Gags for Everything.. (Rescue on Switches)%;\
        /else \
            /ecko Gags for Everything..%;\
        /endif%;\
        /set gager=0%;\
    /else \
        /purge ultragag%;\
        gag all all remove%;\
        gag other all set%;\
        gag mob skill set%;\
        gag mob spell set%;\
        gag other get rem%;\
        gag mob miss set%;\
        gag mob dodge rem%;\
        gag mob parry rem%;\
        /if (fighter|templar>0) \
            /ecko Gags for Players.. (Rescue on Hits)%;\
        /else \
            /ecko Gags for Players..%;\
        /endif%;\
        /set gager=1%;\
    /endif

/def -msimple -p9999999 -ag -t"Dimun asks you 'cb'" dimun_cb_gag

;/gags
/def -mregexp -ag -p100000 -t"^the .* carriage driver yells 'Leaving for" carriage_gag
