; // vim: set ft=tf:

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
/set warn_status=off

/def autospellchanger = \
    /if (autochange=1 & areafight=1 & currentmana > manatest2 & areadam !~'' & areadam!~'-') \
        /if (damage !~ areadam) \
            /ecko %htxt(%htxt2\AREA-DAM%htxt) %ntxt\Mana higher then%ntxt2: %htxt%manatest2 %htxt(%ntxt\Damage%ntxt2:%htxt2%areadam%htxt)%;\
            /set damage=%areadam%;\
        /endif%;\
    /elseif (autochange=1)\
        /if ((rogue|nightblade)>0 & (warlock|magician|templar|animist|fighter)>0) \
            /if (cantstab=1) \
                /if (currentmana>manatest2) \
                    /if (damage!~midam) \
                        /ecko %htxt(%htxt2\ASC%htxt) %ntxt\Unable to backstab%ntxt2: %htxt%manatest1 %htxt(%ntxt\Damage%ntxt2:%htxt2%midam%htxt)%;\
                        /set damage=%midam%;\
                    /endif%;\
                /elseif (currentmana<manatest2) \
                    /if (damage!~lodam) \
                        /ecko %htxt(%htxt2\ASC%htxt) %ntxt\Unable to backstab%ntxt2: %htxt%manatest1 %htxt(%ntxt\Damage%ntxt2:%htxt2%lodam%htxt)%;\
                        /set damage=%lodam%;\
                    /endif%;\
                /endif%;\
            /else \
                /if (currentmana>manatest1) \
                    /if (damage!~hidam) \
                        /ecko %htxt(%htxt2\ASC%htxt) %ntxt\Mana higher then%ntxt2: %htxt%manatest1 %htxt(%ntxt\Damage%ntxt2:%htxt2%hidam%htxt)%;\
                        /set damage=%hidam%;\
                    /endif%;\
                /else \
                    /if (rogue>0) \
                        /if (damage!~'ba') \
                            /set damage=ba%;\
                            /ecko %htxt(%htxt2\ASC%htxt) %ntxt\Mana lower then%ntxt2: %htxt%manatest1 %htxt(%ntxt\Damage%ntxt2:%htxt2%damage%htxt)%;\
                        /endif%;\
                    /else \
                        /if (damage!~'m') \
                            /set damage=m%;\
                            /ecko %htxt(%htxt2\ASC%htxt) %ntxt\Mana lower then%ntxt2: %htxt%manatest1 %htxt(%ntxt\Damage%ntxt2:%htxt2%damage%htxt)%;\
                        /endif%;\
                    /endif%;\
                /endif%;\
            /endif%;\
        /elseif (currentmana>manatest1) \
            /if (damage!~hidam) \
                /ecko %htxt(%htxt2\ASC%htxt) %ntxt\Mana higher then%ntxt2: %htxt%manatest1 %htxt(%ntxt\Damage%ntxt2:%htxt2%hidam%htxt)%;\
                /set damage=%hidam%;\
            /endif%;\
        /elseif (currentmana>manatest2) \
            /if (damage!~midam) \
                /if (damage=~lodam) \
                    /ecko %htxt(%htxt2\ASC%htxt) %ntxt\Mana higher then%ntxt2: %htxt%manatest2 %htxt(%ntxt\Damage%ntxt2:%htxt2%midam%htxt)%;\
                /else \
                    /ecko %htxt(%htxt2\ASC%htxt) %ntxt\Mana less then%ntxt2: %htxt%manatest1 %htxt(%ntxt\Damage%ntxt2:%htxt2%midam%htxt)%;\
                /endif%;\
                /set damage=%midam%;\
            /endif%;\
        /elseif (currentmana<=manatest2) \
            /if (damage!~lodam) \
                /ecko %htxt(%htxt2\ASC%htxt) %ntxt\Mana less then%ntxt2: %htxt%manatest2 %htxt(%ntxt\Damage%ntxt2:%htxt2%lodam%htxt)%;\
                /set damage=%lodam%;\
            /endif%;\
        /endif%;\
    /endif

/def copyprompttofield = \
    /set prohp=$[(currenthp*100)/maxhp]%;\
    /set promana=$[(currentmana*100)/maxmana]%;\
    /set promove=$[(currentmove*100)/maxmove]%;\
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
            /if (ingroup=1) \
                ps%;\
            /endif%;\
        /endif%;\
    /endif

/def setrev = \
    /set revcmd %*%;\
    /ecko You will now revitalize yourself with: %*


/def -p1 -F -mregexp -h'PROMPT ^([0-9]+)\(([0-9]+)\)H (|-)([0-9]+)\(([0-9]+)\)M ([0-9]+)\(([0-9]+)\)V >' prt=\
    /set playing=1%;\
    /let oldprtchecker=%{currenthp}%{currentmana}%{currentmove}%;\
    /let prtchecker=%P1%P3%P4%P6%;\
    /set currenthp=%P1%;\
    /set currentmana=%P3%P4%;\
    /set currentmove=%P6%;\
    /onpromptrescue%;\
    /set maxhp=%P2%;\
    /set maxmana=%P5%;\
    /set maxmove=%P7%;\
    /set prompt=%{currenthp}(%{maxhp})H %{currentmana}(%{maxmana})M %{currentmove}(%{maxmove})V >%;\
    /set teleport_summon=0%;\
    /copyprompttofield%;\
    /getlentoprompt%;\
    /extraonprompt%;\
    /setstatusfields%;\
    /checkwimp%;\
    /checkwalk%;\
    /prompt_peek%;\
    /area_checkroom%;\
    /autospellchanger%;\
    /promptdamage
;    /if (gagprompt=1) \
;        /substitute %PR%;\
;    /endif

/def -p1 -F -mregexp -h'PROMPT ^([0-9]+)H (|-)([0-9]+)M ([0-9]+)V Vis\:([0-9]+) >' prt_imm=\
    /set playing=1%;\
    /set currenthp=%{P1}%;\
    /set maxhp=%{P1}%;\
    /set currentmana=%{P3}%;\
    /set maxmana=%{P3}%;\
    /set currentmove=%{P4}%;\
    /set maxmove=%{P4}%;\
    /set wiz_vis_level=%{P5}%;\
    /set status_redraw=0%;\
    /set prompt=%{currenthp}H %{currentmana}M %{currentmove}V Vis:%{vis_lev} >%;\
    /set teleport_summon=0%;\
    /copyprompttofield%;\
    /getlentoprompt%;\
    /extraonprompt%;\
    /setstatusfields%;\
    /checkwimp%;\
    /checkwalk%;\
    /prompt_peek%;\
    /area_checkroom%;\
    /autospellchanger%;\
    /promptdamage
;    /if (gagprompt=1) \
;        /substitute %PR%;\
;    /endif

/def -q -p10 -F -aG -mregexp -t'OLC Zone: ([0-9]+) > ' prt_imm_olc=\
    /let oldprtchecker=111%;\
    /let prtchecker=111%;\
    /set currenthp=1000%;\
    /set currentmana=1000%;\
    /set currentmove=1000%;\
    /set status_redraw=0%;\
    /set maxhp=1000%;\
    /set maxmana=1000%;\
    /set maxmove=1000%;\
    /set prompt=OLC Zone: %P1 >%;\
    /set teleport_summon=0%;\
    /copyprompttofield%;\
    /getlentoprompt%;\
    /extraonprompt%;\
    /setstatusfields%;\
    /set olc=%{P1}%;\
    /prompt_peek%;\
    /area_checkroom
;    /if (gagprompt=1) \
;        /substitute %PR%;\
;    /endif

/def -F -p1 -mregexp -h'PROMPT ^Not playing > ' prompt_notplaying = \
    /set countmob=0%;\
    /set prompt=%{*}%;\
    /set playing=0%;\
    /setstatusfields
;;;

