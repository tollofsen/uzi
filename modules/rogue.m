; // vim: set ft=tf:

;;;;; Peek script.
;;;;; Old but works (hopefully)

/alias pk /ppeek %*

/def ppeek = \
    /if (rogue>1) \
        /send peek %{*}%;/set peeking=%{*}%;\
    /else \
        tell %{peeker} peek %{*}%;\
    /endif

/set peek0=0

/def -mglob -aCred -t'You fail to peek!' peek_fail = \
    /if (rogue>1) \
        /if (peeking!/'0') /pk %{peeking}%;/endif%;\
    /endif

/def pk = \
    /set peeking=%{1}%;/set pkwho=%{2}%;pk %{*}

;;;;;;;;;;;;;;;;;;;
;PEEEEEEEEEEEEEEEK;
;;;;;;;;;;;;;;;;;;;

/def -mregexp -t'As you peek ([A-Za-z]*) you see the following\:' peek1 = /send %;\
    /if (apeek=1) \
        /set peeking=$[strcat(toupper(substr({P1}, 0, 1)), substr({P1}, 1))]%;\
        /set blank= %;\
        /set pkcount=1%;/set dontshowprompt=0%;\
        /def -q -p2147483647 -ag -mregexp -t'^[0-9]+\\(.*' gaggprt = /set dontshowprompt=1%%;/set apeek=0%%;/purge gaggprt%;\
            /def -p99999999 -F -mregexp -t'([^ ]*)' peek2 = \\
                /if (({*}=/{prompt})|(dontshowprompt=1)) /set dontshowprompt=0%%;/set apeek=0%%;\\
                    /if (peek0!~'0') /if (pkcount>1) %%{pktell} &+Y%%{pkcount}&+yx &+w%%{peek0}%%;\\
                    /else %%{pktell} %%{peek0}%%;/endif%%;/set pkcount=1%%;/endif%%;\\
                    /set peek0=0%%;\\
                    /if (peek0!/'0') %%{pktell} %%{peek0}%%;/set peeking=0%%;/set peek1=%%{peek0}%%;/set peek0=%%{*}%%;/endif%%;\\
                    /purge peek2 %%;%%{pktell} END.%%;\\
                /elseif ({*}=/'You tell*') /purge peek2%%;%%{pktell} END.%%;\\
                /elseif ({*}=/'*tells*') /set peeking=1%%;\\
                /elseif ({*}=/'*gossip*') /set peeking=1%%;\\
                /elseif ({*}=/'\\(tell\\)*') /set peeking=1%%;\\
                /elseif ({*}=/'\\(group\\)*') /set peeking=1%%;\\
                /elseif ({*}=/{blank}) /set peeking=1%%;\\
                /elseif ({*}=/'* assists*') /set peeking=1%%;\\
                /elseif ({*}=/'Obvious exits: *') \\
                    /set peek1=%%{peek0}%%;\\
                    /set peek0=&+Y(&+y%{peeking}&+Y) &+W%%{peek0} &+c| &+YExits &+y%%{3}%%{4}%%{5}%%{6}%%{7}%%{8}%%{9}%%;\\
                /elseif ({*}=/'...glowing with a bright light!') %%{pktell} %%{peek0} &+y(&+Wsanctuary&+y)%%;\\
                    /set peek1=%%{peek0}%%;/set peek0=0%%;\\
                /else \\
                    /set inlist=0%%;/ismember %%{1} %%{gplist}%%; \\
                    /if (peek0!/'0') /set peek2=%%{*}%%;\\
                        /if (peek0=~{peek2}) /test pkcount:=(%%{pkcount}+1)%%;\\
                            /else /if (pkcount>1) %%{pktell} &+Y%%{pkcount}&+yx &+w%%{peek0}%%;\\
                            /else %%{pktell} %%{peek0}%%;/endif%%;\\
                            /set pkcount=1%%;\\
                        /endif%%;\\
                    /endif%%;/set peeking=1%%;\\
                    /if (inlist=1) \\
                        /set peeking=1%%;/set peek2=0%%;/set peek1=0%%;/set peek0=0%%;\\
                    /else \\
                    /set peek1=%%{peek0}%%;/set peek0=%%{*}%%;/endif%%;\\
                /endif%;\
            /endif


/def -i remklammer = \
    /let _word=%1%;\
    /let _result=%;\
    /while (shift(), {#}) \
        /if (_word !~ {1}) \
            /let _result=%{_result} %{1}%;\
        /endif%;\
    /done%;\
    /set peek0= %{_result}%;\
    /echo -aCcyan Removed from rolls: %{_word}

/def -mregexp -t'Sorry there is no exit ([A-Za-z\.]*).' peek_fail2 = \
    /if (apeek=1) %{pktell} &+RWarning! &+wNo exit &+m%{P1} &+where.%;/endif

/def -mregexp -t'Where do you want to peek?' peek_fail3 = \
    /if (apeek=1) %{pktell} &+RWarning! &+wYou can't peek &+m%{peeking} &+wyou know&+W.%;/endif

/def -mregexp -t'([A-Za-z]*) tells you \'peek ([A-Za-z]*)\'' pktell3 = \
    /peek %{P2} tell %{P1}

/def -mregexp -t'([A-Za-z]*) tells the group, \'peek ([A-Za-z]*)\'' pktell2 = \
    /peek %{P2}

/def peek = \
    /if (rogue>1) \
        /if ({2}=/'t*') /set pktell=tell %{3} &+cPk&+W:&+w%;\
            pk %{1}%;\
        /else /set pktell=gt &+cPk&+W:&+w%;pk %{1}%;\
        /endif%;\
        /set apeek=1%;\
    /endif

/def pktell = /if ({1}=/'gt*') /set pktell=gt &+gPk&+w:&+c%;\
/elseif ({1}=/'t*') /set pktell=tell %{2} &+RPk&+W:&+m%;\
/else /set pktell=%{*}%;\
/endif

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
