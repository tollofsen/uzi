;// vim: set ft=tf
;;yea..

/set count=0
/set lowesthps=100

/if (templar>0 | priest>0 & priest<2) \
	/if (blessme=~'') /set blessme=1%;/endif%;\
/endif
/if (priest>0) \
	/if (wellsumm=~'') /set wellsumm=1%;/endif%;\
/endif
/if (templar>1 | priest>0) \
	/if (aheal=~'') /set aheal=1%;/endif%;\
	/if (atghp=~'') /set atghp=60%;/endif%;\
	/if (atthp=~'') /set atthp=70%;/endif%;\
	/if (atgmhp=~'') /set atgmhp=0%;/endif%;\
	/if (truetank=~'') /set truetank=1%;/endif%;\
	/if (truegroup=~'') /set truegroup=1%;/endif%;\
	/if (miragroup=~'') /set miragroup=0%;/endif%;\
	/if (tickison=~'') /set tickison=0%;/endif%;\
	/if (thresh=~'') /set thresh=120%;/endif%;\
	/if (priest>1) \
		/if (groupinterval=~'') /set groupinterval=0-89%;/endif%;\
		/if (groupbless=~'') /set groupbless=1%;/endif%;\
		/if (miratank=~'') /set miratank=1%;/endif%;\
		/if (selfmira=~'') /set selfmira=1%;/endif%;\
		/if (gpowgroup=~'') /set gpowgroup=1%;/endif%;\
		/if (atmhp=~'') /set atmhp=10%;/endif%;\
		/if (atgphp=~'') /set atgphp=70%;/endif%;\
		/if (maxgpowcount=~'') /set maxgpowcount=4%;/endif%;\
	/else \
		/if (groupinterval=~'') /set groupinterval=0-50%;/endif%;\
	/endif%;\
/endif
/if (priest<1 & templar<2 & animist<2) \
	/set wellsumm=0%;\
	/set aheal=0%;\
	/set atmhp=0%;\
	/set miratank=0%;\
	/set thresh=0%;\
	/set groupinterval=%;\
	/set groupbless=0%;\
	/set truetank=0%;\
	/set truegroup=0%;\
	/set gpowgroup=0%;\
	/set atthp=0%;\
	/set atghp=0%;\
	/set atgphp=0%;\
	/set maxgpowcount=0%;\
/endif
;;
