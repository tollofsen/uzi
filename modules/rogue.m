; // vim: set ft=tf:

;;;;; Peek script.
;;;;; Old but works (hopefully)

/alias pk /ppeek %*

/def ppeek = \
    /if (rogue>1 & playing=1) \
        /send peek %{*}%;\
        /set peeking=%{*}%;\
    /else \
        tell %{peeker} peek %{*}%;\
    /endif

/set peek0=0

/def pk = \
    /set peeking=%{1}%;/set pkwho=%{2}%;pk %{*}

/def peek = \
    /if (rogue>1 & playing=1) \
        /if ({2}=/'t*') \
            /set _peek_pktell=tf %{3} emote &+cPk&+W:&+w%;\
        /elseif (amigrouped) \
            /set _peek_pktell=gtf emote &+cPk&+W:&+w%;\
        /endif%;\
        /set _peek_peeking=%{1}%;\
        /send peek %{1}%;\
    /endif

/def prompt_peek = \
    /purge peek_trigger%;\
    /if (_peek_pktell!~'' & _peek_peeking=1) \
        /set _peek_pktell=%;\
        /set _peek_peeking=0%;\
        /set _peek_current=%;\
        /set _peek_previous=%;\
        /set _peek_counter=1%;\
    /endif


;;;;;;;;;;;;;;;;;;;
;PEEEEEEEEEEEEEEEK;
;;;;;;;;;;;;;;;;;;;

/def -msimple -aCred -t'Where do you want to peek?' peek_nodir = \
    /if (_peek_pktell!~'') \
        /send %{_peek_pktell} Peek in what direction?!%;\
    /endif

/def -msimple -aCred -t'You fail to peek!' peek_fail = \
    /if (rogue>1 & playing=1) \
        /if (peeking!/'0') /pk %{peeking}%;/endif%;\
    /endif

/def -mregexp -t'Sorry there is no exit ([A-Za-z\.]*).' peek_noexit = \
    /if (_peek_peeking!/'0' & rogue>1) \
        /send %{_peek_pktell} &+RWarning! &+wNo exit &+m%{P1} &+where.%;\
    /endif


/def -mregexp -Fp10033 -t'^As you peek ([A-z]+) you see the following\:$' peek_initiate = \
    /set _peek_peeking=1%;\
    /if (_peek_pktell!~'') \
        /set _peek_dir=$[strcat(toupper(substr({P1}, 0, 1)), substr({P1}, 1))]%;\
        /set _peek_counter=1%;\
        /set _peek_current=0%;\
        /set _peek_previous=0%;\
        /set _peek_peeking=1%;\
        /def -p99999999 -F -mregexp -t'([^ ]*)' peek_trigger = \\
            /if ({*}=/'Obvious exits: *') \\
                /set _peek_current=&+Y(&+y%{_peek_dir}&+Y) &+W%%{_peek_current} &+c| &+YExits &+y%%{3}%%{4}%%{5}%%{6}%%{7}%%{8}%%{9}%%;\\
                %{_peek_pktell} %%{_peek_current}%%;\\
            /elseif ({*}=/'...glowing with a bright light!') \\
                %%{_peek_pktell} %%{_peek_previous} &+y(&+Wsanctuary&+y)%%;\\
                /set _peek_previous=%%{_peek_0}%%;\\
                /set _peek_current=0%%;\\
            /else \\
                /if (_peek_current!/'0') \\
                    /set _peek_current=%%{*}%%;\\
                    /if (_peek_previous=~_peek_current) \\
                        /test _peek_counter:=(%%{_peek_counter}+1)%%;\\
                    /elseif (_peek_i>1) \\
                        %%{_peek_pktell} &+Y%%{_peek_counter}&+yx &+w%%{_peek_current}%%;\\
                    /else \\
                        %{_peek_pktell} %%{_peek_current}%%;\
                    /endif%%;\\
                    /set _peek_counter=1%%;\\
                /endif%%;\\
                /set _peek_previous=%%{_peek_current}%%;\\
                /set _peek_current=%%{*}%%;\\
            /endif%%;\\
            /set _peek_peeking=1%;\
    /endif

/def -mregexp -t'([A-Za-z]*) tells you \'peek ([A-Za-z]*)\'' pktell3 = \
    /peek %{P2} tell %{P1}

/def -mregexp -t'([A-Za-z]*) tells the group, \'peek ([A-Za-z]*)\'' pktell2 = \
    /peek %{P2}

;;;;;;;;;
;TRACKER;
;;;;;;;;;
/def -mregexp -t'^([^ ]*) tells the group, \'track ([^ ]*)\'' trackit = \
    /if ({1}=/{tank}) /track %{P2}%;/endif

/def -mregexp -t'^([^ ]*) tells you \'track ([^ ]*)\'' trackit2 = \
    /if ({1}=/{tank}) /track %{P2} t %{tank}%;/endif

/def -mregexp -t'You sense a trail ([a-z]*) from here!' track1 = \
    /set trackdir=$[strcat(toupper(substr({P1}, 0, 1)), substr({P1}, 1))]%;\
    /if (atrack=1) \
        /if (trtell=/'afol') %{trackdir}%;/if (ahide=1) hide%;/endif%;\
    /else %{trtell} emote sez 'Trail: %{trackdir}%ish. | Tracking: %{tracker}.'%;/endif%;\
/endif

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
        /set atrack=0%;%{trtell} emote sez 'Oi Oi, isn't the goon here?!'%;ruffle %{tracker}%;\
    /else hide%;\
    /endif

/def -mglob -t'As you scan for tracks you discover that you are looking at your victim*' track5 = \
    /if ((trtell!/'afol')&(atrack=1)) \
        /set atrack=0%;%{trtell} emote goes, 'WOW'%;hop %{tracker}%;\
    /else hide%;\
    /endif

/def -mglob -t'No-one around by that name.' track6 = \
    /if (atrack=1) \
        /set atrack=0%;%{trtell} emote sez 'Erm, track Who?!'%;\
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
/def -mregexp -t'(The|the|A|a|an|An) ([A-Za-z]*) seems to be closed.' autoopen = \
    open %{P2} %_lastwalkdir%;/set picking=%{P2} %_lastwalkdir

/def -mglob -t'It seems to be locked.' autopick = \
    /if (picking!/'0' & rogue>0) \
        pick %{picking}%;\
    /endif

;open %{picking}%;/set picking=0%;/endif

/def -mregexp -t'^([^ ]*) tells the group, \'(:|)pick (.*)\'' picklockt = \
    /if ({1}=/{tank} & rogue>0) pick %{P3}%;/endif


;;;;;;;;;;;;
;Preference;
;;;;;;;;;;;;
