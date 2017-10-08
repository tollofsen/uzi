;// vim: set ft=tf:

/if (savesetup=1)                                                      \
    /eval /quote -S /set file_exists=!if [ -r %{uzidirectory}/saves/global.sav ]; then echo 1;else echo 0;fi%;\
    /if ({file_exists} = 1) \
        /eval /sys rm %{uzidirectory}/saves/global.sav%;\
    /endif%;\
    /eval /set uzisavefile=%{uzidirectory}/saves/global.sav%;\
    /uzisavetxt ;=-=-=-=-=-=-=-=-= Uzi Global Settings (v.%uziversion) =-=-=-=-=-=-=-=-=-=-=%;\
    /uzisavetxt %;\
    /uzisavevar beepontell%;\
    /uzisavevar tellogger%;\
    /uzisavevar logondeath%;\
    /uzisavevar criticalbeep%;\
    /uzisavevar autoreconnect%;\
    /uzisavevar afkteller%;\
    /uzisavevar afkmsg%;\
    /uzisavevar showtellrows%;\
    /uzisavevar gagprompt%;\
    /uzisavevar uziautosave%;\
    /uzisavevar mailgunapikey%;\
    /uzisavevar email%;\
    /uzisavetxt %;\
    /uzisavetxt ;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%;\
    /if (savequite=0) \
        /uecko Saved %{htxt2}Global %{ntxt}Settings.%;\
    /endif%;\
/elseif (saveconfig=1) \
    /eval /quote -S /set file_exists=!if [ -r %{uzidirectory}/saves/%{char}.sav ]; then echo 1;else echo 0;fi%;\
    /if ({file_exists} = 1) \
        /eval /sys rm %{uzidirectory}/saves/%{char}.sav%;\
    /endif%;\
    /eval /set uzisavefile=%uzidirectory/saves/%char.sav%;\
    /uzisavetxt ;=-=-=-=-=-=-=-=-= Uzi Settings for %{char} (v.%uziversion) =-=-=-=-=-=-=-=-=-=-=%;\
    /uzisavetxt %;\
    /uzisavetxt ;;;Common stuff%;\
    /uzisavevar char%;\
    /uzisavevar align%;\
    /uzisavevar race%;\
    /uzisavevar charclass%;\
    /uzisavevar aura%;\
    /uzisavevar autowimpy%;\
    /uzisavevar themetoload%;\
    /uzisavevar wimpylevel%;\
    /uzisavevar autofocus%;\
    /uzisavevar autoassist%;\
    /uzisavevar ass_group%;\
    /uzisavevar ass_tank%;\
    /uzisavevar assist%;\
    /uzisavevar autofight%;\
    /uzisavevar autoexp%;\
    /uzisavevar autowell%;\
    /uzisavevar berserktryonce%;\
    /uzisavevar autodeathdance%;\
    /uzisavevar autoberserk%;\
    /uzisavevar gameassist%;\
    /uzisavevar priest%;\
    /uzisavevar animist%;\
    /uzisavevar magician%;\
    /uzisavevar fighter%;\
    /uzisavevar rogue%;\
    /uzisavevar warlock%;\
    /uzisavevar nightblade%;\
    /uzisavevar templar%;\
    /uzisavevar autosd%;\
    /uzisavevar recallwhenungrouped%;\
    /uzisavevar panicrecallcmd%;\
    /uzisavevar runninguzi%;\
    /uzisavevar gager%;\
    /uzisavevar usedrecalls%;\
    /uzisavetxt %;\
    /uzisavetxt ;;;Spells%;\
    /uzisavevar spellcaster%;\
    /uzisavevar damage%;\
    /uzisavevar autochange%;\
    /uzisavevar focusmana1%;\
    /uzisavevar focusmana2%;\
    /uzisavevar hidam%;\
    /uzisavevar midam%;\
    /uzisavetxt ;Hidams%;\
    /quote -S /uzisavevar `/listvar -s cdam_hi*%;\
    /uzisavetxt ;Midams%;\
    /quote -S /uzisavevar `/listvar -s cdam_lo*%;\
    /uzisavetxt ;Area dams%;\
    /quote -S /uzisavevar `/listvar -s cdam_area*%;\
    /uzisavetxt %;\
    /uzisavetxt ;;;Weapons%;\
    /uzisavevar quickdraw%;\
    /uzisavevar weapon%;\
    /quote -S /uzisavevar `/listvar -s *slay%;\
    /uzisavevar dopromptdamage%;\
    /uzisavevar cweap%;\
    /uzisavevar pweap%;\
    /uzisavetxt %;\
    /uzisavetxt ;;;Eq-settings%;\
    /uzisavevar getpotioncontainer%;\
    /uzisavevar potioncontainer%;\
    /uzisavevar getscrollcontainer%;\
    /uzisavevar scrollcontainer%;\
    /uzisavevar getweaponcontainer%;\
    /uzisavevar weaponcontainer%;\
    /uzisavevar container%;\
    /uzisavevar getfoodcont%;\
    /uzisavevar foodcont%;\
    /uzisavevar watercont%;\
    /uzisavevar getwatercont%;\
    /uzisavevar food%;\
    /uzisavevar abouteq%;\
    /uzisavevar feeteq%;\
    /uzisavevar shieldeq%;\
    /uzisavevar heldeq%;\
    /uzisavetxt %;\
    /uzisavetxt ;;;Misc%;\
    /uzisavevar botgroup%;\
    /uzisavevar copbot%;\
    /uzisavevar revcmd%;\
    /uzisavevar selfprot%;\
    /uzisavevar strspell%;\
    /uzisavevar solo%;\
    /uzisavevar botall%;\
    /uzisavevar amshield%;\
    /uzisavevar abmirror%;\
    /uzisavevar amirrorimage%;\
    /uzisavevar affield%;\
    /uzisavevar autoholy%;\
    /uzisavevar sanctype%;\
    /uzisavevar blessme%;\
    /uzisavevar autobuy%;\
    /uzisavevar afkexp%;\
    /uzisavevar afkwell%;\
    /uzisavetxt ;;;Heal%;\
    /uzisavevar groupinterval%;\
    /uzisavevar wellsumm%;\
    /uzisavevar aheal%;\
    /uzisavevar selfmira%;\
    /uzisavevar atmhp%;\
    /uzisavevar miratank%;\
    /uzisavevar thresh%;\
    /uzisavevar groupinterval%;\
    /uzisavevar groupbless%;\
    /uzisavevar truetank%;\
    /uzisavevar truegroup%;\
    /uzisavevar gpowgroup%;\
    /uzisavevar atthp%;\
    /uzisavevar atghp%;\
    /uzisavevar atgphp%;\
    /uzisavevar maxgpowcount%;\
    /uzisavevar ghealblind%;\
    /uzisavetxt ;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%;\
    /if (savequite=0) \
        /uecko Saved %{htxt2}Character %{ntxt}Settings.%;\
    /endif%;\
/endif

/set savesetup=0
/set saveconfig=0
;;;;;;;;;;;;;;;;;;;;;;
