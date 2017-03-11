;// vim: set ft=tf

;;;simple gager

/def gags = \
  /if (gager != 1) \
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
  /else \
    gag all all set%;\
    gag all get rem%;\
    /if (fighter|templar>0) \
      /ecko Gags for Everything.. (Rescue on Switches)%;\
    /else \
      /ecko Gags for Everything..%;\
    /endif%;\
    /set gager=0%;\
  /endif

;/gags
/def -mglob -p100000 -t"the green carriage driver yells 'Leaving for" carriage_gag 
