; mobsubs.tf

/purge uzi_wellsubs_substitute*

/def wellsubs = \
    /if ({1}=~'on') \
        /set wellsubs=1%;\
        /ecko Now using wellsubs.%;\
    /elseif ({1}=~'off') \
        /set wellsubs=0%;\
        /ecko No longer showing wellsubs%;\
    /else \
        /if (wellsubs=1) \
            /wellsubs off%;\
        /else \
            /wellsubs on%;\
        /endif%;\
    /endif


/def -p99 -F -Ewellsubs -mregexp -t"A faintly visible, almost transparent mist floats through the air." uzi_wellsubs_substitute_EssaenceMyst = \
    /substitute -p %{PL}@{Cwhite}--- @{nCyellow}Myst @{Cwhite}(NO MAGIC)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large, red toad covered in purple warts leaps at you!|The fire toad is here)" uzi_wellsubs_substitute_FireToad = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Fire toad @{Cwhite}(ice)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large toad with grayish skin mottled with blue sits here|The ice toad is here)" uzi_wellsubs_substitute_IceToad = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Ice toad @{Cwhite}(fire)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A serpent rises out of the water, grasping at you!|The water weird is here)" uzi_wellsubs_substitute_WaterWeird = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Water Weird @{Cwhite}(remove poison)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(Something floats in the water here|The crystal ooze (\(invisible\) |)\(hidden\) is here)" uzi_wellsubs_substitute_CrystalOoze = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Crystal Ooze @{Cwhite}(resist WEAPON/crush)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large, round creature with thin stalks protruding from its body|The gas spore is here)" uzi_wellsubs_substitute_GasSpore = \
    /substitute -p %{PL}@{Cred}agg @{nCyellow}Gas Spore @{Cwhite}(acid, belch-spores:true)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(The sand here shifts slightly\.|The sandling (\(invisible\) |)\(hidden\) is here)" uzi_wellsubs_substitute_Sandling = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Sandling @{Cwhite}(unlife)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A small, reptile-like bird is here gawking at you|The strider is here)" uzi_wellsubs_substitute_Strider = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Strider @{Cwhite}(air)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A shaggy ape-like humanoid is resting here|The taer is here)" uzi_wellsubs_substitute_Taer = \
    /substitute -p %{PL}@{Cred}agg @{nCyellow}Taer @{Cwhite}(---)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large, round ball of fungus rolls around here|The ascomoid is here)" uzi_wellsubs_substitute_Ascomoid = \
    /substitute -p %{PL}@{Cred}agg @{nCyellow}Ascomoid @{Cwhite}(pierce/acid, immune crush)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large violet-streaked mushroom grows here|The violet fungus is here)" uzi_wellsubs_substitute_VioletFungus = \
    /substitute -p %{PL}@{Cred}agg @{nCyellow}Violet Fungus @{Cwhite}(acid, fungal disease:true)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A flat, wet stone lies across the middle of the cavern|The grey ooze \(hidden\) is here)" uzi_wellsubs_substitute_GreyOoze = \
    /substitute -p %{PL}@{Cred}agg @{nCyellow}Grey Ooze @{Cwhite}(resist WEAPON, VAPE boots!)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(What looks like a boulder is stomping around here|A boulder is here)" uzi_wellsubs_substitute_Boulder = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Boulder @{Cwhite}(fire)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large snail, with sharp-spiked protrusions from its head slithers around|The flail snail is here)" uzi_wellsubs_substitute_FlailSnail = \
    /substitute -p %{PL}@{Cred}agg @{nCyellow}Flail Snail @{Cwhite}(mental/gas)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A huge dragon breathes fire at you as you arrive|The doppleganger is here)" uzi_wellsubs_substitute_Doppleganger = \
    /substitute -p %{PL}@{Cwhite}--- @{nCyellow}Doppleganger @{Cwhite}(unlife)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large weasel-like creature is here, preparing to attack|The giant wolverine \(hidden\) is here)" uzi_wellsubs_substitute_GWolverine = \
    /substitute -p %{PL}@{Cred}agg @{nCyellow}Giant Wolverine @{Cwhite}(mental/gas)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A strange milky-white algae grows on the surface of the water|The phycomid is here)" uzi_wellsubs_substitute_Phycomid = \
    /substitute -p %{PL}@{Cred}agg @{nCyellow}Phycomid @{Cwhite}(acid, inject)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A patch of brown fungus grows in the cavern here|The brown mold is here)" uzi_wellsubs_substitute_BrownMold = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Brown Mold @{Cwhite}(acid)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A tall humanoid with a tentacled mouth looks at you and charges|The mind flayer is here)" uzi_wellsubs_substitute_MindFlayer = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Mind Flayer @{Cwhite}(---)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large, gray wolf sits here, watching you carefully|The Mist Wolf is here)" uzi_wellsubs_substitute_MistWolf = \
    /substitute -p %{PL}@{Cred}agg @{nCyellow}Mist Wolf @{Cwhite}(mental)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A crimson mist floats through the caverns,|The vampiric mist is here)" uzi_wellsubs_substitute_VampiricMist = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Vampiric mist @{Cwhite}(energy, Resist WEAPON)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large web is spread out across the cavern here, quivering slightly|The living web is here)" uzi_wellsubs_substitute_LivingWeb = \
    /substitute -p %{PL}@{Cwhite}--- @{nCyellow}Living web @{Cwhite}(no-attack)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A hideous beast with long tentacles slithers around here, looking for food|The roper is here)" uzi_wellsubs_substitute_Roper = \
    /substitute -p %{PL}@{Cred}agg @{nCyellow}Roper @{Cwhite}(unlife)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A tall humanoid with purplish skin and a tentacled mouth stands|The elder mind flayer is here)" uzi_wellsubs_substitute_ElderMindFlayer = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Elder Mind Flayer @{Cwhite}(---)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A dark black cloak lies here, neatly folded|The cloaker is here)" uzi_wellsubs_substitute_Cloaker = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Cloaker @{Cwhite}(unlife, grab-as-shield)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A medium-sized gargoyle-like creature stands here, grinning at you\.|The berbalang \(hidden\) is here)" uzi_wellsubs_substitute_Berbalang = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Berbalang @{Cwhite}(unlife)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large reptilian bird flies at you!|The darkenbeast is here)" uzi_wellsubs_substitute_Darkenbeast = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Darkenbeast @{Cwhite}(unlife)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(An ugly snake with a human head slithers around here, hissing at you|The spirit naga is here)" uzi_wellsubs_substitute_SpiritNaga = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Spirit Naga @{Cwhite}(---)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large fleshy web is stretched out across the cavern here|The memory web (\(invisible\) |)\(hidden\) is here)" uzi_wellsubs_substitute_MemoryWeb = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Memory Web @{Cwhite}(---)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A skeletal dog stands here, breathing fire|The hell hound is here)" uzi_wellsubs_substitute_HellHound = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Hell Hound @{Cwhite}(unlife)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(You sense something nearby|The tentamort \(hidden\) is here)" uzi_wellsubs_substitute_Tentamort = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Tentamort @{Cwhite}(unlife, INJECT!!!)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A very large white wolf stands here, growling at you|The winter wolf \(hidden\) is here)" uzi_wellsubs_substitute_WinterWolf = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Winter Wolf @{Cwhite}(fire/mental)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large reptilian creature shuffles around here|The basilisk is here)" uzi_wellsubs_substitute_Basilisk = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Basilisk @{Cwhite}(fire, petrify)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A bull-like creature with thick metal scales stands here|The gorgon is here)" uzi_wellsubs_substitute_Gorgon = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Gorgon @{Cwhite}(unlife, timed paralyzis)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A strangely-deformed dragon-like reptile is prowling here|The dracolisk is here)" uzi_wellsubs_substitute_Dracolisk = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Dracolisk @{Cwhite}(fire/ice, petrify)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"An immense boulder is here" uzi_wellsubs_substitute_ImmenseBoulder = \
    /substitute -p %{PL}@{Cwhite}--- @{nCyellow}Immense Boulder @{Cwhite}(---, HUNTER)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"A skeletal bat of immense size swoops down at you!" uzi_wellsubs_substitute_VarrangoinEasy = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Varrangoin (easy) @{Cwhite}(pure/light/iron)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"A huge skeletal bat is prowling here" uzi_wellsubs_substitute_VarrangoinHard = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Varrangoin (hard) @{Cwhite}(pure/light/iron)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"The varrangoin \(hidden\) is here" uzi_wellsubs_substitute_VarrangoinFighting = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Varrangoin @{Cwhite}(pure/light/iron)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(You see a beautiful feminine body in the shadows|The medusa is here)" uzi_wellsubs_substitute_Medusa = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Medusa @{Cwhite}(unlife, timed petrify)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A thin layer of snow covers the ground here|The white pudding (\(invisible\) |)\(hidden\) is here)" uzi_wellsubs_substitute_WhitePudding = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}White pudding @{Cwhite}(---, VAPE shield!)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A huge floating brain with a beak and tentacles floats towards you|The grell \(hidden\) is here)" uzi_wellsubs_substitute_Grell = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Grell @{Cwhite}(unlife, No-BM)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A strange creature with three legs and three arms waddles towards you|The xorn \(hidden\) is here)" uzi_wellsubs_substitute_Xorn = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Xorn @{Cwhite}(slay elemental, eats money)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large boulder sits here conspicuously|The galeb duhr \(hidden\) is here)" uzi_wellsubs_substitute_GalebDuhr = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Galeb Duhr @{Cwhite}(ice, immune electr)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"A huge boulder rests on the ground here" uzi_wellsubs_substitute_GalebDuhrRock = \
    /substitute -p %{PL}@{Cred}agg @{nCyellow}Galeb Duhr - Rock! @{Cwhite}(ice, immune electr)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A vaguely humanoid shape formed from fire stands here|The fire elemental \(hidden\) is here)" uzi_wellsubs_substitute_FireElemental = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Fire Elemental @{Cwhite}(ice)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A snake with a human head slithers around here, looking for a meal|The greater medusa is here)" uzi_wellsubs_substitute_GreaterMedusa = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Greater Medusa @{Cwhite}(unlife, timed petrify)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A vaguely humanoid form made of ice rushes to attack you!|The ice elemental is here)" uzi_wellsubs_substitute_IceElemental = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Ice Elemental @{Cwhite}(fire)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"The water elemental \(invisible\) is here" uzi_wellsubs_substitute_WaterElemental2 = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Water elemental @{Cwhite}(fire)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A strange presence pervades the water here\.|The water elemental is here)" uzi_wellsubs_substitute_WaterElemental = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Water elemental @{Cwhite}(fire)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A strange creature is wandering the caverns here\.|The thessaltrice is here)" uzi_wellsubs_substitute_Thessaltrice = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Thessaltrice @{Cwhite}(unlife, petrify)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large humanoid creature made of rock stands here\.|The earth elemental is here)" uzi_wellsubs_substitute_EarthElemental = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Earth elemental @{Cwhite}(air)@{n}%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large tornado swirls here, threatening to carry you away\.|The air elemental is here)" uzi_wellsubs_substitute_AirElemental = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Air elemental @{Cwhite}(earth)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A hideous creature stands here, looking intently at you\.|The otyugh is here)" uzi_wellsubs_substitute_Otyugh = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Otyugh @{Cwhite}(unlife)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A huge, ugly creature stands before you, grunting\.|The thessalgorgon is here)" uzi_wellsubs_substitute_Thessalgorgon = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Thessalgorgon @{Cwhite}(unlife, petrify)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A hideous creature spots you and rushes to attack!|The thessalmera is here)" uzi_wellsubs_substitute_Thessalmera = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Thessalmera @{Cwhite}(unlife)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A shadowy form drifts around here\.|The soul beckoner (\(invisible\) |)\(hidden\) is here)" uzi_wellsubs_substitute_SoulBeckoner = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Soul Beckoner @{Cwhite}(pure?/light/energy, Resist WEAPON)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(An immense purple worm bursts from the floor as you approach!|The purple worm is here)" uzi_wellsubs_substitute_PurpleWorm = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Purple worm @{Cwhite}(unlife)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large round eye creature floats here\.|The beholder is here)" uzi_wellsubs_substitute_Beholder = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Beholder @{Cwhite}(pure/light/iron?)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A huge beast with 8 heads stands here, breathing fire\.|The pyrohydra is here)" uzi_wellsubs_substitute_Pyrohydra = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Pyrohydra @{Cwhite}(ice)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A huge bluish worm-like creature rears up to attack!|The remorhaz is here)" uzi_wellsubs_substitute_Remorhaz = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Remorhaz @{Cwhite}(slay dragon)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A strange warped creature with eight snake heads stands here|The thessalhydra is here)" uzi_wellsubs_substitute_Thessalhydra = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Thessalhydra @{Cwhite}(unlife)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A hideous, shambling creature sees you and rushes to attack!|The neo-otyugh \(hidden\) is here)" uzi_wellsubs_substitute_NeoOtyugh = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Neo-otyugh @{Cwhite}(unlife)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large, imposing creature with a spiked tail is here\.|The manticore is here)" uzi_wellsubs_substitute_Manticore = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Manticore @{Cwhite}(unlife)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A repulsive sphere-shaped eye floats here\.|The gauth is here)" uzi_wellsubs_substitute_Gauth = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Gauth @{Cwhite}(light, forceflee N-E-S-W)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large, hulking creature sees you and charges!|The umber hulk is here)" uzi_wellsubs_substitute_UmberHulk = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Umber hulk @{Cwhite}(pure/light/fire)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large, old white dragon scowls at you as you enter, then attacks!|The ancient white dragon is here)" uzi_wellsubs_substitute_AWDragon = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Ancient White Dragon @{Cwhite}(fire)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A two-headed lesser eraditor stands here displaying an evil grin\.|The Lesser Eraditor is here)" uzi_wellsubs_substitute_LesserEraditor = \
    /substitute -p %{PL}--- @{nCyellow}Lesser Eraditor @{Cwhite}(pure/light/iron)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A three headed eraditor stands here getting ready for battle\.|The Eraditor is here)" uzi_wellsubs_substitute_Eraditor = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Eraditor @{Cwhite}(pure/light/iron)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A Lord Eraditor charges towards you with an evil laugh|The Lord Eraditor is here)" uzi_wellsubs_substitute_LordEraditor = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Lord Eraditor @{Cwhite}(pure/light/iron)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A Major Eraditor displays a vicious grin as it goes to attack\.|The Major Eraditor is here)" uzi_wellsubs_substitute_MajorEraditor = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Major Eraditor @{Cwhite}(pure/light/iron)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A tall, skeletal creature looks at you with glowing red eyes\.|The thassaloss is here)" uzi_wellsubs_substitute_Thassaloss = \
    /substitute -p %{PL}--- @{nCyellow}Thassaloss @{Cwhite}(slay mythical?)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A light-blue colored dragon of immense size rests here, waiting for a meal\.|The frost dragon is here)" uzi_wellsubs_substitute_FrostDragon = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Frost Dragon @{Cwhite}(fire)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A hideous wormlike creature is crawling here\.|The horgar is here)" uzi_wellsubs_substitute_Horgar = \
    /substitute -p %{PL}--- @{nCyellow}Horgar @{Cwhite}(fire, VAPE weapon!)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large, flaming humanoid stands here, grinning widely as he notices you\.|The Efreeti Emir is here)" uzi_wellsubs_substitute_EfreetiEmir = \
    /substitute -p %{PL}--- @{nCyellow}Efreeti Emir @{Cwhite}(ice)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A muscular humanoid shadow glides towards you\.|The Shadow Demon is here)" uzi_wellsubs_substitute_ShadowDemon = \
    /substitute -p %{PL}--- @{nCyellow}Shadow Demon @{Cwhite}(pure/light/iron/fire/electr)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A winged hairless sword demon glares at you\.|The Sword Demon is here)" uzi_wellsubs_substitute_SwordDemon = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Sword Demon @{Cwhite}(pure/light/iron)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large, flaming humanoid is standing here\.|The Efreeti Bey is here)" uzi_wellsubs_substitute_EfreetiBey = \
    /substitute -p %{PL}--- @{nCyellow}Efreeti Bey @{Cwhite}(ice)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A tall, light-blue skinned humanoid hovers in the water here\.|The Marid Beglerbeg is here)" uzi_wellsubs_substitute_MaridBeglerbeg = \
    /substitute -p %{PL}--- @{nCyellow}Marid Beglerbeg @{Cwhite}(fire)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large, blue-skinned humanoid hovers in the water here\.|The Marid Mufti is here)" uzi_wellsubs_substitute_MaridMufti = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Marid Mufti @{Cwhite}(fire)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A human with jet-black skin stands here\.|The Storm Demon is here)" uzi_wellsubs_substitute_StormDemon = \
    /substitute -p %{PL}--- @{nCyellow}Storm Demon @{Cwhite}(pure/light/iron)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A terrorite demon looks down at you with an amused smile\.|The Terrorite Demon is here)" uzi_wellsubs_substitute_TerroriteDemon = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Terrorite Demon @{Cwhite}(pure/light/iron)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(There is a shadow of a dragon on the wall\.|The shadow dragon is here)" uzi_wellsubs_substitute_ShadowDragon = \
    /substitute -p %{PL}--- @{nCyellow}Shadow Dragon @{Cwhite}(slay dragon)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A tall, imposing humanoid stands here, with hate in its eyes|The Dao Khan is here)" uzi_wellsubs_substitute_DaoKhan = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Dao Khan @{Cwhite}(fire/air)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large humanoid surrounded by wisps of ether stands here boldly\.|The Djinni Malik is here)" uzi_wellsubs_substitute_DjinniMalik = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Djinni Malik @{Cwhite}(earth)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A large, imposing humanoid stands here, surrounded by flames\.|The Efreeti Malik is here)" uzi_wellsubs_substitute_EfreetiMalik = \
    /substitute -p %{PL}--- @{nCyellow}Efreeti Malik @{Cwhite}(ice)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A tall, regal humanoid with deep blue skin hovers in the water here\.|The Marid Atabeg is here)" uzi_wellsubs_substitute_MaridAtabeg = \
    /substitute -p %{PL}--- @{nCyellow}Marid Atabeg @{Cwhite}(fire)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A great Thonis demon is standing here contemplating your fate\.|The Thonis is here)" uzi_wellsubs_substitute_Thonis = \
    /substitute -p %{PL}--- @{nCyellow}Thonis @{Cwhite}(pure/light/iron)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A regal humanoid formed from solid rock eyes you contemptuously\.|The Dao Hetman is here)" uzi_wellsubs_substitute_DaoHetman = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Dao Hetman @{Cwhite}(air)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A Djinni Vizier is here to end your sad life\.|The Djinni Vizier is here)" uzi_wellsubs_substitute_DjinniVizier = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Djinni Vizier @{Cwhite}(earth)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A regal-looking humanoid dressed in the robes of a prince stands here\.|The Efreeti Pasha is here)" uzi_wellsubs_substitute_EfreetiPasha = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Efreeti Pasha @{Cwhite}(ice)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A tall, imposing humanoid hovers in the water here, scowling at you|The Marid Padishah is here)" uzi_wellsubs_substitute_MaridPadishah = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Marid Padishah @{Cwhite}(fire)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(An imposing humanoid with turquoise skin hovers in the water here\.|The Marid Shah is here)" uzi_wellsubs_substitute_MaridShah = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Marid Shah @{Cwhite}(fire)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A fearsome Balrog is here\.|The Balrog is here)" uzi_wellsubs_substitute_Balrog = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Balrog @{Cwhite}(earth?/slay mythical, forceflee)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A tall, imposing humanoid within a storm, looks down on you with disdain\.|The Djinni Caliph is here)" uzi_wellsubs_substitute_DjinniCaliph = \
    /substitute -p %{PL}--- @{nCyellow}Djinni Caliph @{Cwhite}(earth)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(A tall, imposing humanoid stands here, looking down upon you with scorn\.|The Efreeti Sultan is here)" uzi_wellsubs_substitute_EfreetiSultan = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Efreeti Sultan @{Cwhite}(ice)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(Morgoth the Valar God is standing in front of, yes - YOU!|Morgoth the Valar God is here)" uzi_wellsubs_substitute_Morgoth = \
    /substitute -p %{PL}@{Cred}AGG @{nCyellow}Morgoth @{Cwhite}(mythical?/earth, forceflee)%{PR}

/def -p99 -F -Ewellsubs -mregexp -t"(Gond the Wonderbringer is here, examining a small gem through an eyepiece|Gond is here)" uzi_wellsubs_substitute_Gond = \
    /substitute -p %{PL}--- @{nCyellow}Gond @{Cwhite}(give crystal/transform to ktv/buy <stat>)%{PR}
