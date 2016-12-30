; // vim: set ft=tf:

/def uzi_summon_action = \
    /let _target=%{1}%;\
    /let _requester=%{2}%;\
    /let _channel=%{3}%;\
    /if (_channel=~'gtell') \
        /let _comm=gtf emote%;\
    /elseif (_channel=~'tell' & _requester!~'') \
        /let _comm=tf %{_requester} emote%;\
    /endif%;\
    /if (_target=~'') \
        /ecko Can't summon no one! Command requires a target.%;\
    /elseif (priest>0) \
        /if (inoutpost=1) \
            %{_comm} is in an outpost, try again later.%;\
        /elseif (hometown=~'Ship') \
            %{_comm} can't summon to the intercontinental ships.%;\
        /elseif (in_underworld=1) \
            %{_comm} can't summon into Hades Underworld!%;\
        /elseif (fighting=1) \
            %{_com} is currently in a fight, try again later. (reply "squeue" to get queued)%;\
        /elseif (position!/'stand') \
            %{_com} is resting at the moment, try again later. (reply "squeue" to get queued)%;\
        /elseif (currentmana<=0) \
            %{_com} can't summon without mana.%;\
        /else \
            cast 'summon' 0.%_target%;\
            /set lastsum=%_target%;\
            /set sumway=%_comm%;\
        /endif%;\
    /endif%;\
    /repeat -0:00:10 1 /set lastsum=0%;\
    /repeat -0:00:10 1 /set sumway=0

/def uzi_summon_squeue = \
    /if (priest>0 & {1}!~'') \
        /if (ismember({1}, summonqueue)) \
            tell %1 You are already queued.%;\
        /else \
            /set summonqueue=$(/unique %summonqueue %1)%;\
            tell %1 You are set in the summon queue as #$(/length %summonqueue)%;\
        /endif%;\
    /endif


/def uzi_summon_squeue_iter = \
    cast 'summon ' 0.%{1}

/def uzi_summon_squeue_action = \
    /if (inoutpost<1) \
        /mapcar /uzi_summon_squeue_iter %summonqueue%;\
        /set summonqueue=%;\
    /endif


/def -mglob -t'You can\'t summon creatures to a safe area!' safesummon = \
    /if (sumway!~'0' & lastsum!~'0') \
        /if (regmatch('^gt', sumway)) \
            gt %{lastsum} can't be summoned to a safe area.%;\
        /else \
            %{sumway} Can't summon stuff to a safe area.%;\
            /set sumway=0%;\
            /set lastsum=0%;\
        /endif%;\
    /endif

/def -mglob -t'That person is in a safe area!' safesummon2 = \
    /if (sumway!~'0' & lastsum!~'0') \
        /if (sumway=~'gt*') \
            gt %{lastsum} is in a Safe Area!%;\
        /else \
            %{sumway} I can't summon people from safe areas!%;\
            /set sumway=0%;\
            /set lastsum=0%;\
        /endif%;\
    /endif

/def -msimple -F -t'You failed.' uzi_summon_failed = \
    /if (sumway!~'0' & lastsum!~'0') \
        /if (sumway=~'gt*') \
            gt I failed to summon %{lastsum}, are we on the same continent?%;\
        /else \
            /if (hometown=~'Myrridon') \
                %{sumway} failed to summon, are we on the same continent? I'm on Ashinara.%;\
            /else \
                %{sumway} failed to summon, are we on the same continent? I'm on Orhan.%;\
            /endif%;\
        /endif%;\
    /endif

/def -mregexp -F -t'Nothing happens as ([A-z]+) is not playing!' uzi_summon_not_playing = \
    /if (sumway!~'0' & lastsum!~'0') \
        /if (sumway=~'gt*') \
            gt %{P1} should toggle play!%;\
        /else \
            %{sumway} thinks it's impossible to summon not playing people.%;\
        /endif%;\
    /endif

/def -msimple -F -t'Nobody playing by that name.' uzi_summon_nobody = \
    /if (sumway!~'0' & lastsum!~'0') \
        /if (sumway=~'gt*') \
            gt Nobody playing by the name of %{lastsum}!%;\
        /else \
            %{sumway} thinks theres nobody playing by that name.%;\
        /endif%;\
    /endif


