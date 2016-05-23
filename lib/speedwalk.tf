
;;;; Speedwalk
;;;; "/speedwalk" toggles speedwalking.  With speedwalking enabled, you can
;;;; type multiple directions on a single line, similar to tintin.  Any line
;;;; containing only numbers and the letters "n", "s", "e", "w", "u", and
;;;; "d" are interpreted by speedwalk; other lines are left alone (of course,
;;;; to guarantee that lines don't get interpreted, you should turn speedwalk
;;;; off).  Each letter is sent individually; if it is preceeded by a number,
;;;; it will be repeated that many times.  For example, with speedwalk
;;;; enabled, typing "ne3ses" will send "n", "e", "s", "s", "s", "e", "s".


/loaded __TFLIB__/spedwalk.tf

/eval \
    /def -i speedwalk = \
        /if /ismacro ~speedwalk%%; /then \
            /ecko Speedwalking is now %%{htxt2}Disabled%%{ntxt}!%%;\
            /undef ~speedwalk%%;\
        /else \
            /ecko Speedwalking is now %%{htxt2}Enabled%%{ntxt}!%%;\
;           NOT fallthru, so _map_send in map.tf won't catch it too.
            /def -ip%{maxpri} -mregexp -h'send ^[nsewud0-9]+$$$' ~speedwalk = \
                /~do_speedwalk %%%*%%;\
        /endif

/def sw = /speedwalk

/def -i ~do_speedwalk = \
    /let _string=%;\
    /let _count=%;\
    /let _c=%;\
    /let _i=-1%;\
    /set _lastwalkdir=%*%;\
    /if (_lastwalkdir!~'news') \
      /while ( (_c:=substr(_lastwalkdir, ++_i, 1)) !~ "" ) \
          /if ( _c =/ "[0-9]" ) \
              /@test _count:= strcat(_count, _c)%;\
          /elseif ( regmatch("[nsewud]", _c) ) \
              /if ( _string !~ "" ) /send - %{_string}%; /endif%;\
              /let _string=%;\
              /for _j 1 %{_count-1} /~do_speedwalk_aux %{_c}%;\
              /let _count=%;\
          /else \
              /@test _string:= strcat(_string, _count, _c)%;\
              /let _count=%;\
          /endif%;\
      /done%;\
      /let _string=%{_string}%{_count}%;\
      /if ( _string !~ "" ) /send - %{_string}%; /endif%;\
    /else \
      /send %_lastwalkdir%;\
    /endif

/def -i revwalk = \
; will reverse a speedwalk
    /let _word=%*%;\
    /let _i=$[strlen({*})-1]%;\
    /let _j=-1%;\
    /while (_i > _j) \
      /let _j=$[{_j}+1]%;\
      /let _str=$[substr(_word, _j, 1)]%;\
      /if (regmatch("[nsewud]", _str) ) \
        /if (_str =~ 'n') /let _str=s%;\
        /elseif (_str =~ 's') /let _str=n%;\
        /elseif (_str =~ 'w') /let _str=e%;\
        /elseif (_str =~ 'e') /let _str=w%;\
        /elseif (_str =~ 'u') /let _str=d%;\
        /elseif (_str =~ 'd') /let _str=u%;\
        /endif%;\
        /let _walk=%_addon%_str%_walk%;\
        /let _addon=%;\
      /elseif (_str =/ "[0-9]") \
        /let _addon=%_str%_addon%;\
      /endif%;\
    /done%;\
    /return _walk


/def -i ~do_speedwalk_aux = \
;   _map_hook may be defined if map.tf was loaded.
    /if /ismacro _map_hook%; /then \
        /_map_hook %*%;\
    /endif%;\
    /send %*

/speedwalk
