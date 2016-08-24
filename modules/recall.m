; // vim: set ft=tf:

;;;;;;;;;;;;;;
;Recall Stuff;
;;;;;;;;;;;;;;
/set recallmana=50

/def tele = \
    /if (currentmana > recallmana) \
        /if (priest > 0) \
            cast 'word of recall'%;\
        /elseif ((magician|warlock|nightblade) > 0) \
            cast 'teleport without error'%;\
        /else \
            get recall %{container}%;\
            rec recall%;\
        /endif%;\
    /else \
        get recall %{container}%;\
        rec recall%;\
    /endif

/def -p1 -mregexp -t'tells the group, \'(RECALL|recall)\'' recall_leader_gt =\
    /if ({1}=/{tank}) \
        /tele%;\
    /endif

/def -Fp1 -mregexp -t'tells you \'(RECALL|recall)\'' recall_leader_tell =\
    /if ({1}=/{tank}) \
        /tele%;\
    /endif


/def -p1 -mregexp -t'issues the order \'(recall|RECALL)\'.' recall_leader_order=\
    /if ({1}=~tank) \
        /tele%;\
    /endif

/def -p1 -mglob -t'The Temple Altar of Myrridon' recall_myrridon = \
    /set hometown=Myrridon

/def -p1 -mglob -t'The Temple of Karandras' recall_karandras = \
    /set hometown=Karandras%;\
    /set thetemple=1

/def -p1 -mglob -t'* Fountain Square' rects = \
    /set thetemple=0

/def -p8 -msimple -t'You recite a scroll of recall.' recall_usedscroll = \
    /set buyrecall=1%;\
    /test ++usedrecalls

/def -p8 -msimple -t'You pass through it. Good luck!' rec5= \
    /echo RECAAAAAAAAAAAAAAAAAAAAAAAALED!%;\
    /repeat -0:00:01 1 /extrarecall

/def -p8 -mglob -t'{*} recalls you.' rec50= \
    /echo RECAAAAAAAAAAAAAAAAAAAAAAAALED!%;\
    /repeat -0:00:01 1 /extrarecall

/def -p8 -msimple -t'You disappear in a flash.' rec6= \
    /echo RECAAAAAAAAAAAAAAAAAAAAAAAALED!%;\
    /repeat -0:00:01 1 /extrarecall

/def -p8 -msimple -t'You wish, you wish, upon a star, for the winds to take you far...' recall_reccmd = \
    /echo RECAAAAAAAAAAAAAAAAAAAAAAAALED!%;\
    /repeat -0:00:01 1 /extrarecall

/def -msimple -Exsdamage -t'You can\'t concentrate enough!' recite_fail = \
    /ecko Failed to wimpy?! Safty before looking cool, attempting to wimpy again!%;\
    tele

/def -aBCred -p8 -mglob -t'The surroundings keeps you from doing so.' rec8

/def extrarecall = \
    /if (hometown=/'Karandras') s%; \
    /elseif (hometown=/'Myrridon') ww%; \
    /elseif (hometown!/'telep') \
        /echo -aBCred Uuuumm.. where am I?%;score%;\
    /endif%;\
    /if (buyrecall=1 & usedrecalls>5) \
        /if (hometown=/'Karandras') \
            s%;s%;s%;e%;buy %{usedrecalls} recall%;pc all.recall scroll%;w%;n%;n%;n%;\
            /set buyrecall=0%;/set usedrecalls=0%;\
        /elseif (hometown=/'Myrridon') \
            w%;w%;w%;w%;w%;w%;w%;w%;s%;s%;buy %{usedrecalls} recall%;pc all.recall scroll%;n%;n%;e%;e%;e%;e%;e%;e%;e%;e%;\
            /set buyrecall=0%;/set usedrecalls=0%;\
        /endif%;\
    /endif%;\
    /resetdamage%;\
    /set recalled=1%;\
    /if (xsdamage=1) /set xsdamage=0%;\
        /echo -aBCred *** THANKS TO AUTOWIMPY!?%;/set tellsumm=0%;\
        gtf , spilled too much &+Rblood&+g!%;\
    /endif%;\
    /if (hometown!/'telep') \
        /w slayhuman%;\
;        /d%;\
    /endif%;\
    /if (immo=1 & gpsize>1 & (tank!=(char|'-'))) \
        tell %{tank} Oi, I recalled with immo on! Turning it off!%;\
    /endif%;\
    /immo off%;\
    /if (aod=1 & gpsize>1 & (tank!=(char|'-'))) \
        tell %{tank} Oi, I recalled with Aura of Despair on! Turning it off!%;\
    /endif%;\
    /despair off%;\
    /if (haura=1 & gpsize>1 & (tank!=(char|'-'))) \
        tell %{tank} Oi, I recalled with Holy Aura on! Turning it off!%;\
    /endif%;\
    /haura off%;\
    /endif%;\
    /if (remabout=1) /ecko Taking %{abouteq} on again.%;\
        wear %{abouteq}%;\
        /set remabout=0%;\
    /endif%;\
    /if (remfeet=1) /ecko Taking %{feeteq} on again.%;\
        wear %{feeteq}%;\
        /set remfeet=0%;\
    /endif%;\
    /if (shieldeq=1) /ecko Taking %{shieldeq} on again.%;\
        wear %{feeteq}%;\
        /set shieldeq=0%;\
    /endif%;\
    /if (remweapon=1) /ecko Taking %{weaponeq} on again.%;\
        wear %{weaponeq}%;\
        /set remweapon=0%;\
    /endif%;\
    /if (hometown!/'telep') \
        affects%;\
        pc all.recall scroll%;\
        gc recall scroll%;\
    /endif

;;;;;;;
