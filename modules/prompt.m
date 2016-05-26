;// vim: set ft=tf

;;;;;;;;;;;;;;;;
;Prompt Hoooker;
;;;;;;;;;;;;;;;;
/set leftp=(
/set rightp=)
/set manab=M
/set charprompt=:  
/set hpb=H
/set moveb=V
/if ({char}=~'') /set char=Unknown%;/endif
;/set status_int_clock=ftime("%H:%M", time())
;/set status_int_mail=!nmail() ? "" : nmail()==1 ? "(Mail)" : pad("Mail", 0, nmail(), 2)
;/def setstatusfields = \
;  /set status_fields=@more:8:Br :1 @world :1 @read:6 :1 @active:11 :1 @log:5 :1 @mail:6 :1 insert:6 :1 @clock:5

/def autospellchanger = \
    /if (autochange=1 & areaspells=1 & areafight=1 & currentmana > areamana1) \
        /if (damage !~ areadam) \
            /ecko %htxt(%htxt2\AREA-DAM%htxt) %ntxt\Mana higher then%ntxt2: %htxt%areamana1 %htxt(%ntxt\Damage%ntxt2:%htxt2%areadam%htxt)%;\
            /set damage=%areadam%;\
            /if (fighting=1) \
                /set lspell=%areadam%;\
            /endif%;\
        /endif%;\
    /elseif (autochange=1)\
        /if (currentmana>manatest1) \
            /if (damage!~hidam) \
                /ecko %htxt(%htxt2\ASC%htxt) %ntxt\Mana higher then%ntxt2: %htxt%manatest1 %htxt(%ntxt\Damage%ntxt2:%htxt2%hidam%htxt)%;\
                /set damage=%hidam%;\
                /if (fighting=1) \
                    /set lspell=%hidam%;\
                /endif%;\
            /endif%;\
        /elseif (currentmana>manatest2) \
            /if (damage!~midam) \
                /if (damage=~lodam) \
                    /ecko %htxt(%htxt2\ASC%htxt) %ntxt\Mana higher then%ntxt2: %htxt%manatest2 %htxt(%ntxt\Damage%ntxt2:%htxt2%midam%htxt)%;\
                /else \
                    /ecko %htxt(%htxt2\ASC%htxt) %ntxt\Mana less then%ntxt2: %htxt%manatest1 %htxt(%ntxt\Damage%ntxt2:%htxt2%midam%htxt)%;\
                /endif%;\
                /set damage %midam%;\
                /if (fighting=1) \
                    /set lspell=%hidam%;\
                /endif%;\
            /endif%;\
        /elseif (currentmana<=manatest2) \
            /if (damage!~lodam) \
                /ecko %htxt(%htxt2\ASC%htxt) %ntxt\Mana less then%ntxt2: %htxt%manatest2 %htxt(%ntxt\Damage%ntxt2:%htxt2%lodam%htxt)%;\
                /set damage %lodam%;\
                /if (fighting=1) \
                    /set lspell=%hidam%;\
                /endif%;\
            /endif%;\
        /endif%;\
    /endif

/def copyprompttofield = \
    /set prohp=$[(%{currenthp}*100)/%{maxhp}]%;\
    /set promana=$[(%{currentmana}*100)/%{maxmana}]%;\
    /set promove=$[(%{currentmove}*100)/%{maxmove}]%;\
    /if (prohp>90) \
        /set hpcolor=BCgreen%;\
    /elseif (prohp>75) \
        /set hpcolor=nCgreen%;\
    /elseif (prohp>30) \
        /set hpcolor=nCwhite%;\
    /elseif (prohp>15) \
        /set hpcolor=nCred%;\
    /else \
        /set hpcolor=BCred%;\
    /endif%;\
    /if (promana>90) \
        /set manacolor=xBCgreen%;\
    /elseif (promana>75) \
        /set manacolor=nxCgreen%;\
    /elseif (promana>30) \
        /set manacolor=xnCwhite%;\
    /elseif (promana>15) \
        /set manacolor=xCred%;\
    /else \
        /set manacolor=xnBCred%;\
    /endif%;\
    /if (promove>90) \
        /set movecolor=BCgreen%;\
    /elseif (promove>75) \
        /set movecolor=nCgreen%;\
    /elseif (promove>30) \
        /set movecolor=nCwhite%;\
    /elseif (promove>15) \
        /set movecolor=nCred%;\
    /else \
        /set movecolor=BCred%;\
    /endif

/def getlentoprompt = \
    /set charval=$[strlen(char)]%;\
    /set mhpval=$[strlen(maxhp)]%;\
    /set chpval=$[strlen(currenthp)]%;\
    /set mmaval=$[strlen(maxmana)]%;\
    /set cmaval=$[strlen(currentmana)]%;\
    /set mmoval=$[strlen(maxmove)]%;\
    /set wrlval=$[strlen(${world_name})]%;\
    /set cmoval=$[strlen(currentmove)]

/def extraonprompt = \
    /if (isafk=1) \
        /set status_var_afk=afk%;\
        /eval /set status_var_round_afk1=%{status_afk_fillout_left}%;\
        /eval /set status_var_round_afk2=%{status_afk_fillout_right}%;\
    /else \
        /set status_var_afk= %;\
        /set status_var_round_afk1= %;\
        /set status_var_round_afk2= %;\
    /endif%;\
    /set newmails=$[nmail()]

/def checkwalk = \
    /if (((currentmove < 20 & fly=1) | (currentmove < 40 & fly=0)) & lowwalk!=1) \
        /set lowwalk=1%;\
        /repeat -0:01:00 1 /set lowwalk=0%;\
        /if (priest>0) \
            cast 'revitalize' self%;\
        /elseif (ismember(askpr, gplist) =~ 1) \
            ask %askpr rev%;\
        /elseif (revcmd !~ '') \
            /eval %revcmd%;\
        /else \
            /ecko Sooooon out of walk! Use /setrev <mudalias> to make a rev command or /pr <priest>.%;\
            ps%;\
        /endif%;\
    /endif

/def setrev = \
    /set revcmd %*%;\
    /ecko You will now revitalize yourself with: %*

/set report_hp_changes=0
/set report_hp_threshold=20

/def -i report_hp = \
    /if (!regmatch("[0-9]+",%1)) \
        /echo -aBCwhite Usage: /report threshold%;\
        /echo -aBCwhite Threshold is the minimum change required to trigger the report.%;\
        /echo -aBCwhite Setting the thhreshold to 0 disables the reporter.%;\
    /else \
        /if (%1>0) \
            /if (report_hp_changes=0) \
                /set report_hp_changes=1%;\
                /echo -aBCWwhite Reporting enabled.%;\
            /endif%;\
            /set report_hp_threshold=%1%;\
            /echo -aBCwhite Threshold set to %1.%;\
        /else \
            /set report_hp_threshold=0%;\
            /set report_hp_changes=0%;\
            /echo -aBCwhite -p Reporting disabled.%;\
        /endif%;\
    /endif

/def withered_stats = \
    /echo Drains:  %{withered_drains}%;\
    /echo Amount:  %{withered_amount}%;\
    /echo Average: %{withered_average}

/def -E{withered_drained}==0 -mglob -F -t"Your aura drains some of *'s magical power." triggerwitheredcheck = \
    /set withered_drained=1

/def -q -p10 -F -mregexp -t'^([0-9]+)\(([0-9]+)\)H (|-)([0-9]+)\(([0-9]+)\)M ([0-9]+)\(([0-9]+)\)V >' prt=\
    /let oldprtchecker=%{currenthp}%{currentmana}%{currentmove}%;\
    /let prtchecker=%P1%P3%P4%P6%;\
    /if (report_hp_changes=1) \
        /let _hpdiff=$[%currenthp - %P1]%;\
        /let _manadiff=$[%currentmana - strcat({P3},{P4})]%;\
        /let _out=%;\
        /if (_hpdiff >= %report_hp_threshold) \
            /let _out=@{BCred}-%{_hpdiff}@{nCwhite} HP%;\
        /elseif (_hpdiff <= $[-1 * %report_hp_threshold]) \
            /let _out=@{BCgreen}+$[-1 * %{_hpdiff}]@{nCwhite} HP%;\
        /endif%;\
        /if (_manadiff >= 1) \
            /let _out=%{_out} @{BCred}-%{_manadiff}@{nCwhite} MP%;\
        /elseif (_manadiff <= $[-1 * 1]) \
            /let _out=%{_out} @{BCgreen}+$[-1 * %{_manadiff}]@{nCwhite} MP%;\
        /endif%;\
        /if (withered_drained) \
            /set withered_drained=0%;\
            /test ++withered_drains%;\
            /set withered_amount=$[{withered_amount}+(-1*{_manadiff})]%;\
            /set withered_average=$[{withered_amount}/{withered_drains}]%;\
            /withered_stats%;\
        /endif%;\
        /if ($[strlen(_out)]) \
            /echo -aBCwhite -p : @{nCwhite}%{_out}%;\
        /endif%;\
    /endif%;\
    /set currenthp=%P1%;\
    /set currentmana=%P3%P4%;\
    /set currentmove=%P6%;\
    /onpromptrescue%;\
    /if (prtchecker!~oldprtchecker | status_redraw=1) \
        /set status_redraw=0%;\
        /set maxhp=%P2%;\
        /set maxmana=%P5%;\
        /set maxmove=%P7%;\
        /set prompt=%{currenthp}(%{maxhp})H %{currentmana}(%{maxmana})M %{currentmove}(%{maxmove})V >%;\
        /copyprompttofield%;\
        /getlentoprompt%;\
        /extraonprompt%;\
        /setstatusfields%;\
        /checkwimp%;\
        /checkwalk%;\
    /else \
        /set oi=1%;\
    /endif%;\
    /autospellchanger%;\
    /promptdamage%;\
    /if (gagprompt=1) \
        /substitute %PR%;\
    /endif

/def -q -p10 -F -mregexp -t'^([0-9]+)H (|-)([0-9]+)M ([0-9]+)V Vis\:([0-9]+) >' prt_imm=\
    /set currenthp=%{P1}%;\
    /set maxhp=%{P1}%;\
    /set currentmana=%{P3}%;\
    /set maxmana=%{P3}%;\
    /set currentmove=%{P4}%;\
    /set maxmove=%{P4}%;\
    /set wiz_vis_level=%{P5}%;\
    /if (status_redraw=1) \
        /set status_redraw=0%;\
        /set prompt=%{currenthp}H %{currentmana}M %{currentmove}V Vis:%{vis_lev} >%;\
        /copyprompttofield%;\
        /getlentoprompt%;\
        /extraonprompt%;\
        /setstatusfields%;\
        /checkwimp%;\
        /checkwalk%;\
    /else \
        /set oi=1%;\
    /endif%;\
    /autospellchanger%;\
    /promptdamage%;\
    /if (gagprompt=1) \
        /substitute %PR%;\
    /endif

/def -q -p10 -F -aG -mregexp -t'OLC Zone: ([0-9]+) > ' prt_imm_olc=\
    /let oldprtchecker=111%;\
    /let prtchecker=111%;\
    /set currenthp=1000%;\
    /set currentmana=1000%;\
    /set currentmove=1000%;\
    /if (prtchecker!~oldprtchecker | status_redraw=1) \
        /set status_redraw=0%;\
        /set maxhp=1000%;\
        /set maxmana=1000%;\
        /set maxmove=1000%;\
        /set prompt=OLC Zone: %P1 >%;\
        /copyprompttofield%;\
        /getlentoprompt%;\
        /extraonprompt%;\
        /setstatusfields%;\
    /else \
        /set oi=1%;\
        /set olc=%{P1}%;\
    /endif%;\
    /if (gagprompt=1) \
        /substitute %PR%;\
    /endif

;;;

