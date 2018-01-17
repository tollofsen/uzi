; // vim: set ft=tf:

/def -ag -p2147483647 -hREDEF gagredef

; Used for setting a delay on trigger


;==============================================================================
;   Several commands in one
;   To send several commands in one line. Any line starting with a semicolon
;   will be split up by semicolon.
;   Example: ";north;tell zzz summon;cast 'wither' dragon"
;==============================================================================

/alias ; /splitline %{*}
/def splitline = \
    /let args=%*%; \
    /let i=0%; \
    /while ((i:=strchr(args, ";")) >= 0) \
        /eval $[substr(args, 0, i)]%; \
        /let args=$[substr(args, i+1)]%; \
    /done%; \
    /eval %args
/def -p3 -h"SEND ;*" expandhook = /splitline %{*}


/alias delay /repeat -%{1} 1 %{-1}


;;Common Aliases
/alias b /butch %{*}
/alias bl bleedlog show group
/alias calc \
    /test calc:=(%{*})%;\
    /echo -a -p @{BCyellow}>> @{nBCwhite} %{calc}

/alias cast \
    /send cast %{*}%;\
    /set lspell2=%{lspell}%;\
    /set lspell=cast %{*}%;\
    /eval /echo -a -p %{htxt2}cast $[toupper({*})]

/alias cr \
    get all %{char}%;\
    wield %{weapon}%;\
    grab %heldeq%;\
    wear all%;\
    get all %{char}%;\
    wear all%;\
    get %{char}%;\
    donate %{char}

/alias dir look north%;look east%;look south%;look west%;look up%;look down
/alias di display %r%h(%H)H %p(%P)M %m(%M)V > %L
/alias dl damlog show group
/alias el explog show group
/alias fl fraglog show
/alias exp explog show
/alias gall get all all.corpse
/alias gags /gags
/alias gc /gc %*
/alias gg /gg
/alias gl glance %{*}
/alias glog damlog show group%; bleedlog show group%; heallog show group%;fraglog show group%;hitlog show group%;explog show group
/alias glogr damlog reset group%; bleedlog reset group%; heallog reset group%;fraglog reset group%;hitlog reset group%;explog reset group
/alias gr group %{*}
/alias m group priest
/alias hl heallog show group
/alias od open door %{*}
/alias of order followers %*
/alias ord order followers RECALL
/alias weap /w %{*}


/alias opp \
    /if ({1}=~'') \
        /ecko Error, syntax: opp <character>%;\
        /break%;\
    /else \
        /let _char=%1%;\
        /let _temp=$[world_info(_char,"password")]%;\
        /if (_temp=~'') /ecko No passwords stored for %_char%;/break%;\
        /else open %_char %_temp%;\
        /endif%;\
    /endif

/alias q qq %*
/alias qq gc %1 potion quaff %*
/alias pc /pc %*
/if (fighter|templar>0) \
    /alias r rescue%;\
    /if (rogue=0) \
        /alias peek tell %%{peeker} peek %%{*}%;\
        /alias pk peek %%{*}%;\
    /endif%;\
/else \
    /alias r retreat%%;%%{*}%;\
/endif

/alias rr gc %1 scroll recite %*
/alias rl get rec %{container}%;rec recall %{*}
/alias so score
/alias st stand
/alias t tell %{*}
/alias tp rub%;transport %{*}
/alias weara wear all

/if (fighter>0) \
    /alias h headbang %%{*}%%;/eval /echo -a -p %%{htxt2}HEADBANG %%{*}%;\
    /alias hb headbang %%{*}%%;/eval /echo -a -p %%{htxt2}HEADBANG %%{*}%;\
    /alias head headbang %%{*}%%;/eval /echo -a -p %%{htxt2}HEADBANG %%{*}%;\
    /alias tipi build tipi%;\
/endif

;;Caster Spells
/if (magician|warlock|templar>0) \
    /alias str cast 'strength' %%{*}%;\
/endif

/if (magician|warlock|templar|priest|nightblade>0) \
    /alias arm cast 'armor' %%{*}%;\
/endif

/if (nightblade|priest>0) \
    /alias slife cast 'sense life'%;\
/endif

/if (warlock|nightblade|templar>0) \
    /lood modules/immo.m%;\
/endif

/if (magician|warlock>0) \
    /alias blur cast 'blur'%;\
    /alias di cast 'detect invis'%;\
    /alias hs cast 'haste'%;\
    /alias haste cast 'haste'%;\
    /alias inv cast 'invisibility' %%{*}%;\
    /alias imp cast 'improved invisibility' %%{*}%;\
    /alias mord /if (morden=1) /ecko Already using mordens!?%%;/else cast 'Mordenkainen's Sword'%%;/endif%;\
    /alias tele cast 'Teleport Without Error'%;\
    /alias telep cast 'teleport'%%;/set lspell=nothing%%;/set hometown=telep%;\
/elseif (priest>0) \
    /alias di cast 'detect invis'%;\
    /alias tele cast 'word of recall'%;\
/elseif (nightblade>0) \
    /alias blur cast 'Blur'%;\
    /alias di cast 'detect invis'%;\
    /alias tele cast 'Teleport Without Error'%;\
/else \
    /if (!rogue>0) \
        /alias di gc detect potion quaff detect%;\
    /endif%;\
    /alias tele recall%;\
/endif

;;Magician Spells
/def cop = \
    /if (position=/'rest' | position=/'sit') \
        /set standtocast=1%;\\
        stand%;cast 'Circle Of Protection'%;rest%;\
    /elseif (fighting=0 & sentassist=0) \
        cast 'Circle Of Protection'%;\
    /else \
        retreat%;cast 'Circle Of Protection'%;/set sentassist=0%;\
    /endif%;\
    /set lspell=cop

/if (magician>0) \
    /alias blindness cast 'Blindness' %%{*}%;\
    /alias bh cast 'Burning Hands' %%{*}%;\
    /alias bm cast 'Blood Mirror'%;\
    /alias ck cast 'Cloudkill'%;\
    /alias charm cast 'Charm Person' %%{*}%;\
    /alias cl cast 'Chain Lightning'%;\
    /alias ct cast 'Chill Touch' %%{*}%;\
    /alias cont cast 'Contingency'%;\
    /alias cop /cop%;\
    /alias copon /set coptype=2%%;/set acop=1%%;/set autocop=1%%;/ecko %%{htxt2}AGRO%%{ntxt}cop%%{ntxt2}[%%{htxt}ON%%{ntxt2}] %%{htxt2}RE%%{ntxt}cop%%{ntxt2}[%%{htxt}ON%%{ntxt2}]%;\
    /alias copoff /set coptype=1%%;/set acop=0%%;/set autocop=0%%;/ecko %%{htxt2}AGRO%%{ntxt}cop%%{ntxt2}[%%{htxt}OFF%%{ntxt2}] %%{htxt2}RE%%{ntxt}cop%%{ntxt2}[%%{htxt}OFF%%{ntxt2}]%;\
    /alias cs cast 'Colour Spray' %%{*}%;\
    /alias chill cast 'Chill Touch' %%{*}%;\
    /alias cw cast 'Control Weather' %%{*}%;\
    /alias curse cast 'Curse' %%{*}%;\
    /alias dd cast 'dimension door' %%{*}%;\
    /alias dm cast 'Detect Magic' %%{*}%;\
    /alias drain cast 'Energy Drain' %%{*}%;\
    /alias dv cast 'Darkvision'%;\
    /alias enchant cast 'Enchant Weapon' %%{*}%;\
    /alias fb cast 'Fireball' %%{*}%;\
    /alias feeble cast 'Feeblemind' %%{*}%;\
    /alias fly cast 'Fly' %%{*}%;\
    /alias hf cast 'Hell Fire' %%{*}%;\
    /alias hst cast 'Hell Storm'%;\
    /alias mm cast 'Magic Missile' %%{*}%;\
    /alias id cast 'Identify' %%{*}%;\
    /alias ist cast 'Ice Storm'%;\
    /alias lb cast 'Lightning Bolt' %%{*}%;\
    /alias locate cast 'Locate Object' %%{*}%;\
    /alias mb cast 'Meteor Blast' %%{*}%;\
    /alias mi cast 'Mirror Image'%;\
    /alias mirror cast 'Blood Mirror'%;\
    /alias mpain cast 'Mass Pain'%;\
    /alias mswarm cast 'Meteor Swarm'%;\
    /alias pblind cast 'Powerword Blind' %%{*}%;\
    /alias pwp cast 'Powerword Pain' %%{*}%;\
    /alias sg cast 'Shocking Grasp' %%{*}%;\
    /alias slp cast 'Sleep' %%{*}%;\
    /alias vamp cast 'Vampiric Mist' %%{*}%;\
    /alias vent cast 'Ventriloquate' %%{*}%;\
    /if (magician=2) \
        /alias dsp cast 'Deathspell'%;\
        /alias for cast 'Force Bolt' %%{*}%;\
        /alias ffield cast 'Force Field'%;\
        /alias gimp cast 'Group Invisibility'%;\
        /alias ginv cast 'Group Invisibility'%;\
        /alias gfly cast 'Magic Carpet'%;\
        /alias pkill cast 'Powerword Kill' %%{*}%;\
        /alias pb cast 'Plasma Bolt' %%{*}%;\
        /alias pball cast 'Plasma Ball'%;\
        /alias rite cast 'Blood Rite'%;\
        /alias sst cast 'Soulsteal' %%{*}%;\
    /endif%;\
/endif

;;Warlock Spells
/if (warlock>0) \
    /alias bt cast 'Bladeturn'%;\
    /alias cc cast 'Combat'%;\
    /alias combat cast 'Combat'%;\
    /alias fb cast 'Fire Bolt' %%{*}%;\
    /alias h headbang %%{*}%%;/eval /echo -a -p %%{htxt2}HEADBANG %%{*}%;\
    /alias hb headbang %%{*}%%;/eval /echo -a -p %%{htxt2}HEADBANG %%{*}%;\
    /alias head headbang %%{*}%%;/eval /echo -a -p %%{htxt2}HEADBANG %%{*}%;\
    /alias ib cast 'Ice Bolt' %%{*}%;\
    /alias immo /immo %%{*}%;\
    /alias immof /immo fire%;\
    /alias immoc /immo cold%;\
    /alias mshield cast 'Mana Shield'%;\
    /alias nb cast 'Nether Bolt' %%{*}%;\
    /alias sb cast 'Shock Bolt' %%{*}%;\
    /alias wb cast 'Water Bolt' %%{*}%;\
    /alias mglance cast 'Mental Glance'%;\
    /if (warlock=2) \
        /alias tof cast 'Triad Of Fire' %%{1} %%{2} %%{3}%;\
        /alias toi cast 'Triad Of Ice' %%{1} %%{2} %%{3}%;\
        /alias rite cast 'Blood Rite'%;\
        /alias rop cast 'Ritual Of Pain'%;\
    /endif%;\
/endif

;;Rogue Backstab
/if (rogue>0) \
    /alias ba backstab %%{*}%%;/eval /echo -a -p %%{htxt2}BACKSTAB %%{*}%;\
/endif

;;Nightblade Spells
/if (nightblade>0) \
    /alias a assassinate %%{*}%%;/eval /echo -a -p %%{htxt2}ASSASSINATE %%{*}%;\
    /alias adr cast 'Adrenal Focus'%;\
    /alias att cast 'attack' %%{*}%;\
    /alias aod /despair %%{*}%;\
    /alias blind cast 'Blindness' %%{*}%;\
    /alias mer merge %%{*}%;\
    /alias dp cast 'Detect Poison' %%{*}%;\
    /alias imp cast 'improved invisibility'%;\
    /alias m murder %%{*}%;\
    /alias mh cast 'Mountain Heart'%;\
    /alias po cast 'poison' %%{*}%;\
    /alias rp cast 'Remove Poison' %%{*}%;\
    /alias sd cast 'Shadow Displacement' %%{*}%;\
    /alias sform cast 'Shadow Form'%;\
    /alias murder /send murder %%{*}%%;/eval /echo -a -p %%{htxt2}MURDER %%{*}%;\
    /if (nightblade=2) \
        /alias dv cast 'Darkvision'%;\
        /alias dshadow cast 'Deathshadow'%;\
        /alias lblood cast 'Life Blood'%;\
        /alias venom cast 'Venom' %%{*}%;\
    /endif%;\
/endif

;;Templar Spells
/if ({templar} > 0) \
    /alias aura /haura %%{*}%;\
    /alias bless cast 'Bless' %%{*}%;\
    /alias chan cast 'Channel' %%{*}%;\
    /alias channel cast 'Channel' %%{*}%;\
    /alias cc cast 'Cure Critic' %%{*}%;\
    /alias critic cast 'Cause Critic' %%{*}%;\
    /alias da cast 'Detect Alignment'%;\
    /alias disp cast 'Dispel' %%{*}%;\
    /alias dispel cast 'Dispel' %%{*}%;\
    /alias dp cast 'Detect Poison' %%{*}%;\
    /alias harm cast 'Holy Armor'%;\
    /alias haura /haura %%{*}%;\
    /alias heal cast 'Heal' %%{*}%;\
    /alias jdg cast 'Judgement' %%{*}%;\
    /alias jm cast 'Judgement' %%{*}%;\
    /alias judge cast 'Judgement' %%{*}%;\
    /alias light cast 'Cure Light' %%{*}%;\
    /alias prot cast 'Protection' %%{*}%;\
    /alias serious cast 'Cure Serious' %%{*}%;\
    /alias pacify cast 'Pacify' %%{*}%;\
    /alias pr cast 'Prayer'%;\
    /alias pray cast 'Prayer'%;\
    /alias prayer cast 'Prayer'%;\
    /alias rc cast 'Remove Curse' %%{*}%;\
    /alias rp cast 'Remove Poison' %%{*}%;\
    /alias sanc cast 'Sanctuary' %%{*}%;\
    /if ({templar} == 2) \
        /alias suff cast 'Sufferage' %%{*}%;\
        /alias sufferage cast 'Sufferage' %%{*}%;\
        /alias mira cast 'Miracle' %%{*}%;\
        /alias hc cast 'Holy Crusade'%;\
    /endif%;\
/endif

;;Priest Spells
/if (priest>0) \
    /alias aid cast 'Aid'%;\
    /alias animate cast 'Animate Dead' %%{*}%;\
    /alias bless cast 'Bless' %%{*}%;\
    /alias blind cast 'Blindness' %%{*}%;\
    /alias cb cast 'Cure Blind' %%{*}%;\
    /alias chan cast 'Channel' %%{*}%;\
    /alias channel cast 'Channel' %%{*}%;\
    /alias conf cast 'Confusion'%;\
    /alias cc cast 'Cure Critic' %%{*}%;\
    /alias critic cast 'Cause Critic' %%{*}%;\
    /alias da cast 'Detect Alignment'%;\
    /alias dispel cast 'Dispel' %%{*}%;\
    /alias dm cast 'Detect Magic'%;\
    /alias dp cast 'Detect Poison' %%{*}%;\
    /alias eqs cast 'Earthquake'%;\
    /alias food cast 'Create Food'%;\
    /alias heal cast 'Heal' %%{*}%;\
    /alias harm cast 'Powerharm' %%{*}%;\
    /alias holy cast 'Holyword'%;\
    /alias light cast 'Call Lightning'%;\
    /alias link cast 'Link' %%{*}%;\
    /alias major cast 'Major Sphere Of Regeneration'%;\
    /alias minor cast 'Minor Sphere Of Regeneration'%;\
    /alias pacify cast 'Pacify' %%{*}%;\
    /alias poison cast 'Poison' %%{*}%;\
    /alias pow cast 'Powerheal' %%{*}%;\
    /alias pray cast 'Prayer'%;\
    /alias prot cast 'Protection'%;\
    /alias rc cast 'Remove Curse' %%{*}%;\
    /alias regen cast 'Regenerate' %%{*}%;\
    /alias rev cast 'Revitalize' %%{*}%;\
    /alias revit cast 'Revitalize' %%{*}%;\
    /alias rp cast 'Remove Poison' %%{*}%;\
    /alias sanc cast 'Sanctuary' %%{*}%;\
    /alias serious cast 'Cause Serious' %%{*}%;\
    /alias summon cast 'Summon' %%{*}%%;/set lastsum=%%{*}%;\
    /alias water cast 'Create Water' %%{*}%;\
    /alias weather cast 'Control Weather'%;\
    /alias wor cast 'Word Of Recall'%;\
    /alias wither cast 'Wither' %%{*}%;\
    /if (priest=2) \
        /alias garm cast 'Group Armor'%;\
        /alias gate cast 'Holy Gate' %%{*}%;\
        /alias gbless cast 'Group Bless'%;\
        /alias gheal cast 'Groupheal'%;\
        /alias gpow cast 'Grouppowerheal'%;\
        /alias mira cast 'Miracle' %%{*}%;\
        /alias true cast 'Trueheal' %%{*}%;\
        /alias wog cast 'Wrath Of God' %%{*}%;\
    /endif%;\
/endif

;;Animist
/if (animist > 0) \
    /alias arm cast 'Armor' %%*%;\
    /alias di cast 'Detect Invisibility'%;\
    /alias cl cast 'Cure Light' %%*%;\
    /alias bark cast 'Barkskin'%;\
    /alias eaq cast 'Earthquake'%;\
    /alias ff cast 'Faerie Fire' %%*%;\
    /alias cc cast 'Charm Creature %%*%;\
    /alias hurricane cast 'Hurricane'%;\
    /alias cs cast 'Cure Serious' %%*%;\
    /alias sat cast 'Satiate' %%*%;\
    /alias cl cast 'Call Lightning' %%*%;\
    /alias cw cast 'Control Weather' %%*%;\
    /alias ent cast 'Entangle' %%*%;\
    /alias rp cast 'Remove Poison' %%*%;\
    /alias sa cast 'Sun Arrow' %%*%;\
    /alias eagle cast 'Call Of The Eagle'%;\
    /alias asummon cast 'Animal Summoning'%;\
    /alias sr cast 'Sun Ray'%;\
    /alias cc cast 'Cure Critic' %%*%;\
    /alias sshield cast 'Sun Shield'%;\
    /alias gb cast 'Good Berry'%;\
    /alias fseed cast 'Fire Seeds' %%*%;\
    /alias gsize cast 'Giant Size'%;\
    /alias armt cast 'Armor Of Thorns'%;\
    /alias heal cast 'Heal' %%*%;\
    /alias tree cast 'Treeform'%;\
    /alias cearth cast 'Conjure Earth Elemental'%;\
    /alias sts cast 'Sticks To Snakes' %%*%;\
    /alias cair cast 'Conjure Air Elemental'%;\
    /alias cwater cast 'Conjure Water Elemental'%;\
    /alias ip cast 'Insect Plague' %%*%;\
    /if (animist=2) \
        /alias pg cast 'Plant Growth'%;\
        /alias tranq cast 'Tranquility'%;\
        /alias burst cast 'Burst Of Life' %%*%;\
        /alias cos cast 'Circle Of Stone'%;\
        /alias gaias cast 'Gaias Beacon'%;\
        /alias swarm cast 'Deadly Swarm'%;\
        /alias cphoenix cast 'Conjure Phoenix'%;\
        /alias nb cast 'Natures Blessing'%;\
    /endif%;\
/endif


/alias tele /tele
/purge gagredef
;;;;;;;
