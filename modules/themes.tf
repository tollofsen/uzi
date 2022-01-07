/def themes = /theme %*

/def theme = \
  /if ({1} =~ '') \
    /set _themeshowcount=0%;\
    /eval /quote -S /themeshow !for i in %{uzidirectory}/themes/*.th; do grep '\;theme' \\\$i\; done%;\
    /unset _themeshowcount%;\
  /else \
    /file_exists %{uzidirectory}/themes/%{*}.th%;\
    /if (visual=~'off') \
      /ecko You had visual %{htxt2}%{ntxt}, reasons can be that you tried a theme that needed a higher \
              resolution or it just was off.. turning it on.%;\
      /set visual=on%;\
      /set status_fields="..::(Will be updated soon)::.."%;\
    /endif%;\
    /if (file_exists=1) \
      /lood themes/%{*}.th%;\
      /lood themes/%{*}.prt%;\
      /eval /quote -S /themeshow setvar !cat %{uzidirectory}/themes/%{*}.th | grep '\;theme'%;\
      /ecko Loaded theme file %{ntxt2}[%{ntxt}%{themename}.th%{ntxt2}] %{ntxt}by %{themeauth} %{ntxt2}(%{ntxt}%{themedesc}%{ntxt2})%;\
      /eval /set themetoload=%{*}%;\
    /else \
      /ecko What theme would you like to use? Try %{htxt2}/themes %{ntxt}for a complete list.%;\
    /endif%;\
  /endif

/def themeshow = \
  /if ({1}=~'setvar') \
    /eval /set theme%{3}=%{-3}%;\
  /else \
    /set _themeshowcount=$[{_themeshowcount}+1]%;\
    /eval /set %{2}=%{-2}%;\
    /if (_themeshowcount >= 3) \
      /set name2=%htxt2$[strrep('.', (15-strlen({name})))]%{name}%;\
      /set auth2=%ntxt$[strrep('.', (10-strlen({auth})))]%{auth}%;\
      /set desc2=%ntxt2$[strrep('.', (25-strlen({desc})))]%{desc}%;\
      /ecko %n $[pad({name2}, "30", {auth2}, "25", {desc2}, "40")]%;\
      /set _themeshowcount=0%;\
    /endif%;\
  /endif


/def themes2 = \
  /if ({1} =~ '') \
    /set _themecount=0%;\
    /eval /quote -S /themeshow2 !for i in %{uzidirectory}/themes/*.th; do grep '\;theme' \\\$i\; done%;\
    /unset _themecount%;\
  /else \
    /file_exists %{uzidirectory}/themes/%{*}.th%;\
    /if (file_exists=1) \
      /lood themes/%{*}.th%;\
      /lood themes/%{*}.prt%;\
      /eval /quote -S /themeshow setvar !cat %{uzidirectory}/themes/%{*}.th | grep '\;theme'%;\
      /ecko Loaded theme file %{ntxt2}[%{ntxt}%{themename}.th%{ntxt2}] %{ntxt}by %{themeauth} %{ntxt2}(%{ntxt}%{themedesc}%{ntxt2})%;\
    /else \
      /ecko What theme would you like to use? Try %{htxt2}/themes %{ntxt}for a complete list.%;\
    /endif%;\
  /endif

/if ({themetoload}=~'') \
  /theme default%;\
  /set gagprompt=1%;\
/elseif ({themetoload}!~'') \
  /theme %{themetoload}%;\
/endif

/def themeshow2 = \
  /if ({1}=~'setvar') \
    /set _themeshowcount=$[{_themeshowcount}+1]%;\
    /eval /set %{2}=%{-2}%;\
    /if (_themeshowcount >= 3) \
      /set name2=%htxt2$[strrep('.', (15-strlen({name})))]%{name}%;\
      /set auth2=%ntxt$[strrep('.', (10-strlen({auth})))]%{auth}%;\
      /set desc2=%ntxt2$[strrep('.', (25-strlen({desc})))]%{desc}%;\
      /ecko %n $[pad({name2}, "30", {auth2}, "25", {desc2}, "40")]%;\
      /set _themeshowcount=0%;\
    /endif%;\
    /echo -a -p %{htxt}=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=- %{htxt2}Supported Themes %{htxt}-=-=-=-=-=-=%;\
    /let _spellist=%{spellist}%;\
    /let _skillist=%{skillist}%;\
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
      /eval /set _tmpspellvalue=%%{hi%{_tmpspell}}%;\
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
      /eval /showspelllayout %{_tmpskillname-off} %{_tmpskillvalue-off} %{_tmpspell-off} %{_tmpspellvalue-off}%;\
      /unset _tmpskillvalue%;\
      /unset _tmpspellvalue%;\
    /done%;\
    /echo -a -p %{htxt}=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=


/def themelayout = \
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
    /let _showspell_len=28%;\
    /let _showspell_break4=%{ntxt2} %;\
    /while (_showspell_len >= 0) \
      /let _showspell_len=$[{_showspell_len}-1]%;\
      /let _showspell_break4= %{_showspell_break4}%;\
    /done%;\
  /endif%;\
  /let _showspell_part2=%{ntxt2}%{_showspell_break4}%{_showspell_part2}%;\
  /if ({1}!~'off') \
    /let _showspell_part1=%{ntxt2} o %{_showspell_break}%{ntxt}%{1} %{htxt2}$[tolower(%{2})]%;\
  /endif%;\
  /if ({3}!~'off') \
    /let _showspell_part2=%{ntxt2} %{_showspell_break4} %{_showspell_break2} %{_showspell_break3}%{ntxt}%{3} %{htxt2} $[tolower({4})]%;\
  /endif%;\
  /eval /echo -a -p %ntxt2%_showspell_part1%_showspell_part2
;;  
