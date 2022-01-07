; // vim: set ft=tf:

/def pgmode = \
    /if ({1}=~'on') \
        /set pgmode=1%;\
        gtf emote will now die for %{tank}!%;\
    /elseif ({1}=~'off') \
        /set pgmode=0%;\
    /endif

;;;;Lloth
/def -mglob -t'Lloth\'s Time Stop comes to an end, and you shift back into the fabric of time\!' llothtimelock = \
    /ecko TIMELOCK!!! PANIC!!%;\
    /resetdamage%;\
    /if (aheal>0) \
        /set sentgroup=1%;\
        group%;\
    /endif

/def -msimple -F -t'The High Plateau of Arach-Tinilith' lloth_pgmob_setroom = \
    /set uzi_lloth_room=2


/def -msimple -F -t'Reylen Dar ensnares your sword-arm with his chain, and disarms you!' reylen_pgmob_unwield = \
    wield %{weapon}

; Takhisis
/def -msimple -t'The Shoikan Grove' uzi_pgmob_takhisis_0 = \
    /if (magician>0 & ingroup=1 & tank!~char) \
        enwn%;\
    /endif

/def -F -mregexp -t"^The eyes of the ([^ ]+) head glow with a " uzi_pgmob_takhisis_1 = \
    /set uzi_pgmob_spec_kiki=0%;\
    /if ({P1}=~'blue') \
        /d fire%;\
    /elseif ({P1}=~'red') \
        /d ice%;\
    /elseif ({P1}=~'green') \
        /d unlife%;\
    /elseif ({P1}=~'orange') \
        /d energy%;\
    /elseif ({P1}=~'purple') \
        /set uzi_pgmob_spec_kiki=1%;\
    /endif

/def -F -mglob -t"Takhisis slashes *'s throat wide open!" uzi_pgmob_takhisis_2 = \
    /set uzi_pgmob_spec_kiki=0%;\
    /w slaydragon%;\
    /d slaydragon

/def -F -msimple -t'You are in a pretty bad shape, unable to do anything!' uzi_pgmob_takhisis_3 = \
    /set xsdamage=0

; Zandramas
/def -F -mregexp -t"^([^ ]+) looks rather pale and shaken as (he|she|it) jumps through the Flames\." uzi_pgmob_zandramas_0 = \
    /if ({P1}=~tank & ingroup=1) \
        enter flame%;\
    /endif

/def -F -ah -msimple -t"You are pushed into the claws of darkness, you feel a strange feeling." uzi_pgmob_zandramas_1 = \
    /if (ingroup=1) \
        3n2e3n2e%;\
        enter flame%;\
    /endif

; Ghalotiri
/def -F -t"{*} gets a huge mound of gold coins from Corpse of Ghalotiri, the leader of the Medjai\." uzi_pgmob_ghalotiri = \
    /if (ingroup=1) \
        /set areaspells=1%;\
    /endif

;;;; Azimer
/def -F -mregexp -t"^The Daedra Lord Azimer suddenly slams you with his tail. The force" uzi_pgmob_azimer = \
    5e3u2e

/def -F -mregexp -p12003 -t'^The Daedra Lord Azimer is here, fighting' uzi_pgmob_azimer1 = \
    /set uzi_pgmob_spec_azimer=1

;;;; Gith
/def -F -msimple -t'The Torture Master of the Gith utters some strange words and transforms into a HUGE blood-suckying bat soaring overhead.' uzi_pgmob_gith0 = \
    /set uzi_pgmob_spec_gith=1

/def -F -msimple -t'A vampiric bat with HUGE wings settles back to the room floor and bellows with anger!' uzi_pgmob_gith1 = \
    /unset uzi_pgmob_spec_gith


;;;; Worm

/def -F -msimple -t'The breeding chamber' uzi_pgmob_worm1 = \
    /set worm_fight=2%;\
    /areas

/def -F -msimple -t'Being digested by the Primeval Worm' uzi_pgmob_worm2 = \
    /set worm_belly=2%;\
    /ecko Oh FSCK! Attempting to flee to the throat!%;\
    flee

/def -F -E(worm_belly>0) -msimple -p12300 -t"PANIC! You couldn't escape!" uzi_pgmob_worm3 = \
    /ecko Failed to flee! Attempting again!%;\
    flee

/def -F -E(worm_belly>0) -msimple -p12300 -t"It is too crowded to move that way!" uzi_pgmob_worm4 = \
    /ecko Someone is already in there! Attempting again until I succeed!%;\
    flee

/def -F -msimple -t"You slide down through the beast's throat in a blob of slime." uzi_pgmob_worm5 = \
    /ecko THE WORM ATE ME!!!%;\
    look

/def -msimple -t"Inside the throat of the Primeval Worm" uzi_pgmob_worm6 = \
    /ecko Chilling until someone else gets eaten or I slip.


;;;; Draconian Jailor
/def -F -ah -mregexp -t'^The Draconian Jailor picks up ([^ ]+) and runs away from battle.$' uzi_pgmob_sarakesh = \
    /if (priest>0) \
        summon %{P1}%;\
    /endif


;;;; Thorn Demon
/def -F -msimple -t'Thorny Plain' uzi_pgmob_thorndemon = \
    /areas


;;;; Taon
/def -F -msimple -t'The Chamber of Running Water' uzi_pgmob_taon0 = \
    remove %{weapon}%;\
    /set remweapon=1

/def -F -Eremweapon -msimple -t'A multi-dimensional pathway' uzi_pgmob_taon1 = \
    wield %{weapon}%;\
    /set remweapon=0

/def -F -msimple -t'Void' uzi_pgmob_taon2 = \
    /if (regmatch('^@{uB}Void@{n}$', encode_attr({*}))) \
        /set wildmagic=2%;\
    /endif


;; Solus
/def -F -msimple -t'The Solus gateway' uzi_pgmob_solus = \
    /areas

;; Nyx
/def -F -msimple -t'Nyx\'s Darkness' uzi_pgmob_nyx_init = \
    /set nyx_spec=1

/def -F -E(nyx_spec=1) -msimple -t'Your vision returns!' uzi_pgmob_nyx_1 = \
    /set nyx_spec=0%;\
    /if (tank!~char & ingroup=1) \
        follow %{tank}%;\
    /endif

/def -F -msimple -t"Nyx knocks you off her ledge into Tantalus' domain." uzi_pgmob_nyx_2 = \
    s4w3s6e3nu3s3w4n%;\
    /if (tank!~char & ingroup=1) \
        follow %{tank}%;\
    /endif

/def -F -msimple -t"As you cross the narrow ledge, you misplace your foot and take a plummet back to Tartarus." uzi_pgmob_nyx_3 = \
    s4w3s6e3nu3s3w3n


; Malius
/def -F -mregexp -t'^(A female peasant is busy at work here |A merchant has stopped here briefly to trade goods|A guard of Alterac defends the sanctity of his homeland|A soldier of fortune waits here for instruction \(invisible\)|An elven ranger is scouting the surrounding hinterland|A hero of the Alliance stands fully alert)$' uzi_pgmob_malis = \
    /ecko MALIUS!

; Storm giant king
/def -F -msimple -t'The storm giant king summons some guards to help him rid the earth of YOU!!!' uzi_pgmob_sgk = \
    /set areafight=1

; Colossus
/def -F -mregexp -t'^([A-z]+) tells you \':mobspec colossus\'' uzi_pgmob_colossus0 = \
    /if ({P1}=~tank) \
        south%;down%;east%;south%;\
    /endif

/def -F -msimple -t'The cave plunges into darkness as the gigantic frame of the Colossus blocks out all shafts of light.' uzi_pgmob_colossus1 = \
    /set uzi_pgmob_spec_colossus=1

/def -F -msimple -t'Light slowly begins to spill back into the cave as the Colossus lurches backward.' uzi_pgmob_colossus2 = \
    /set uzi_pgmob_spec_colossus=0

; Erebus
/def -F -mregexp -t'^([A-z]+) tells the group, \':erebus\'$' uzi_pgmob_erebus = \
    /if ({P1}=~tank & autofight=1 & areadam!~'' & areadam!~'-') \
        /set areafight=1%;\
        %areadam%;\
    /endif

; Nyraan
/def -F -aBCyellow -mregexp -t'^Lady Nyraan summons a spectre of dread which sends ([A-z]+) sprawling in fear.$' nyraan_flee_0 = \
  /set nyraan_flee_subject = %{P1}

/def -F -mregexp -t'^([A-z]+) (flies|leaves) (north|east|south|west|up|down)' nyraan_flee_1 = \
  /if (nyraan_flee_subject=~ {P1}) \
  /endif

