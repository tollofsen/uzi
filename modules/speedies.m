;// vim: set ft=tf

;=======================================
;   Speedwalk Functions
;=======================================

/def -p2147483647 -mregexp -h'send ^\.\.([A-Za-z]+)$$$' speedwalkbackward = \
    /if /ismacro ~speedwalk%; /then \
        /let _string=%P1%;\
        /eval /setspeedie %%{_speedwalk_oc_%{P1}}%;\
        /if (_speedie_walk =~ '') \
            /eval /setspeedie %%{_speedwalk_nc_%{P1}}%;\
        /endif%;\
        /if (_speedie_walk =~ '') \
            /if /ismacro alias_body_%*%; /then \
                /alias_body_%*%;\
            /else \
                /ecko That speedwalk doesn't exists. /speedies for list.%;\
            /endif%;\
        /else \
            /if (regmatch('^[nsewud0-9]+$$$', {_speedie_walk})) \
                /ecko Walking from %_speedie_to to %_speedie_from. ($[revwalk({_speedie_walk})])%;\
                $[revwalk({_speedie_walk})]%;\
            /else \
                /ecko Sorry, I can't walk that speedwalk backwards.. yet.%;\
                /echo -aBCred %_speedie_walk%;\
            /endif%;\
        /endif%;\
    /else \
        /if /ismacro alias_body_%*%; /then \
            /alias_body_%*%;\
        /else \
            /send %*%;\
        /endif%;\
    /endif

/def -p2147483647 -mregexp -h'send ^\.([A-Za-z]+)$$$' speedwalkforward = \
    /if /ismacro ~speedwalk%; /then \
        /let _string=%P1%;\
        /eval /setspeedie %%{_speedwalk_oc_%{P1}}%;\
        /if (_speedie_walk =~ '') \
            /eval /setspeedie %%{_speedwalk_nc_%{P1}}%;\
        /endif%;\
        /if (_speedie_walk =~ '') \
            /if /ismacro alias_body_%*%; /then \
                /alias_body_%*%;\
            /else \
                /ecko That speedwalk doesn't exists. /speedies for list.%;\
            /endif%;\
        /else \
            /ecko Walking from %_speedie_from to %_speedie_to. (%_speedie_walk)%;\
            /eval %_speedie_walk%;\
        /endif%;\
    /else \
        /if /ismacro alias_body_%*%; /then \
            /alias_body_%*%;\
        /else \
            /send %*%;\
        /endif%;\
    /endif


/def setspeedie = \
    /set _speedie_from=$[replace("_", " ", {1})]%;\
    /set _speedie_to=$[replace("_", " ", {2})]%;\
    /set _speedie_walk=$[replace("_speedwalk_", "", {-2})]

;;;

/def speedies = \
    /if ({1} =~ '') \
        /ecko Usage: %htxt2/speedies OC%ntxt/%htxt2\NC %htxt[search string]%;\
        /ecko %htxt2 /uhelp speedies%ntxt for help%;\
    /else \
        /echo -a -p %{htxt}=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%;\
        /echo -p %htxt2 $[pad("Command", -15, "From", -28, "To", -28, "Rev", -10)]%;\
        /echo -a -p %{htxt}=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%;\
        /set _speedwalk_count=0%;\
        /quote -S /mkspeedielist `/listvar -s _speedwalk_%{1}_%{2}*%;\
        /if (_speedwalk_count == 1) \
            /echo -p %ntxt Path: %_speedie_walk%;\
        /elseif (_speedwalk_count == 0) \
            /echo -p %htxt2 Didn't find any speedwalks.%;\
        /else \
            /echo -p %ntxt Listing %htxt2%_speedwalk_count%ntxt speedwalks.%;\
        /endif%;\
        /echo -a -p %{htxt}=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%;\
        /echo -p %htxt2 /uhelp speedies%ntxt for help.%;\
        /echo -a -p %{htxt}=-=-=-=-=-=-=-=-=-==-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=%;\
    /endif

/def mkspeedielist = \
    /set _speedwalk_count=$[_speedwalk_count+1]%;\
    /eval /setspeedie %%{%{*}}%;\
    /if (regmatch('^[nsewud0-9]+$$$', {_speedie_walk})) \
        /let _reversable=yes%;\
    /else \
        /let _reversable=%htxt\no%;\
    /endif%;\
    /let _speedie_name=$[replace("_speedwalk_nc_", "", {*})]%;\
    /let _speedie_name=.$[replace("_speedwalk_oc_", "", {_speedie_name})]%;\
    /eval /echo -p %ntxt $[pad(_speedie_name, -15, _speedie_from, -28, _speedie_to, -28, _reversable, -10)]

;/echo .%_speedie_name From: %_speedie_from  To: %_speedie_to Walk: %_speedie_walk



;/def setspeedie = \
;  /set _speedie=$[replace("alias_body_", "", {3})]

;/def grepsw = \
;  /ecko $[replace("alias_body_", "", {3})]

;/def sws = \
;  /ecko Following speedwalk: %;\
;  /quote -S /grepsw `/list -I -s alias_body_\.%{1}*


/set _speedwalk_oc_tomyrridon Kings_Castle_Obelisk Portal_to_Ship 3wnwne2nw2nwne2nwn3en2es2enen5e
/set _speedwalk_oc_alchor Elven_forest_Obelisk Alchor 2sw2s2es2esese
/set _speedwalk_oc_antriad Elven_forest_Obelisk Antriad 2sw2s2es2e2n
/set _speedwalk_oc_deep Sundhaven_Obelisk Abandoned_Caves 7seu2nw4n3e3n3u6end
/set _speedwalk_oc_orshingal New_Thalos_Obelisk Orshingal 2en2e2nes2enen
/set _speedwalk_oc_es Market_Square Earth_Sea 10wn3wswswn12ws2w2sen
/set _speedwalk_oc_mustaine Ultima_Obelisk Fortress_of_Mustain 3ndne2n4e2s
/set _speedwalk_oc_redfernes Fountain_Square Great_Knight_Paladin 4w2s18u
/set _speedwalk_oc_gehenna Market_Square Gehenna 5s3w3sw9s
/set _speedwalk_oc_turvagar Kings_Castle_Obelisk Turvagar 3wnwne2nw2nwne3sen
/set _speedwalk_oc_highlands Kings_Castle_Obelisk Highlands 3wnw2ne2nw2nwne2nw3nw4nw2n
/set _speedwalk_oc_argo Ultima_Obelisk Upper_Argo 3nd5nund3n
/set _speedwalk_oc_inglestone Ofcol_Obelisk Inglestone 2w7s2w3s11wnw5nwn
/set _speedwalk_oc_kender Ofcol_Obelisk Kender 2w7s2w3s8w2nen
/set _speedwalk_oc_lagamor New_Thalos_Obelisk Lagamor 2en2e4ne2nwn2w
/set _speedwalk_oc_lorca Kings_Castle Lorca 3wnwne2nw2n2wn5ws2wn
/set _speedwalk_oc_mahntor Kings_Castle Mahn-Tor 3wnwne2nw2nwne4swse3sd4se2s2u
/set _speedwalk_oc_gsoul 2nd_Floor_Soulcrusher Agro_Soulcrushers ssnesseneeeswsese
/set _speedwalk_oc_trees Market_Square Haon-Dor 10wn3wswswn12w
/set _speedwalk_oc_coven New_Thalos_Obelisk The_Coven 2enesd
/set _speedwalk_oc_demonbyen New_Thalos_Obelisk Demonbyen 2en2e2n2wn2wn2wn

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Myrridon Speedwalks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/set _speedwalk_nc_cohnshar Crossroads Cohn_Shar 2nen2en3en2en2es2es2en3enwnw3nw6ne2ne2ne2nenwn
/set _speedwalk_nc_alterac Crossroads Alterac 2nen2en3en2en2es2es2en3enwnw3nw6ne2ne2ne2ne2ne2n4ese
/set _speedwalk_nc_cotoal Cohn_Shar Alterac 5s5sw3sene2n4ese
/set _speedwalk_nc_altolo Alterac Lorchid wn3w2ne2ne2ne4n
/set _speedwalk_nc_tournament West_Gate Tournament 4ws2ws2w2ses2e3n2e
/set _speedwalk_nc_abandonedmines West_Gate Abonded_Mines 4wsw3n3w2nwn
/set _speedwalk_nc_apocalypse Palanthas Apocalypse 2s2es2enen2enen2ene2nene2n2e2n3en3ese
/set _speedwalk_nc_lorchid Crossroads Lorchid 2nen2en3en2en2es2es2en3enwnw3nw6ne2ne2ne2ne2ne2ne2ne2ne2ne4n
/set _speedwalk_nc_oblivion Palanthas Oblivion 5s2es2enen2enen2enen7w5n3e3n3e
/set _speedwalk_nc_sarakesh West_Gate Dragontail_Isle 4ws2ws2w2se2swseses
/set _speedwalk_nc_drows Crossroads Guallidurth 2nen2en3en4ws2w2n3w2s2w
