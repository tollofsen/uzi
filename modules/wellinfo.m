;// vim: set ft=tf

;;; Wellinfo script. Originally from Shary, modified by orange. - Added MOBlevels from Cindy by Azhure.


/def wellmob = \
  /if (({1}!~'0')&({1}!~'')) \
    /set tempbuff=%ntxt2\Mob: %htxt2%1%;\
  /endif%;\
  /if (({8}!~'0')&({8}!~'')) \
    /set tempbuff=%{tempbuff}%ntxt2(%;\
    /set tempbuff=%{tempbuff}%htxt2%8%;\
    /set tempbuff=%{tempbuff}%ntxt2)%;\
  /endif%;\
  /if (({2}!~'0')&({2}!~'')) \
    /if ({2}=/'agg') \
      /set tempbuff=%{tempbuff} %E\Agg%;\
    /elseif ({2}=/'aggvis') \
      /set tempbuff=%{tempbuff} %E\Agg-Vis%;\
    /else \
      /set tempbuff=%{tempbuff} %ntxt%2%;\
    /endif%;\
  /endif%;\
  /if ((({3}!~'0')&({3}!~''))|(({4}!~'0')&({4}!~''))) \
    /set tempbuff=%{tempbuff} %htxt2(%;\
  /endif%;\
  /if (({3}!~'0')&({3}!~'')) \
    /set tempbuff=%{tempbuff}%ntxt2\Vuln: %ntxt%3%;\
  /endif%;\
  /if (({4}!~'0')&({4}!~'')) \
    /set tempbuff=%{tempbuff}%ntxt2 Resist: %ntxt%4%;\
  /endif%;\
  /if ((({3}!~'0')&({3}!~''))|(({4}!~'0')&({4}!~''))) \
    /set tempbuff=%{tempbuff}%htxt2)%;\
  /endif%;\
  /if (({5}!~'0')&({5}!~'')) \
    /set tempbuff=%{tempbuff}%ntxt2 Eq: %ntxt%5%;\
  /endif%;\
  /if (({6}!~'0')&({6}!~'')) \
    /set tempbuff=%{tempbuff}%ntxt2 Lvls: %ntxt%6%;\
  /endif%;\
  /if (({7}!~'0')&({7}!~'')) \
    /set tempbuff=%{tempbuff}%ntxt2 Spec: %ntxt%7%;\
  /endif%;\
  /test tempbuff:=replace("_", " ", tempbuff)%;\
  /uecko %tempbuff%;\
  /set tempbuff2=%*

;;;;;;;;;;;;;;;;;;;;;
; explanation ;)
;/wellmob <mob> <[agg|notagg|aggvis]> <vuln> <resist> <eq> <lvls> <spec> <level of mob (will show after mobname)>
;;;;;;;;;;;;;;;;;;;;;

/def -mglob -p300 -F -t'*A shaggy ape-like humanoid is resting here.*' wellmob01 = \
	/wellmob Taer Aggvis 0 0 0 1-3 0 40
/def -mglob -p300 -F -t'*A large, round creature with thin stalks protruding from its body is here.*' wellmob02 = \
	/wellmob Gas_spore AggVis 0 0 0 1-5 Infection 40
/def -mglob -p300 -F -t'*A large, round ball of fungus rolls around here.*' wellmob03 = \
	/wellmob Ascomoid Aggvis Unlife/Magical 0 0 1-5 0 41
/def -mglob -p300 -F -t'*Something floats in the water here. (invisible) (hidden)*' wellmob04 = \
	/wellmob Crysal_ooze Agg 0 0 0 1-6 Paralyze 40
/def -mglob -p300 -F -t'*A dark black cloak lies here, neatly folded*' wellmob05 = \
	/wellmob Cloaker Agg 0 0 Stone_of_animation 1-9 Traps_ppl 53
/def -mglob -p300 -F -t'*A small, reptile-like bird is here gawking at you.*' wellmob06 = \
	/wellmob Strider Agg 0 0 0 1-5* 0 40
/def -mglob -p300 -F -t'*A huge dragon breathes fire at you as you arrive.*' wellmob07 =\
	/wellmob Doppleganger NotAgg 0 0 0 1-5* Magical 45
/def -mglob -p300 -F -t'*A medium-sized gargoyle-like creature stands here, grinning at you. (hidden)*' wellmob08 =\
	/wellmob Berbalang Agg 0 0 0 1-9* 0 55
/def -mglob -p300 -F -t'*A patch of brown fungus grows in the cavern here.*' wellmob09 =\
	/wellmob Brown_Mold Aggvis 0 0 0 1-10* 0 46
/def -mglob -p300 -F -t'*A large violet-streaked mushroom grows here.*' wellmob10 =\
	/wellmob Violet_Fungus Aggvis 0 0 0 1-5* Infecting 42
/def -mglob -p300 -F -t'*A hideous beast with long tentacles slithers around here, looking for food.*' wellmob11 =\
	/wellmob Roper Aggvis Unlife/Magical 0 0 1-9* Str-drain 50
/def -mglob -p300 -F -t'*A tall humanoid with a tentacled mouth looks at you and charges!*' wellmob12 =\
	/wellmob Mind_Flayer Agg 0 0 mind_flail 1-8* Mind_controler 47
/def -mglob -p300 -F -t'*A large snail, with sharp-spiked protrusions from its head slithers around.*' wellmob13 =\
	/wellmob Flail_Snail Aggvis 0 0 0 1-5* 0 44
/def -mglob -p300 -F -t'*The sand here shifts slightly. (invisible) (hidden)*' wellmob14 =\
	/wellmob Sandling Agg 0 0 0 1-19 0 40
/def -mglob -p300 -F -t'*A flat, wet stone lies across the middle of the cavern. (hidden)*' wellmob16 =\
	/wellmob Grey_ooze Aggvis 0 0 0 1-5* Vapez_boots!! 43
/def -mglob -p300 -F -t'*A crimson mist floats through the caverns, looking for blood.*' wellmob17 =\
	/wellmob Vampiric_Mist Agg Energy 0 0 1-8* 0 48
/def -mglob -p300 -F -t'*A large web is spread out across the cavern here, quivering slightly.*' wellmob18 =\
	/wellmob Living_Web Notagg* 0 0 0 1-5 Splits_on_slash 49
/def -mglob -p300 -F -t'*A large toad with grayish skin mottled with blue sits here.*' wellmob19 =\
	/wellmob Ice_Toad Agg 0 0 0 4*-10* 0 55
/def -mglob -p300 -F -t'*An ugly snake with a human head slithers around here, hissing at you.*' wellmob20 =\
	/wellmob Spirit_Naga Agg 0 0 rotten_cloth_cloak 4-10 Mass_pain 58
/def -mglob -p300 -F -t'*You sense something nearby. (hidden)*' wellmob21 =\
	/wellmob Tentamort Agg Unlife/Magical 0 0 4*-10 Injects_fatal 60
/def -mglob -p300 -F -t'*A large weasel-like creature is here, preparing to attack. (hidden)*' wellmob22 =\
	/wellmob Wolverine Agg Mental/Gas earth 0 4*-9* 0 45
/def -mglob -p300 -F -t'*A large fleshy web is stretched out across the cavern here. (invisible) (hidden)*' wellmob23 =\
	/wellmob Memory_Web Agg 0 0 0 4*-10* Energy_drain,_Area_on_death 59
/def -mglob -p300 -F -t'*A large reptilian bird flies at you!*' wellmob24 =\
	/wellmob Darkenbeast Agg 0 0 0 4-10 0 57
/def -mglob -p300 -F -t'*A bull-like creature with thick metal scales stands here.*' wellmob25 =\
	/wellmob Gorgon Agg Unlife/Magical 0 0 6-13 Paralyzes 61
/def -mglob -p300 -F -t'*A large boulder sits here conspicuously. (hidden)*' wellmob26 =\
	/wellmob Galeb_Dur Agg 0 0 0 6-13 Spawns_boulders 68
/def -mglob -p300 -F -t'*A strange milky-white algae grows on the surface of the water.*' wellmob27 =\
	/wellmob Phycomid Aggvis 0 0 0 5-12 Infectious 45
/def -mglob -p300 -F -t'*A huge skeletal bat is prowling here. (hidden)*' wellmob28 =\
	/wellmob Varrangoin(huge) Agg 0 0 0 6-13 0 69
/def -mglob -p300 -F -t'*A skeletal bat of immense size swoops down at you! (hidden)*' wellmob29 =\
	/wellmob Varrangoin Agg 0 0 0 6-13 0 64
/def -mglob -p300 -F -t'*A large, red toad covered in purple warts leaps at you!*' wellmob30 =\
	/wellmob Fire_Toad Agg 0 0 0 6-13* 0 50
/def -mglob -p300 -F -t'*You see a beautiful feminine body in the shadows.*' wellmob31 =\
	/wellmob Medusa Agg 0 0 polished_silver_shield 6-10 Paralyze 65
/def -mglob -p300 -F -t'*A huge floating brain with a beak and tentacles floats towards you. (hidden) *' wellmob32 =\
	/wellmob Grell Agg 0 0 0 6-13 Grapples 66
/def -mglob -p300 -F -t'*A large reptilian creature shuffles around here.*' wellmob33 =\
	/wellmob Basilisk Agg 0 0 0 6*-13* Paralyze 62
/def -mglob -p300 -F -t'*A strange creature with three legs and three arms waddles towards you. (hidden)*' wellmob34 =\
	/wellmob Xorn Agg 0 0 0 6-13 Money_eating 67
/def -mglob -p300 -F -t'*A snake with a human head slithers around here, looking for a meal.*' wellmob35 =\
	/wellmob Greater_Medusa Agg Unlife/Magical Energy shrivelled_skull_necklace 6-11 Paralyze 70
/def -mglob -p300 -F -t'*A skeletal dog stands here, breathing fire*' wellmob36 =\
	/wellmob Hell_Hound Agg 0 0 6*-13* 0 60
/def -mglob -p300 -F -t'*A large tornado swirls here, threatening to carry you away.*' wellmob37 =\
	/wellmob Air_Elemental Agg Earth 0 0 8*-15 Areas 73
/def -mglob -p300 -F -t'*A vaguely humanoid form made of ice rushes to attack you!*' wellmob38 =\
	/wellmob Ice_Elemental Agg Fire 0 0 8*-15 0 70
/def -mglob -p300 -F -t'*A large humanoid creature made of rock stands here.*' wellmob39 =\
	/wellmob Earth_Elemental Agg 0 0 0 9-15 0 72
/def -mglob -p300 -F -t'*A very large white wolf stands here, growling at you. (hidden)*' wellmob40 =\
	/wellmob Winter_Wolf Agg 0 0 0 9*-15* 0 60
/def -mglob -p300 -F -t'*A hideous creature spots you and rushes to attack!*' wellmob41 =\
	/wellmob Thessalmera Agg Unlife/Magical 0 0 11*-15* Magical 76
/def -mglob -p300 -F -t'*A hideous creature stands here, looking intently at you.*' wellmob42 =\
	/wellmob Otyugh Agg Unlife/Magical Energy ring_tarnished_copper 9-15 0 74
/def -mglob -p300 -F -t'*A strange creature is wandering the caverns here.*' wellmob43 =\
	/wellmob Thessaltrice Agg Mythical Lots;) 0 9*-15 0 71
/def -mglob -p300 -F -t'*A thin layer of snow covers the ground here. (invisible) (hidden)*' wellmob44 =\
	/wellmob White_Pudding Agg 0 0 0 10-14* Vapez_shield 65
/def -mglob -p300 -F -t'*A shadowy form drifts around here. (invisible) (hidden)*' wellmob45 =\
	/wellmob Soul_Beckoner Agg Energy Hits soul_jar_glowing_Weapon 11-15 Undead 77
/def -mglob -p300 -F -t'*An immense purple worm bursts from the floor as you approach!*' wellmob46 =\
	/wellmob Purple_Worm Agg Unlife/Magical 0 0 11-15 0 78
/def -mglob -p300 -F -t'*A vaguely humanoid shape formed from fire stands here. (hidden)*' wellmob47 =\
	/wellmob Fire_Elemental Agg Ice 0 0 11*-17* Areas 70
/def -mglob -p300 -F -t'*A hideous, shambling creature sees you and rushes to attack! (hidden)*' wellmob48 =\
	/wellmob Neo-otyugh Agg Unlife/Magical Energy 0 11-18* Grapples 81
/def -mglob -p300 -F -t'*A large round eye creature floats here.*' wellmob49 =\
	/wellmob Beholder Agg Light 0 0 11-17* PW-kill,PW-blind?,Feeblemind 79
/def -mglob -p300 -F -t'*A large, hulking creature sees you and charges!*' wellmob50 =\
	/wellmob Umber_Hulk Agg Fire/Pure 0 0 11-18 Flees 84
/def -mglob -p300 -F -t'*A repulsive sphere-shaped eye floats here.*' wellmob51 =\
	/wellmob Gauth Agg 0 0 0 11-18* Force_flee,Feeblemind 83
/def -mglob -p300 -F -t'*A strange warped creature with eight snake heads stands here.*' wellmob52 =\
	/wellmob Thessalhydra Agg Magical 0 0  11-15 Poison 80
/def -mglob -p300 -F -t'*A huge, ugly creature stands before you, grunting.*' wellmob53 =\
	/wellmob Thessalgorgon Agg Unlife/Magical Energy 0 11-15 Paralysis 75
/def -mglob -p300 -F -t'*A large, imposing creature with a spiked tail is here.*' wellmob54 =\
  	/wellmob Manticore Agg Unlife/Magical Energy 0 11-18* Area_attacks,Stuns 82
/def -mglob -p300 -F -t'*A strange presence pervades the water here.*' wellmob56 =\
	/wellmob Water_Elemental Agg 0 0 0 14-18/16+ 0 70/80
/def -p300 -F -mregexp -t"The water elemental \(invisible\) is here" wellmob56b = \
	/wellmob Water_Elemental Agg 0 0 0 14-18 0 70
/def -mglob -p300 -F -t'*A huge bluish worm-like creature rears up to attack!*' wellmob57 =\
	/wellmob Remorhaz Agg slaydragon 0 carapace_of_bone 14-17 0 80
/def -mglob -p300 -F -t'*A hideous wormlike creature is crawling here.*' wellmob58 =\
	/wellmob Horgar NotAgg Fire 0 fleshspine,_horgarian_wormscale 14-20 Vapes_weapon! 90
/def -mglob -p300 -F -t'*A tall, skeletal creature looks at you with glowing red eyes.*' wellmob59 =\
	/wellmob Thassaloss NotAgg Mythical 0 0 14-20 0 89
/def -mglob -p300 -F -t'*A huge beast with 8 heads stands here, breathing fire.*' wellmob60 =\
	/wellmob Pyrohydra Agg Ice 0 0 14*-18 0 80
/def -mglob -p300 -F -t'*A three headed eraditor stands here getting ready for battle.*' wellmob61 =\
	/wellmob Eraditor Agg Iron/pure/Light Fire/Ice 0 14-20 0 86
/def -mglob -p300 -F -t'*two-headed lesser eraditor stands here displaying an evil grin.*' wellmob62 =\
	/wellmob Lesser_Eraditor NotAgg Iron/Pure/Light 0 0 14-20 0 85
/def -mglob -p300 -F -t'*A light-blue colored dragon of immense size rests here, waiting for a meal. *' wellmob63 =\
	/wellmob Ancient_White_Dragon Agg 0 0 0 16-20 0 85
/def -mglob -p300 -F -t'*There is a shadow of a dragon on the wall.*' wellmob64 =\
	/wellmob Shadow_Dragon NotAgg 0 0 0 16-20 Massblind 94
/def -mglob -p300 -F -t'*A human with jet-black skin stands here.*' wellmob65 =\
	/wellmob Storm_Demon NotAgg Iron/Pure/Light 0 forked_trident_lightning 16-20 0 93
/def -mglob -p300 -F -t'*A muscular humanoid shadow glides towards you.*' wellmob66 =\
	/wellmob Shadow_Demon NotAgg Iron/Pure/Light/Fire 0 mantle_midnight 16-20* 0 91
/def -mglob -p300 -F -t'*Djinni Vizier is here to end your sad life.*' wellmob67 =\
	/wellmob Djinni_Vizier Agg Earth Fire 0 18*-20 Areaconfuse,areaspells,teleport 97
/def -mglob -p300 -F -t'*A terrorite demon looks down at you with an amused smile.*' wellmob68 =\
	/wellmob Terrorite_Demon Agg Iron/Pure/Light Fire burning_brand 16-20 Stuns 93
/def -mglob -p300 -F -t'*A great Thonis demon is standing here contemplating your fate.*' wellmob69 =\
	/wellmob Thonis NotAgg Iron/Light/Pure Fire glowing_elbow_patch_force 17-20 0 95
/def -mglob -p300 -F -t'*The Djinni Malik is here.*' wellmob70 =\
	/wellmob Djinni_Malik Agg Earth 0 Robe_storm's_fury 17-20 Areacofuse,areas,teleport 95
/def -mglob -p300 -F -t'*A fearsome Balrog is here.*' wellmob71 =\
	/wellmob Balrog Agg 0 0 flaming_blade,crown_of_night,ebony_whip 18-20 Forces_flee,Repmob 98
/def -mglob -p300 -F -t'*A winged hairless sword demon glares at you.*' wellmob72 =\
	/wellmob Sword_Demon Agg Iron 0 0 16-20 0 91
/def -mglob -p300 -F -t'*A Dao, a huge fire genie is here to kill YOU!*' wellmob73 =\
	/wellmob Dao_Hetman Agg Air 0 0 19-20 Sentinel,Feeblemind,_RepMob 97
/def -mglob -p300 -F -t'*A tall, light-blue skinned humanoid hovers in the water here.*' wellmob74 =\
	/wellmob Marid_Beglerbeg NotAgg Fire 0 0 18-20 0 93
/def -mglob -p300 -F -t'*A large, imposing humanoid stands here, surrounded by flames*' wellmob75 =\
	/wellmob Efreeti_Malik NotAgg Ice 0 tiara_fire_opals 18-20 0 95
/def -mglob -p300 -F -t'*A large, flaming humanoid is standing here.*' wellmob76 =\
	/wellmob Efreeti_Bey NotAgg Ice/Elemental 0 blackened_armplates_plates,phobian_gauntlets 18-20 0 93
/def -mglob -p300 -F -t'*A regal-looking humanoid dressed in the robes of a prince stands here.*' wellmob77 =\
	/wellmob Efreeti_Pasha Agg Ice 0 0 19-20 0 97
/def -mglob -p300 -F -t'*An imposing humanoid with turquoise skin hovers in the water here.*' wellmob78 =\
	/wellmob Marid_Shah Agg Fire 0 0 19-20 0 97
/def -mglob -p300 -F -t'*A large, flaming humanoid stands here, grinning widely as he notices you.*' wellmob79 =\
	/wellmob Efreeti_Emir NotAgg Ice 0 Bracelet_of_Inferno 18-20 0 91
/def -mglob -p300 -F -t'*A tall, imposing humanoid hovers in the water here, scowling at you.*' wellmob80 =\
	/wellmob Marid_Padishah Agg Fire 0 0 20 0 99
/def -mglob -p300 -F -t'*The Djinni Caliph is unfortunately here.*' wellmob81 =\
	/wellmob Djinni_Caliph NotAgg Earth 0 halo_of_hurricanes,ethereal_leggings,harp_of_winds,ring_of_elemental_air 20
/def -mglob -p300 -F -t'*The Dao Khan Dao is here.*' wellmob82 =\
	/wellmob Dao_Khan Agg Air 0 0 20 0 98-99
/def -mglob -p300 -F -t'*A tall, imposing humanoid stands here, looking down upon you with scorn.*' wellmob83 =\
	/wellmob Efreeti_Sultan Agg Ice 0 overlords_scepter 20 0 99
/def -mglob -p300 -F -t'*Morgoth the Valar God is standing in front of, yes - YOU!*' wellmob84 =\
	/wellmob Morgoth Agg Mythical Lots;) crown,silmaril,ring,mace 20 Force_flee,areas,Repmob 100
/def -mglob -p300 -F -t'*A faintly visible, almost transparent mist floats through the air.*' wellmob85 =\
	/wellmob @{BCred}ESSAENCE_MYST 0 0 0 0 0 @{BCred}NOMAG!!!!!!! 1
/def -mglob -p300 -F -t'*A Lord Eraditor charges towards you with an evil laugh.*' wellmob86 =\
	/wellmob Lord_Eraditor Agg 0 0 chaosphere_sphere,eye_of_malice 18 0 87-88
/def -mglob -p300 -F -t'*A light-blue colored dragon of immense size rests here, waiting for a meal.*' wellmob87 =\
	/wellmob Frost_Dragon Agg Fire 0 0 14-20 0 90 
/def -mglob -p300 -F -t'*A strangely-deformed dragon-like reptile is prowling here.*' wellmob88 =\
	/wellmob Dracolisk Agg 0 0 0 6-10+ Paralyze 63
/def -mglob -p300 -F -t'*What looks like a boulder is stomping around here.*' wellmob89 =\
	/wellmob Boulder Agg 0 0 0 0 Major_ac,Galeblevs 44-46
/def -mglob -p300 -F -t'*A Major Eraditor displays a vicious grin as it goes to attack.*' wellmob90 =\
	/wellmob Major_Eraditor Agg Iron/Pure/Light Fire shadowbane_boots 16-20 0 87
/def -mglob -p300 -F -t'*A tall, regal humanoid with deep blue skin hovers in the water here.*' wellmob92 =\
	/wellmob Marid_Atabeg NotAgg Fire 0 knuckleguards_titan,translucent_knee 18-20 0 95
/def -mglob -p300 -F -t'*A serpent rises out of the water, grasping at you!*' wellmob94 =\
	/wellmob Water_Wierd Agg 0 0 0 9-17 Dies_on_rp 55
/def -mglob -p300 -F -t'*A large, old white dragon scowls at you as you enter, then attacks!*' wellmob95 =\
	/wellmob Ancient_White_Dragon Agg 0 0 0 16-20 0 85
/def -mglob -p300 -F -t'*A large, blue-skinned humanoid hovers in the water here.*' wellmob96 =\
	/wellmob Marid_Mufti Agg Fire 0 0 0 heals_himself,ice_storm,water_attack,sentinel 93
/def -mglob -p300 -F -t'*A large humanoid surrounded by wisps of ether stands here boldly*' wellmob97 = \
	/wellmob Djinni_Malik Agg Earth 0 0 17-20 0 95
/def -p99 -F -mregexp -t"(Gond the Wonderbringer is here, examining a small gem through an eyepiece|Gond is here)" wellmob98 = \
	/wellmob Gond Notagg 0 0 0 6-13 spawns_lvl_6,give_crystal/transform_to_ktv,buy_<stat> 100
;;93, 91, 97, 15, 55
