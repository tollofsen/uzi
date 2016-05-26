;// vim: set ft=tf
;;;;;;;;;;;;;;;;;;;;;
; uzi Configuration ;
;;;;;;;;;;;;;;;;;;;;;

/def config = \
  /if ({1} =~ 'a') \
    /set char=%{-1}%;\
    /ecko Character set to: %{htxt2}%{-1}%;\
  /elseif ({1} =~ 'b') \
    /set container=%{-1}%;\
    /ecko Container set to: %{htxt2}%{-1}%;\
  /elseif ({1} =~ 'c') \
    /if ($[strlen({2})] == 5) \
      /set animist=0%;\
      /set fighter=0%;\
      /set magician=0%;\
      /set nightblade=0%;\
      /set priest=0%;\
      /set rogue=0%;\
      /set warlock=0%;\
      /set templar=0%;\
      /set charclassI=$[substr({2},0,2)]%;\
      /set charclassII=$[substr({2},3,2)]%;\
      /GettingCharClass %{charclassI}%;\
      /GettingCharClass %{charclassII}%;\
      /set charclass=%{charclassII}/%{charclassI}%;\
      /ecko Script now knows you're an%htxt2 %charclass%ntxt!%;\
    /else \
      /ecko Usage: /config c pr/pr (or whatever you are)%;\
    /endif%;\
  /elseif ({1} =~ 'd') \
    /set autowimpy=%{-1}%;\
    /ecko Autowimpy is now: %{htxt2}%{-1}%;\
  /elseif ({1} =~ 'e') \
    /set wimpylevel=%{-1}%;\
    /ecko Wimpylevel is set to: %{htxt2}%{-1}%;\
  /elseif ({1} =~ 'f') \
    /set autoassist=%{-1}%;\
    /ecko Autoassist is set to: %{htxt2}%{-1}%;\
  /elseif ({1} =~ 'g') \
    /set autofight=%{-1}%;\
    /ecko Autofight is now: %{htxt2}%{-1}%;\
  /elseif ({1} =~ 'h') \
    /set abouteq=%{-1}%;\
    /ecko You're about body is now: %{htxt2}%{-1}%;\
  /elseif ({1} =~ 'i') \
    /set feeteq=%{-1}%;\
    /ecko You're feet wear is now: %{htxt2}%{-1}%;\
  /elseif ({1} =~ 'j') \
    /set shieldeq=%{-1}%;\
    /ecko You're shield eq is now: %{htxt2}%{-1}%;\
  /elseif ({1} =~ 'j') \
    /set heldeq=%{-1}%;\
    /ecko You're held eq is now: %{htxt2}%{-1}%;\
  /elseif ({1} =~ 's') \
    /set saveconfig=1%;\
    /lood modules/saver.m%;\
  /else \
    /lood ans/config.ans%;\
  /endif

/def setup = \
  /if ({1} =~ 'a') \
    /set beepontells=%{-1}%;\
    /ecko Beep on tells set to: %{htxt2}%{-1}%;\
  /elseif ({1} =~ 'b') \
    /set criticalbeep=%{-1}%;\
    /ecko Critical beep set to: %{htxt2}%{-1}%;\
  /elseif ({1} =~ 'c') \
    /set tellogger=%{-1}%;\
    /ecko Tellogger set to: %{htxt2}%{-1}%;\
  /elseif ({1} =~ 'd') \
    /set logondeath=%{-1}%;\
    /ecko Deathlogger set to: %{htxt2}%{-1}%;\
  /elseif ({1} =~ 'e') \
    /set afkteller=%{-1}%;\
    /ecko Afk-teller set to: %{htxt2}%{-1}%;\
  /elseif ({1} =~ 'f') \
    /set afkmsg=%{-1}%;\
    /ecko Afk-msg set to: %{htxt2}%{-1}%;\
  /elseif ({1} =~ 'i') \
    /set autoreconnect=%{-1}%;\
    /ecko Autoreconnect set to: %{htxt2}%{-1}%;\
  /elseif ({1} =~ 'j') \
    /set showtellrows=%{-1}%;\
    /ecko Lines to show in tellog set to: %{htxt2}%{-1}%;\
  /elseif ({1} =~ 'k') \
    /set refolonleaderdeath=%{-1}%;\
    /ecko Refol when leader dies set to: %{htxt2}%{-1}%;\
  /elseif ({1} =~ 's') \
    /set savesetup=1%;\
    /lood modules/saver.m%;\
  /else \
    /lood ans/setup.ans%;\
  /endif

/def uhelp = \
  /if ({1} !~ '') \
        /echo -a -p %{htxt}=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%;\
  /endif%;\
  /if ({1} =~ 'mshield') \
    /ecko Turns auto-manashield casting for Warlock combos.%;\
    /ecko Usage: /mshield%;\
  /elseif ({1} =~ 'setwimp') \
    /ecko Sets the autowimpy level to chosen value.%;\
    /ecko Usage: /setwimp <wimplevel>%;\
  /elseif ({1} =~ 'affield') \
    /ecko Turns autocasting on Force Field. (lvl 55 magician)%;\
    /ecko Usage: /affield%;\
  /elseif ({1} =~ 'wimpy') \
    /ecko Turns wimpy on/off%;\
    /ecko Usage: /wimpy%;\
  /elseif ({1} =~ 'sstate') \
    /ecko Shows spells, weapons and skill state. (not finnished :P)%;\
    /ecko Usage: /sstate%;\
  /elseif ({1} =~ 'gags') \
    /ecko Changes gag type, first time gags on mobiles, second gags for all (including client gag on ultras)%;\
    /ecko Usage: /gags%;\
  /elseif ({1} =~ 'fight') \
    /ecko Turns autofight (casting spells, performing skills etc.) on/off%;\
    /ecko Usage: /fight%;\
  /elseif ({1} =~ 'as') \
    /ecko Turns autoassist on/off%;\
    /ecko Usage: /as%;\
  /elseif ({1} =~ 'loot') \
    /ecko Turns autolooting to on/off%;\
    /ecko Usage: /loot%;\
  /elseif ({1} =~ 'butcher') \
    /ecko Wether you wanna autobutcher or not. (might be spammy when killing lots of mobs, e.g. webs ;>)%;\
    /ecko Usage: /butcher%;\
  /elseif ({1} =~ 'aholy') \
    /ecko Sets aholy on/off, this can be used for any class. If you use it as a non-priest you will ask defined priest to cast holy or sanc.. to choose what to ask, use /set sanctype=<sanctype>%;\
    /ecko Usage: /aholy%;\
  /elseif ({1} =~ 'ma') \
    /ecko Defines wich Magician to drain mana from on arm,str,imp,fly.%;\
    /ecko Usage: /ma <magician>%;\
  /elseif ({1} =~ 'pr') \
    /ecko Defines wich Priest to use for holies etc.%;\
    /ecko Usage: /pr <priest>%;\
  /elseif ({1} =~ 'theme') \
    /ecko Uzi got theme support! Print /theme to get a list of avalible themes. (not many atm;>)%;\
    /ecko Usage: /theme <theme>%;\
  /elseif ({1} =~ 'weapon') \
    /ecko What sort of weapon damage would you like to use? Fire, unlife etc.%;\
    /ecko Usage: /weapon <damage>%;\
  /elseif ({1} =~ 'd') \
    /ecko What kind of damage spell would you like to use? Fire, unlife etc.%;\
    /ecko Usage: /d <damage> (Can also use /d murder,backstab,pwp or /d <hidam> <midam> <lodam>%;\
  /elseif ({1} =~ 't') \
    /ecko Change tank?%;\
    /ecko Usage: /t <tank>%;\
  /elseif ({1} =~ 'tells') \
    /ecko Shows tellog. (if tellogger is on)%;\
    /ecko Usage: /tells%;\
  /elseif ({1} =~ 'rtells') \
    /ecko Removes all previous tells.%;\
    /ecko Usage: /rtells%;\
  /elseif ({1} =~ 'asc') \
    /ecko Autospell/Autoskill changer: On/Off%;\
    /ecko Usage: /asc%;\
  /elseif ({1} =~ 'acop') \
    /ecko For autocopping, 4 diff types of options. (use aliases: copon or copoff for faster choices)%;\
    /ecko Usage: /acop%;\
  /elseif ({1} =~ 'foc') \
    /ecko Auto adrenal focus?%;\
    /ecko Usage: /foc%;\
  /elseif ({1} =~ 'afk') \
    /ecko Makes you go afk/ak in the client. (used for auto afk tells etc)%;\
    /ecko Usage: /afk <afk-reason>%;\
  /elseif ({1} =~ 'uptime') \
    /ecko Shows how long TinyFugue have been running! Without command will echo to screen, else try /uptime tell <char> etc.%;\
    /ecko Usage: /uptime <command>%;\
  /elseif ({1} =~ 'saveall') \
    /ecko This command will save the chars setting and the global settings.%;\
    /ecko Usage: /saveall%;\
  /elseif ({1} =~ 'solo') \
    /ecko Will set you as solo or 'unsolo';) .. if you are in solo mode, then blur, arm etc will be casted.%;\
    /ecko Usage: /solo%;\
  /elseif ({1} =~ 'abt') \
    /ecko To use bladeturn throu fights, use this options.%;\
    /ecko Usage: /abt%;\
  /elseif ({1} =~ 'speedies') \
    /ecko New feature in Uzi 0.7 is a whole new way of using speedwalks.%;\
    /ecko If you only print %htxt2/speedies oc%ntxt you will get a list of walks available in old continent.%;\
    /ecko You can use em by typing the command to the very left, as you notice to the right%;\
    /ecko there's something called 'rev', that's if you can speedwalk it reversible too. If%;\
    /ecko that's the case, start the speedie with %htxt2'..'%ntxt instead of '.'.%;\
    /ecko Example: %htxt2..speedwalk%ntxt walks it reverse, %htxt2.speedwalk%ntxt walks it normal%;\
    /ecko JUST like in zMUD! Wippie :)%;\
    /ecko You can also for example type %htxt2/speedies nc wg%ntxt to get a list for all speedwalk%;\
    /ecko that starts with wg (west gate). You can use %htxt2*a*%ntxt to get all walks with an a.%;\
    /ecko If the script only finds one speedwalk it will print the whole walk too.%;\
    /ecko And if you'd for some strange reason wants all speedwalks you can type%;\
    /ecko %htxt2/speedies *%;\
  /elseif ({1} =~ 'gc' | {1} =~ 'pc') \
    /ecko This command is very useful once you learn to use it. For example if you'd like%;\
    /ecko to pickup the Dirk from your weapon container wich is in your main container, you just type %htxt2\gc dirk%;\
    /ecko weapon %ntxt(shorter is just %htxt2gc dirk w%ntxt;>) instead of get weaponcontainer container bla bla.%;\
    /ecko Pc works exacly like that. (except it PUTS the thing, instead of GET the thing)%;\
    /ecko The '!' in the end of weapon, scroll etc means that if you, for another(!) example have scroll container%;\
    /ecko in the main container, will pick that one up, pick up whatever from scroll container, but won't put the%;\
    /ecko scroll container back into the main container. (tho, maybe only used in scripts;)%;\
    /ecko Usage: %htxt2\%{1} <object> %htxt[ s[croll][!] | w[eapon][!] | f[ood][!] | p[otion][!] | wa[ter][!]] [commands]%;\
  /else \
    /lood ans/help.ans%;\
  /endif%;\
  /if ({1} !~ '') \
        /echo -a -p %{htxt}=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%;\
  /endif

;;; things you do when you're bored ;) :
/def uzilogo = \
  /let _spacer=%ntxt                 %ntxt%;\
  /if ({1} =~ '1') \
    /echo -p %_spacer %b          _)%;\
    /echo -p %_spacer %b |   |_  / |%;\
    /echo -p %_spacer %B |   |  /  |%;\
    /echo -p %_spacer %Q\\__,_|___|_|%;\
  /elseif ({1} =~ '2') \
    /echo -p %_spacer %C             .__ %;\
    /echo -p %_spacer %C __ _________|__|%;\
    /echo -p %_spacer %c|  |  \\___   /  |%;\
    /echo -p %_spacer %c|  |  //    /|  |%;\
    /echo -p %_spacer %w|____//_____ \\__|%;\
    /echo -p %_spacer %w            \\/   %;\
  /elseif ({1} =~ '3') \
    /echo -p %_spacer %M            _____ %;\
    /echo -p %_spacer %M\____  _________(_)%;\
    /echo -p %_spacer %m\_  / / /__  /_  / %;\
    /echo -p %_spacer %m/ /_/ /__  /_  /  %;\
    /echo -p %_spacer %Q\\__,_/ _____/_/   %;\
  /elseif ({1} =~ '4') \
    /echo -p %_spacer  %Y               __    %;\
    /echo -p %_spacer  %Y\__  __  ____  %Q/%Y\\_\\   %;\
    /echo -p %_spacer /%Y\\ \\%Q/%Y\\ \\/\\_ ,`\\%Q\\/%Y\\ \\  %;\
    /echo -p %_spacer \\ %Y\\ \\_\\ \\%Q/_%Y/  /_%Q\\ %Y\\ \\ %;\
    /echo -p %_spacer  \\ %Y\\____/ /\\____\\%Q\\ %Y\\_\\%;\
    /echo -p %_spacer   \\/___/  \\/____/ \\/_/%;\
  /elseif ({1} =~ '5') \
    /echo -p %_spacer %E###  ### ######## ###%;\
    /echo -p %_spacer %E##%e!  %E###      ##%e! %E##%e!%;\
    /echo -p %_spacer %E#%e!%E#  %e!%E#%e!    %E#%e!!   !!%E#%;\
    /echo -p %_spacer %e!!%w:  %e!!!  !!%w:     %e!!%w:%;\
    /echo -p %_spacer  %w:%Q.%w:: :  :%Q.%w::%Q.%w: : :  %;\
  /elseif ({1} =~ '6') \
    /echo -p %_spacer %B              __ %;\
    /echo -p %_spacer %B.--.--.-----.|__|%;\
    /echo -p %_spacer %E|  |  |-- __||  |%;\
    /echo -p %_spacer %M|_____|_____||__|%;\
  /elseif ({1} =~ 'intro') \
    /echo -p %;\
    /uzilogo $[rand(1,3)]%;\
    /echo -p %_spacer%Q\u %W\z  %Q\i   %w\v%W%uziversion%;\
    /echo -p %;\
    /echo -p %;\
    /if (runninguzi !~ uziversion) \
      /set runninguzi=%uziversion%;\
      /uzinews%;\
    /endif%;\
  /else \
    /uzilogo $[rand(1,6)]%;\
  /endif

/def saveall = \
  /if ({1} =~ 'q') \
    /set savequite=1%;\
  /else \
    /set savequite=0%;\
  /endif%;\
  /set savesetup=1%;\
  /lood modules/saver.m%;\
  /set saveconfig=1%;\
  /lood modules/saver.m

/def uzinews = \
    /if ({1} =/ 'cdam' ) \
      /uecko There's now a new improved Change-Damage system.%;\
      /uecko With the new system you can add <whatever> type of damage%;\
      /uecko and it will automaticly be recognized if you try to change%;\
      /uecko to it and will also be saved. The same goes for the Change%;\
      /uecko Weapon script. To add a new damagetype you use the /newdamtype%;\
      /uecko command, and a new weapon type you type /addweapon%;\
      /uecko Type /newdamtype or /addweapon for more help.%;\
    /else \
        /echo -p %htxt2 New features in Uzi %uziversion you should try%;\
	/echo -p %htxt2 - More slay types added (use best iron/dark/unlife weapon as slay elf, etc)%;\
	/echo -p %htxt2 - Priests can now toggle self-miracle. (/selfmira)%;\
	/echo -p %htxt2 - Sleeping is now fully supported.%;\
	/echo -p %htxt2 - Improved nightblade support.%;\
        /echo -p %ntxt And %htxt2\DON'T%ntxt forget to run %htxt2/menu%ntxt now, new features, new settings.%;\
        /echo -p %htxt  - New Releases at :  *%;\
        /echo -p %htxt  - Report bugs at  :  To Azhure or Yoggin%;\
    /endif

/uzilogo intro
;;;;;
