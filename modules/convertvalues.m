;// vim: set ft=tf
;;;;;;;;; Feck, I suck at variable naming :P
/def -ag -p2147483647 -hREDEF gagredef

/def damageformatoldtonew = \
  /eval /set _newdamageformat=%%{cdam_%{1}}%;\
  /eval /set _olddamageformat=%%{%{1}}%;\
  /if (_newdamageformat =~ '' & _newdamageformat !~ _olddamageformat) \
    /if (convertwarning =~ '') \
      /uecko %Y WARNING! WARNING!%E Uzi $(/uziver) uses%Y NEW%E variable names for storing damage spells!%;\
      /uecko %E Uzi will now automaticly try to convert the old variables to the new variable names.%;\
      /uecko %E Type%Y /uzinews cdam%E to get more info!%;\
      /set convertwarning=1%;\
    /endif%;\
    /eval /set cdam_%{1}=%%{%{1}}%;\
    /eval /unset %{1}%;\
    /uecko %w CONVERT: %M%1%w moved to %M\cdam_%1%w   VALUE:%E %%{cdam_%{1}} %Y  OK?%;\
  /endif

/def damageconvertvalues = \
  /unset convertwarning%;\
  /mapcar /damageformatoldtonew %{*}%;\
  /if (convertwarning !~ '') \
    /uecko %E Done. You%Y SHOULD%E make sure that this went okey by running the%Y /menu!%;\
  /endif

/purge gagredef
/damageconvertvalues hinormal lonormal hifire lofire hiunlife lounlife hienergy loenergy hiice loice hiacid loacid hilight lolight hipoison lopoison hipure lopure
