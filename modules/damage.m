; // vim: set ft=tf:

;;;;;;;;;;;;;;;;;;;
;  SpellSwitcher  ;
;;;;;;;;;;;;;;;;;;;

/def careadam = \
    /set _newareadam=%;\
    /let i=1%;\
    /set _whilecheck=1%;\
    /while (_whilecheck!~'' & _newareadam=~'') \
        /eval /set _whilecheck=%%{%{i}}%;\
        /set _whilecheck=$[tolower(_whilecheck)]%;\
        /eval /set _newareadam=%%{cdam_area%{_whilecheck}}%;\
        /debug AREA: %i _newareadam=%_newareadam (%_whilecheck)%;\
        /let i=$[i +1]%;\
    /done%;\
    /if (_newareadam !~ '') \
        /set areadam=%_newareadam%;\
    /else \
        /set areadam=-%;\
    /endif

/def cattackdam = \
    /set _newhidam=%;\
    /set _newmidam=%;\
    /let i=1%;\
    /set _whilecheck=1%;\
    /while (_whilecheck!~'' & (_newhidam=~'')) \
        /eval /set _whilecheck=%%{%{i}}%;\
        /set _whilecheck=$[tolower(_whilecheck)]%;\
        /if ((_whilecheck =/ 'backstab' & rogue > 0) | (_whilecheck =/ 'murder' & nightblade > 0)) \
            /set _newmidam=%_whilecheck%;\
            /set _newhidam=%_whilecheck%;\
        /else \
            /eval /set _newhidam=%%{cdam_hi%{_whilecheck}}%;\
            /eval /set _newmidam=%%{cdam_lo%{_whilecheck}}%;\
        /endif%;\
        /debug NORMAL: %i _newmidam=%_newmidam _newhidam=%_newhidam (%_whilecheck)%;\
        /let i=$[i +1]%;\
    /done%;\
    /if (_newhidam=~'') \
        /set _newhidam=-%;\
    /endif%;\
    /if (_newmidam=~'') \
        /set _newmidam=-%;\
    /endif%;\
    /if (lodam=~'') \
        /set lodam=-%;\
    /endif%;\
    /if (_newhidam !~ '-' & (_newmidam !~ midam | _newhidam !~ hidam)) \
        /set hidam=%{_newhidam}%;\
        /set midam=%{_newmidam}%;\
        /if (substr(_whilecheck, 0, 4) =/ 'slay') \
            /set _whilecheck=$[substr(_whilecheck, 0, 4)]$[toupper(substr(_whilecheck, 4))]%;\
        /endif%;\
        /let _newdamtype=$[strcat(toupper(substr({_whilecheck}, 0, 1)), substr({_whilecheck}, 1))]%;\
        /ecko %htxt(%htxt2\CDAM%htxt) %ntxt\Magic Spells%ntxt2: %htxt%_newdamtype %htxt(%ntxt\Hi%ntxt2:%htxt2%hidam %ntxt\Mid%ntxt2:%htxt2%midam %ntxt\Lo%ntxt2:%htxt2%lodam%htxt %ntxt\Area%ntxt2:%htxt2%areadam%htxt)%;\
    /endif

/def d = \
    /let _d_input=$[replace('slay ', 'slay', {*})]%;\
    /let _d_input=$[replace('horgar', 'fire', _d_input)]%;\
    /careadam %_d_input normal%;\
    /cattackdam %_d_input normal

/def newdamtype = \
    /if ({1} !~ '' & {2} !~ '' & {3} !~ '') \
        /let _newdamtype=$[tolower({1})]%;\
        /eval /set cdam_hi%{_newdamtype}=%{2}%;\
        /eval /set cdam_lo%{_newdamtype}=%{3}%;\
        /eval /set cdam_area%{_newdamtype}=%{4}%;\
        /ecko Added:%htxt2 %_newdamtype%ntxt To use it type%htxt2 /d %_newdamtype%;\
    /else \
        /uecko Usage: /newdamtype <type> <hidam> <midam> [<areaspell>]%;\
    /endif

/def fight= \
    /if (autofight!=1) \
        /ecko AUTO-FIGHT %htxt2\Enabled.%; \
        /set autofight=1%; \
    /else \
        /ecko AUTO-FIGHT %htxt2\Disabled%; \
        /set autofight=0%; \
    /endif

/def asc=/if (autochange!=1) \
    /set autochange=1%;/ecko Autospellchanging %{htxt2}ON%; \
/else \
    /set autochange=0%;/ecko Autospellchanging %{htxt2}OFF%; \
/endif

;;;;;;;;;;;;;
;SpellStatus;
;;;;;;;;;;;;;
/set spellist unlife fire ice normal pure poison light
/set skillist=autochange autospell-change autofight autofight autoberserk autoberserker cweap change-weapon pweap put-weapon truetank TrueTank truegroup TrueGroup miratank MiraTank gpowgroup GpowGroup

/def sstate = \
    /echo -a -p %{htxt}=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- %{htxt2}Current  State %{htxt}-=-=-=-=-=-=%;\
    /let _spellist=%{spellist}%;\
    /let _skillist=%{skillist}%;\
    /let _menudesc1=Autospells:%;\
    /let _menudesc2=Autoskills:%;\
    /eval /echo -a -p %{htxt2} $[pad(_menudesc1, 4+strlen(_menudesc2), _menudesc2, 38+strlen(_menudesc2)-strlen(_menudesc1))]%;\
    /while (_skillist!/'' | _spellist!/'') \
        /let _tmpskill=%;\
        /let _tmpskillname=%;\
        /let _tmpspell=%;\
        /let _tmpskill=$(/car %{_skillist})%;\
        /let _tmpskillname=$(/car $(/cdr %{_skillist}))%;\
        /let _skillist=$(/cdr $(/cdr %{_skillist}))%;\
        /let _tmpspell=$(/car %{_spellist})%;\
        /let _spellist=$(/cdr %{_spellist})%;\
        /eval /set _tmpskillvalue=%%{%{_tmpskill}}%;\
        /eval /set _tmpspellvalue=%%{cdam_hi%{_tmpspell}}/%%{cdam_lo%{_tmpspell}}%;\
        /if (_tmpskillvalue=~'1') \
            /set _tmpskillvalue=on%;\
        /elseif (_tmpskillvalue=~'0') \
            /set _tmpskillvalue=off%;\
        /endif%;\
        /if (_tmpspellvalue=~'1') \
            /set _tmpspellvalue=on%;\
        /elseif (_tmpspellvalue=~'0') \
            /set _tmpspellvalue=off%;\
        /endif%;\
        /eval /showspelllayout %{_tmpspell-off} %{_tmpspellvalue-off} %{_tmpskillname-off} %{_tmpskillvalue-off}%;\
        /unset _tmpskillvalue%;\
        /unset _tmpspellvalue%;\
    /done%;\
    /echo -a -p %{htxt}=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

/def showspellstate = \
    /let _word=%1%;\
    /let _result=%;\
    /while (shift(), {#}) \
        /eval /set templo=%%{hi%{1}}%;\
        /if ({templo}!~'') \
            /showspelllayout %{1} %{templo}%;\
            /ecko %{1} %{templo}%;\
        /else \
            /ecko %{1} spell: Notdefined%;\
        /endif%;\
        /unset templo%;\
    /done

/def showspelllayout = \
    /let _showspell_len=$[20-strlen({1})]%;\
    /let _showspell_break=.%;\
    /while (_showspell_len >= 0) \
        /let _showspell_len=$[{_showspell_len}-1]%;\
        /let _showspell_break=.%{_showspell_break}%;\
    /done%;\
    /let _showspell_break2=o %;\
    /let _showspell_len=$[10-strlen({2})]%;\
    /while (_showspell_len >= 0) \
        /let _showspell_len=$[{_showspell_len}-1]%;\
        /let _showspell_break2= %{_showspell_break2}%;\
    /done%;\
    /let _showspell_break3=.%;\
    /let _showspell_len=$[20-strlen({3})]%;\
    /while (_showspell_len >= 0) \
        /let _showspell_len=$[{_showspell_len}-1]%;\
        /let _showspell_break3=.%{_showspell_break3}%;\
    /done%;\
    /if ({1}=~'off' & {3}!~'off') \
        /let _showspell_len=26%;\
        /let _showspell_break4=%{ntxt2} %;\
        /while (_showspell_len >= 0) \
            /let _showspell_len=$[{_showspell_len}-1]%;\
            /let _showspell_break4= %{_showspell_break4}%;\
        /done%;\
    /endif%;\
    /let _showspell_part2=%{ntxt2}%{_showspell_break4}%{_showspell_part2}%;\
    /if ({1}!~'off') \
        /let _showspell_part1=%{ntxt2} o %{_showspell_break}%{ntxt}%{1} %{htxt2}$[tolower({2})]%;\
    /endif%;\
    /if ({3}!~'off') \
        /let _showspell_part2=%{ntxt2} %{_showspell_break4} %{_showspell_break2} %{_showspell_break3}%{ntxt}%{3} %{htxt2} $[tolower({4})]%;\
    /endif%;\
    /eval /echo -a -p %ntxt2%_showspell_part1%_showspell_part2
;;



;;;;;;;;;;;;;;;;;
;; Areaspells  ;;
;;;;;;;;;;;;;;;;;

/def area_checkroom = \
    /if (countmob=1) \
        /if (aggmob>1 & mobs >1 & aggmob>=mobs & areafight=0 & (race=~'ktv'|slife=1)) \
            /set areafight=1%;\
            /set aggarea=1%;\
        /endif%;\
    /endif%;\
    /set countmob=0
