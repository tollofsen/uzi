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
            /if ($[regmatch('^[nsewud0-9]+$$$', {_speedie_walk})] = 1) \
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
    /if ($[regmatch('^[nsewud0-9]+$$$', {_speedie_walk})] = 1) \
        /let _reversable=yes%;\
    /else \
        /let _reversable=%htxt\no%;\
    /endif%;\
    /let _speedie_name=$[replace("_speedwalk_nc_", "", {*})]%;\
    /let _speedie_name=.$[replace("_speedwalk_oc_", "", {_speedie_name})]%;\
    /eval /echo -p %ntxt $[pad(%_speedie_name, -15, %_speedie_from, -28, %_speedie_to, -28, %_reversable, -10)]

;/echo .%_speedie_name From: %_speedie_from  To: %_speedie_to Walk: %_speedie_walk



;/def setspeedie = \
;  /set _speedie=$[replace("alias_body_", "", {3})]

;/def grepsw = \
;  /ecko $[replace("alias_body_", "", {3})]

;/def sws = \
;  /ecko Following speedwalk: %;\
;  /quote -S /grepsw `/list -I -s alias_body_\.%{1}*


;/alias .alchor sswsseeseesese
/set _speedwalk_oc_antriad Elven_forest_Obelisk Antriad 2sw2s2es2e2n
/set _speedwalk_oc_argo Sundhaven_Obelisk Argonaut wwnnnnw%;open gate%;wwnuwwwnn%;open cover%;dddde
/set _speedwalk_oc_deep Alchor_Obelisk Orc_Caves 7seu2nw4n3e3n3u6end
/set _speedwalk_oc_ef East_Turning_Point Enchanted_Forest 4en2en3es3enwne2nw2nwne2nwne3sesw2se2swse2s9w4n
/set _speedwalk_oc_enfans New_Thalos_Obelisk Enfans 2e2n2e2nes2ene3n2wnw
/set _speedwalk_oc_es Outside_West_Gate Earth_Sea wwwnwwwswswnwwwwwwwwwwwws2w2sen
/set _speedwalk_oc_fortress Ultima_Obelisk Fortress_of_Mustain 3ndne2n4e2s
/set _speedwalk_oc_gkp Market_Square Great_Knight_Paladin 3w5se4se
/set _speedwalk_oc_gehenna Market_Square Gehenna wwwssssssssswsssssssss
/set _speedwalk_oc_gremlin Kings_Castle_Obelisk Gremlin wwwnwnennwnnwnesssessnnnnn
/set _speedwalk_oc_highlands Kings_Castle_Obelisk Highlands 3wnw2ne2nw2nwne2nw3nw4nw2n
/set _speedwalk_oc_imps Ultima_Obelisk Upper_Argo nnndnnnnnundnnn
;/set _speedwalk_oc_impstp eeeeneeneeeseeenwnennwnnwnesssswswnundnnn
/set _speedwalk_oc_ingelstone Ofcol_Obelisk Ingelstone wwssssssswwsssswwwwwwwwwwwswnnnnnnw
/set _speedwalk_oc_kender Ofcol_Obelisk Kender 2w7s2w3s8w2nen
/set _speedwalk_oc_kerofk Outside_West_Gate Kerofk 3wn3wswswn3w2ne2nene2nwne2nes6e4n2en
/set _speedwalk_oc_kings East_Turning_Point Kings_Castle eeeeneeneeeseeeeeen
/set _speedwalk_oc_lagamor Outside_West_Gate Lagamor 3w9sw2sw3ses2wsw
/set _speedwalk_oc_lorca Kings_Castle Almost_Lorca 3wnwnennwnnw
/set _speedwalk_oc_lorca2 Almost_Lorca Lorca(DON'T_speedwalk) wn5ws2wnennneeneeseeeeeeesen
/set _speedwalk_oc_minotaur Kings_Castle Minotaur wwwnwnennwnnwnesssesswsssdsssssses
;/set _speedwalk_oc_pharao . . 2s2e2s5es2es3es2eses9en6enwne3ne2n
;/set _speedwalk_oc_pharao2 . . 4w5n3enu4n4u%;open tomb%;2n2wune4neu5nu
/set _speedwalk_oc_shadow Valley_of_Highlands Shadow 2dws7wu3wd2sws2e2d2esen2e2sn3e2s3en
/set _speedwalk_oc_ship Kerofk_Obelisk Shipwreck s2en%;open cloth%;n%;open trapdoor%;d2e3de2n2ene2n3w
/set _speedwalk_oc_soul2 2nd_Floor_Soulcrusher Agro_Soulcrushers ssnesseneeeswsese
/set _speedwalk_oc_sundhaven East_Turning_Point Sundhaven 4en2en3es3enwne2nw2nwne2nw3nw4nwnwn4wn2wn6w
/set _speedwalk_oc_taon Outside_West_Gate Halfway_to_Taon 3wn3wswswn3wse2sw2ses4w2s7e7n
/set _speedwalk_oc_taon2 Halfway_to_Taon Taon wwwwwwssssssuueeennnnwwwwuuueeennuuue
/set _speedwalk_oc_titstat New_Thalos Titanium_Statue eeneenneseeneeseseesd
/set _speedwalk_oc_titstatms Market_Square Titanium_Statue 3w9sw2sw3ses2wsw2sw2ses2en2eses3esd
/set _speedwalk_oc_withness Outside_West_Gate Demon_City 3wn3wswswn3wse2sw2se2sesen
/set _speedwalk_oc_yggdrasil Outside_West_Gate Yggdrasil wwwnwwwswswnwwwwwwwwwwwwswwsswswwwnwn
/set _speedwalk_oc_tomyrridon Turning_Point Portal_to_Ship 4en2en3es3enwne2nw2nwne2nwn3en2es2enen5e

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Myrridon Speedwalks
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
/set _speedwalk_nc_cohnshar Crossroads Cohn_Shar 2nen2en3en2en2es2es2en3enwnw3nw6ne2ne2ne2nenwn
/set _speedwalk_nc_alterac Crossroads Alterac 2nen2en3en2en2es2es2en3enwnw3nw6ne2ne2ne2ne2ne2n4ese
/set _speedwalk_nc_altoco Cohn_Shar Alterac 5s5sw3sene2n4ese
/set _speedwalk_nc_altolo Alterac Lorchid wn3w2ne2ne2ne4n
/set _speedwalk_nc_tournament West_Gate Tournament 4ws2ws2w2ses2e3n2e
/set _speedwalk_nc_abandonedmines West_Gate Abonded_Mines 4wsw3n3w2nwn
/set _speedwalk_nc_apocalypse Palanthas Apocalypse 2s2es2enen2enen2ene2nene2n2e2n3en3ese
/set _speedwalk_nc_lorchid Crossroads Lorchid 2nen2en3en2en2es2es2en3enwnw3nw6ne2ne2ne2ne2ne2ne2ne2ne2ne4n
/set _speedwalk_nc_oblivion Palanthas Oblivion 5s2es2enen2enen2enen7w5n3e3n3e
