;// vim: set ft=tf

/def -p2147483647 -n1 -mregexp -t'^Saving ([^\.]+).' GettingCharInfo01 = \
	/set char=%{P1}%;\
	/file_exists %{uzidirectory}/saves/%{char}.sav%;\
	/if (file_exists = 1) \
		/ecko Loading saved file for %{htxt2}%{char}%{ntxt}.%;\
		/quote -S /unset `/listvar -s cdam_*%;\
		/quote -S /unset `/listvar -s *slay%;\
		/lood saves/%{char}.sav%;\
		/lood modules/convertvalues.tf%;\
		/def -ag -h"REDEF" gagredefine%;\
		/lood modules/aliases.tf%;\
		/purge gagredefine%;\
		/theme %{themetoload}%;\
		/purge GettingCharInfo02%;\
		/purge GettingCharInfo03%;\
	/else \
		/ecko No saved files for %{P1} could be found.. getting some standard info now.%;\
		/send finger self%;\
	/endif

/def -p2147483647 -mregexp -t'\[[0-9]+\/[0-9]+[ ]+([^\/]+)\/([A-z]+)\]' GettingCharInfo02 = \
	/let charclassI=%{P2}%;\
	/let charclassII=%{P1}%;\
	/if (regmatch({char}, {*})) \
		/GettingCharClass %{charclassI}%;\
		/GettingCharClass %{charclassII}%;\
		/set charclass=%{charclassII}/%{charclassI}%;\
		/autodefineautoass%;\
		/purge GettingCharInfo02%;\
		/purge GettingCharInfo03%;\
	/endif

/def -p2147483647 -mregexp -t'\[[ ]+[0-9]+[ ]+([A-z]+)[ ]+\]' GettingCharInfo03 = \
	/let CharClassI=%{P1}%;\
	/if (regmatch({char}, {*})) \
		/GettingCharClass %{CharClassI}%;\
		/set charclass=%{CharClassI}%;\
		/autodefineautoass%;\
		/ecko Since you are SINGLE classed, and not 50/50 this script won't run perfectly until you are lvl 50/50!%;\
		/ecko Use the alias newprompt to set your prompt.%;\
		/set newprt display \\\%\r\\\%\h\(\\\%H\)H \\\%\p(\\\%\P)M \\\%\m(\\\%\M)V > \\\%\L%;\
		/not /alias newprompt /not \\\%newprt%;\
		/purge GettingCharInfo02%;\
		/purge GettingCharInfo03%;\
	/endif

/set animist=0
/set fighter=0
/set magician=0
/set nightblade=0
/set priest=0
/set rogue=0
/set warlock=0
/set templar=0

/send save
;;;;
