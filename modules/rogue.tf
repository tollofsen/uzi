; // vim: set ft=tf:

;;;;; Peek script.
;;;;; Old but works (hopefully)

/alias pk /ppeek %*

/def ppeek = \
    /if (rogue>1 & playing=1) \
        /send peek %{*}%;\
        /set _peek_dir=%{*}%;\
        /set _peek_peekdir=%{*}%;\
    /else \
        tell %{peeker} peek %{*}%;\
    /endif

/def peek = \
    /if (rogue>1 & position=~'rest') \
        stand%;\
    /elseif (rogue>1 & position=~'sleep') \
        wake%;\
    /endif%;\
    /if (rogue>1 & playing=1) \
        /if ({2}=/'t*') \
            /set _peek_pktell=tf %{3} emote &+cPk&+W:&+w%;\
        /elseif (ingroup=1) \
            /set _peek_pktell=gtf emote &+cPk&+W:&+w%;\
        /endif%;\
        /set _peek_peekdir=%{1}%;\
        /set _peek_peeking=0%;\
        /send peek %{1}%;\
    /endif

/def prompt_peek = \
    /purge peek_trigger%;\
    /if (_peek_pktell!~'' & _peek_peeking=1) \
        /peek_parse%;\
        /eval /send %{_peek_pktell} &+mEND.%;\
        /set _peek_peekdir=0%;\
        /set _peek_pktell=%;\
        /set _peek_current=%;\
        /set _peek_previous=%;\
        /set _peek_counter=1%;\
        /set _peek_peeking=0%;\
    /endif%;\
    /set _peek_peeking=0


;;;;;;;;;;;;;;;;;;;
;PEEEEEEEEEEEEEEEK;
;;;;;;;;;;;;;;;;;;;

/def -msimple -Fp21313 -t'Maybe you should get on your feet first?' peek_sitting = \
  /if (_peek_pktell!~'') \
    /send %{_peek_pktell} Can't peek while sitting!%;\
    /unset _peek_pktell%;\
  /endif

/def -msimple -aCred -t'Where do you want to peek?' peek_nodir = \
    /if (_peek_pktell!~'') \
        /send %{_peek_pktell} Peek in what direction?!%;\
    /endif

/def -msimple -aCred -t'You fail to peek!' peek_fail = \
    /if (rogue>1 & playing=1) \
        /if (_peek_peekdir!/'0') /ppeek %{_peek_peekdir}%;/endif%;\
    /endif

/def -mregexp -aCred -Fp123 -t'^Sorry there is no exit (north|east|south|west|up|down).$' _uzi_rogue_peek_noexit = \
    /if (_peek_pktell!~'') \
        /send %{_peek_pktell} &+RWarning! &+wNo exit &+m%{P1} &+where.%;\
    /endif


/def peek_parse = \
    /if ({*}=/'Obvious exits: *') \
        /set _peek_current=&+Y(&+y%{_peek_dir}&+Y) &+W&_%{_peek_current}&n &+c| &+YExits: &+y%{3} %{4} %{5} %{6} %{7} %{8} %{9}%;\
    /elseif ({*}=/'...glowing with a bright light!') \
        /set _peek_sanc=1%;\
    /elseif ({*}=/"You can't see a damned thing, you're blinded!") \
      emote is &+LBLIND&n as a bat!%;\
      /prompt_peek%;\
    /else \
        /if (_peek_current!/'0') \
            /set _peek_previous=%{_peek_current}%;\
            /set _peek_current=$[replace("AGG", "&+rAGG&+w", {*})]%;\
            /if (regmatch('The ground is covered with ancient looking runes.', _peek_previous)) \
                /set _peek_previous=&+MThe ground is covered with ancient looking runes. (COP)%;\
            /endif%;\
            /if (_peek_previous=~_peek_current) \
                /test ++_peek_counter%;\
            /elseif (_peek_counter>1) \
                /if (_peek_sanc>0) \
                    /eval /send %{_peek_pktell} &+Y%{_peek_counter}&+yx &+w%{_peek_previous} &+y(&+Wsanctuary&+y)%;\
                /else \
                    /eval /send %{_peek_pktell} &+Y%{_peek_counter}&+yx &+w%{_peek_previous}%;\
                /endif%;\
                /set _peek_sanc=0%;\
                /set _peek_counter=1%;\
            /else \
                /if (_peek_sanc>0) \
                    /eval /send %{_peek_pktell} %{_peek_previous} &+y(&+Wsanctuary&+y)%;\
                /else \
                    /eval /send %{_peek_pktell} %{_peek_previous}%;\
                /endif%;\
                /set _peek_sanc=0%;\
                /set _peek_counter=1%;\
            /endif%;\
        /endif%;\
        /set _peek_current=$[replace("AGG", "&+rAGG&+w", {*})]%;\
    /endif
;    /set _peek_peeking=1

/def -mregexp -E_peek_peeking=1 -F -p120003 -t'^([A-z]+) utters the words, |^([A-z]+) flies in from |^([A-z]+) arrives from |^([A-z]+) carves|^([A-z]+) gets a deadly look in (his|hers|its) eyes.$|^([A-z]+) looks a bit disoriented.$|^([A-z]+) stops following |^([A-z]+) now follows ([A-z]+).|([A-z]+) gets a deadly look in (his|her|its) eyes.$' peek_stoppeek_0 = \
    /prompt_peek

/def -mregexp -p10033 -t'^As you peek ([A-z]+) you see the following\:$' peek_initiate = \
    /set _peek_peeking=1%;\
    /substitute -p As you peek @{nCmagenta}%{P1}@{nCwhite} you see the following:%;\
    /if (_peek_pktell!~'') \
        /set _peek_dir=$[strcat(toupper(substr({P1}, 0, 1)), substr({P1}, 1))]%;\
        /set _peek_counter=1%;\
        /set _peek_current=0%;\
        /set _peek_previous=0%;\
        /set _peek_peeking=1%;\
        /def -p98 -F -mregexp -t'([^ ]*)' peek_trigger = \\
            /peek_parse %%{*}%;\
    /endif

;/def -mregexp -t'([A-Za-z]*) tells you \'peek (n|e|s|w|d|u)(.*)\'' pktell3 = \
;    /if (_peek_peeking<1) \
;        /peek %{P2} tell %{P1}%;\
;    /endif

;/def -mregexp -t'([A-Za-z]*) tells the group, \'peek (n|e|s|w|d|u)(.*)\'' pktell2 = \
;    /if (_peek_peeking<1) \
;        /peek %{P2}%;\
;    /endif

;;;;;;;;;
;TRACKER;
;;;;;;;;;
;/def -mregexp -t'^([^ ]*) tells the group, \'track ([^ ]*)\'' trackit = \
;    /if ({1}=/{tank}) /track %{P2}%;/endif

;/def -mregexp -t'^([^ ]*) tells you \'track ([^ ]*)\'' trackit2 = \
;    /if ({1}=/{tank}) /track %{P2} t %{tank}%;/endif

/def -mregexp -t'^You sense a trail ([a-z]*) from here!' track1 = \
    /set trackdir=$[strcat(toupper(substr({P1}, 0, 1)), substr({P1}, 1))]%;\
    /if (atrack=1) \
        /if (trtell=/'afol') \
            %{trackdir}%;\
            /if (ahide=1) \
                hide%;\
	          /endif%;\
    	  /else \
	          /if (regmatch('^tf ', trtell)) \
                %{trtell} emote says '&+cTrail: &+C%{trackdir}%ish&+c. | Tracking: &+C%{tracker}&+c.&+g'%;\
            /else \
                %{trtell} emote says &+c'&+gTrail: &+G%{trackdir}%ish&+g. | Tracking: &+G%{tracker}&+g.&=c'%;\
            /endif%;\
        /endif%;\
    /endif%;\
    /substitute -p @{Cwhite}You sense a trail @{Cmagenta}%{trackdir} @{Cwhite}from here!

/def -mglob -t'Sorry, you can\'t track for a while, too weary.' track2 = \
    /if ((trtell!/'afol')&(atrack=1)) \
        /set atrack=0%;%{trtell} emote thinks it's to weary.%;\
    /else hide%;\
    /endif

/def -mglob -t'Damn! You lost track of your victim.' track3 = \
    /if ((trtell!/'afol')&(atrack=1)) \
        /set atrack=0%;%{trtell} emote sez 'FSCK! Lost the trail.'%;\
    /else hide%;\
    /endif

/def -mglob -t'The track ends here!' track4 = \
    /if ((trtell!/'afol')&(atrack=1)) \
      /set atrack=0%;%{trtell} emote says 'Oi Oi, isn't the goon here?!'%;ruffle %{tracker}%;\
    /elseif (trtell=/'afol') \
      hide%;\
    /endif

/def -mglob -t'As you scan for tracks you discover that you are looking at your victim*' track5 = \
    /if ((trtell!/'afol')&(atrack=1)) \
        /set atrack=0%;%{trtell} emote goes, 'WOW'%;hop %{tracker}%;\
    /else hide%;\
    /endif

/def -mglob -t'No-one around by that name.' track6 = \
    /if (atrack=1) \
        /set atrack=0%;%{trtell} emote says 'Erm, track Who?!'%;\
    /endif

/def -mglob -t'You examine the area for your victim\'s tracks, but can\'t seem to find any.*' track7 = \
    /if (atrack=1) \
        /set atrack=0%;%{trtell} emote sez 'Uhm, can't find the track of %tracker :('%;\
    /endif


/def track = \
    /if ((animist|rogue)>1) \
        /set tracker=$[strcat(toupper(substr({1}, 0, 1)), substr({1}, 1))]%;\
        /if ({2}=/'t*') /set trtell=tf %{3}%;\
            track %{1}%;\
        /elseif ({2}=/'f*') /set trtell=afol%;track %{1}%;\
        /else /set trtell=gtf%;track %{1}%;\
        /endif%;\
        /set atrack=1%;\
    /endif

;;;;;;;;;;;;;;;
;Autopick/open;
;;;;;;;;;;;;;;;
/def -mregexp -E(pick_disable<1) -t'(The|the|A|a|an|An) ([A-Za-z]*) seems to be closed.' autoopen = \
    open %{P2} %_lastwalkdir%;/set picking=%{P2} %_lastwalkdir

/def -mglob -t'It seems to be locked.' autopick = \
    /if (picking!/'0' & rogue>0 & pick_disable<1) \
        pick %{picking}%;\
        open %{picking}%;\
        /set pick_disable=1%;\
        /repeat -3 1 /set pick_disable=0%;\
    /endif

/def -msimple -t'You failed to pick the lock.' autorepick = \
    /if (picking!~'') \
        pick %{picking}%;\
    /endif

;open %{picking}%;/set picking=0%;/endif

;/def -mregexp -t'^([^ ]*) tells the group, \'(:|)pick (.*)\'' picklockt = \
;    /if ({1}=/{tank} & rogue>0) pick %{P3}%;/set picking=%{P3}%;/endif


;;;;;;;;;;;;
;Preference;
;;;;;;;;;;;;
