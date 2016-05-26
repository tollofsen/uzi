;// vim: set ft=tf

;;;;;PG MOB triggers


;;;;Lloth
/def -mglob -t'Lloth\'s Time Stop comes to an end, and you shift back into the fabric of time\!' llothtimelock = \
        /ecko TIEMLOC!!! PANIC!!%;\
        /if (aheal>0) \
                /set groupsent=0%;\
                gg%;\
        /else \
                /resetdamage %;\
                /dodamage %;\
        /endif

;;;;Lloth
;;;;/def -mglob -t'You can\'t act, as Lloth has ceased the flow of time\!' llothtimelock = \;;
;;        /if (aheal>0) \
;;		/set groupsent=0%;\		
;;      /else \
;;		/resetdamage %;\
;;	/endif
