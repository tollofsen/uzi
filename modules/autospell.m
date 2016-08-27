;// vim: set ft=tf:
;;;;;;;;;;;;;;;;;;;;;
;ReCast on lost conc;
;;;;;;;;;;;;;;;;;;;;;
/def -aBCred -mglob -t'You lost your concentration!' recast = \
    /if (sanc=0 & autoholy=1 & priest>0 & fighting=1) \
        cast 'Holyword'%;\
        /set sentdamage=0%;\
    /elseif (lspell =~ '_damage_') \
        /repeatdamage%;\
    /elseif (lspell!~ 'nothing') \
        /if (standtocast>0) \
            stand%;\
            %{lspell}%;\
            %{position}%;\
        /else \
            %{lspell}%;\
        /endif%;\
    /endif%;\
    /if (fighting=0) \
        /set sentdamage=0%;\
    /endif


/def -aBCred -mglob -t'You cant seem to do that here!*' nomag = \
    /set lspell=nothing%;/set spellup=null%;/set exitspellup=0%;/set nomag=1%;\
    /if (xsdamage=1 & panicrecallcmd !~ '') \
        /eval %panicrecallcmd%;\
    /endif%;\
    /repeatdamage

/def -mglob -p999 -t'* tells you \'No magic here - kid!\'' nomag2 = \
    /set lspell=nothing%;/set spellup=null%;/set exitspellup=0

;;;;;;;;;;;;;;;;
;Loosing Spells;
;;;;;;;;;;;;;;;;
/def -p2 -aCmagenta -mglob -t'You feel yourself exposed.' reimp = \
    /respell imp

/def -p2 -aBCyellow -mglob -t'Your surroundings start to change!' recontin = \
    /set contingency=0%;\
    /set fighting=0%;\
    /beep%;\
    /if (hometown=/'myrridon') \
        w%;w%;\
    /else \
        s%;\
    /endif%;\
    gtf , worships the God of &+RContingency!%;\
    /respell contingency

/def -p2 -aCmagenta -mglob -t'Your ability to see in the dark is no more.' redv = \
    /respell dv

/def -p2 -aCmagenta -mglob -t'Your contingency fails, TOUGH LUCK!' recontin2 = \
    /set contingency=0%;\
    tele

/def -p2 -aCmagenta -mglob -t'You try to escape, but your surroundings disable your contingency!' recontin3 = \
    /set contingency=0%;\
    ps

/def -p2 -aCmagenta -mregexp -t'^You feel less protected.$|^You see a shining set of armor materialize in the air before you, then it suddenly dissolves.$' rearm = \
    /respell arm

/def -p2 -aCmagenta -mglob -t'You stop blurring!' reblur = \
    /respell blur

/def -p2 -aCmagenta -mglob -t'You feel less protected from all the horrible things in the world.' reprotection = \
    /respell protection

/def -p2 -aCmagenta -mglob -t'You shiver slightly as your body system slows down.' reregen = \
    /if (priest=0 & askpr!~'' & (ismember({askpr}, glist) > 0)) \
        ask %{askpr} regen%;\
    /endif%;\
    /respell regen

/def -p2 -aCmagenta -mglob -t'You feel less righteous.' rebles = \
    /respell bles

/def -p2 -aCmagenta -mglob -t'You feel less spiritual.' reprayer = \
    /respell prayer

/def -p2 -aCmagenta -msimple -t'The wings on your back shrink into nothingness.' refly = \
    /respell fly

/def -p2 -aCmagenta -mglob -t'You feel weaker.' restr = \
    /respell str

/def -p2 -aCmagenta -mglob -t'Your magical sword disappears.' remord = \
    /if (weapon=/'morden') \
        /respell morden%;\
    /else \
        wield %{weapon}%;\
    /endif

/def -p2 -aCmagenta -mglob -t'Your holy suit of armor dissolves.' reharm = \
    /respell harm

/def -p2 -aCmagenta -mglob -t'You relax a bit.' recombat = \
    /respell combat

/def -p2 -aCmagenta -mglob -t'The world suddenly starts spinning.' rehaste = \
    /respell haste

/def -p2 -aCmagenta -mglob -t'Your ties with life\'s blood fades.' relblood = \
    /respell lblood

/def -p2 -aCmagenta -mglob -t'Your magical forcefield dissolves as the effort to maintain it becomes too much.' remirror = \
    /respell bmirror

/def -p2 -aCmagenta -mglob -t'The detect invisible wears off.' redi = \
    /respell di

/def -p2 -aCmagenta -mglob -t'You grind your teeth in pain as you realize how hurt you actually are.' remh = \
    /respell mh

/def -p2 -aCmagenta -mglob -t'You let out a soft sigh as the space time continuum returns to normal.' rems = \
    /respell ms

/def -p2 -aCmagenta -mglob -t'You now feel all of your opponents blows.' reffield = \
    /respell ffield

/def -p2 -aBCred -msimple -t"You feel better as your magical field dissolves." reritual = \
    /respell ritual

/def -p2 -aCmagenta -mglob -t'You can no longer sense your invisible sphere of turning.' reblade = \
    /if (((leading|solo)=1)&(abt=1)&(fighting=0)&(warlock>0)) \
        bt%;\
    /endif

/def -p2 -aCmagenta -mglob -t'The white aura around your body fades.' resanc = \
    /set sanc=0%;/set holy=0%;\
    /if (sanc=0 & autoholy=1 & priest>0 & fighting=1) \
        cast 'Holyword'%;\
    /else \
        /respell sanc%;\
    /endif

/def -p2 -aCmagenta -mglob -t'Your sun shield wears off.' resshield = \
    /respell sshield

/def -p2 -aCmagenta -mglob -t'Your thorns wither to death and drop to your feet.' rethorns = \
    /set thorns=0

/def -p2 -aCmagenta -mglob -t'You feel much weaker.' regsize = \
    /respell gsize

/def -p2 -aCmagenta -mglob -t'You stretch out for your shadow...' resd = \
    /respell sd

/def -p2 -aCmagenta -mglob -t'You once again feel naked.' rebark = \
    /respell bark

/def -F -p2 -aCmagenta -mglob -t"Your kaleidoscopic mirage collapses in on itself as the magics expire." autospell_mirrorimage = \
    /respell mirrorimage

/def -p2 -aBCred -mglob -t'The ancient looking runes on the ground wither apart.' lostcop = \
    /set coppen=1%;/set cop=0%;\
    /if (magician>0) \
        /if (acop=1) \
            cop%;\
        /else \
            /ecko The cop is OUT, will you recop!?%;\
        /endif%;\
    /endif

/def -mregexp -t'^([^ ]*) tells you \'copon\'' tellcop2 = \
    /if ({P1}={tank}) \
        tell %{tank} &+CAGRO&+ccop &+W[&+GON&+W] &+CRE&+ccop &+W[&+GON&+W]%;\
        /set coptype=2%;/set acop=1%;/set autocop=1%;\
    /endif

/def -mregexp -t'^([^ ]*) tells you \'copoff\'' tellcop3 = \
    /if ({P1}={tank}) \
        tell %{tank} &+CAGRO&+ccop &+W[&+ROFF&+W] &+CRE&+ccop &+W[&+ROFF&+W]%;\
        /set coptype=1%;/set acop=0%;/set autocop=0%;\
    /endif


/def -mregexp -t'^([^ ]*) tells you \'acop\'' tellcop = \
    /if ({P1}={tank}) /acop%;\
        /if (coptype=1) \
            tell %{tank} &+cSomeone else will do the copping.%;\
        /elseif (coptype=2) \
            tell %{tank} &+cAutomatically copping &+Raggro &+c+ keeping &+Rcops down&+c.%;\
        /elseif (coptype=3) \
            tell %{tank} &+cKeeping &+Rcops down &+cif they bail.%;\
        /else  \
            tell %{tank} &+cAutomatically copping &+Raggro &+crooms.%;\
        /endif%;\
    /endif

/set cop=0
/def acop = \
    /if (coptype=4) \
        /ecko 1. Someone else will do the copping.%;\
        /set autocop=0%;\
        /set acop=0%;\
        /if (assist=1) \
            togg aggressive on%;\
            togg autoassist on%;\
            /set autofight=1%;\
        /endif%;\
        /set coptype=1%;\
        /set acopp=off%;\
    /elseif (coptype=1) \
        /ecko 2. Automatically copping + keeping cops up.%;\
        togg aggressive off%;\
        togg autoassist off%;\
        /set autofight=0%;\
        /set autocop=1%;\
        /set acop=1%;\
        /set coptype=2%;\
        /set acopp=on%;\
    /elseif (coptype=2) \
        /ecko 3. Keeping cops if they bail.%;\
        /set acop=1%;\
        /set autocop=0%;\
        /if (assist=1) \
            togg aggressive on%;\
            togg autoassist on%;\
            /set autofight=1%;\
        /endif%;\
        /set coptype=3%;\
        /set acopp=bail%;\
    /else \
        /ecko 4. Automatically copping aggro rooms.%;\
        /set acop=0%;\
        /set autocop=1%;\
        togg aggressive off%;\
        togg autoassist off%;\
        /set autofight=0%;\
        /set coptype=4%;\
        /set acopp=aggro%;\
    /endif


;************Getting Spells*****************

/def -p2 -aB -aCmagenta -mregexp -t'^You smile as an armor spell is now protecting you.$\
    |^You catch a glimpse of a shining armor hanging in the air, then it goes invisible.$\
    |^You catch a glimpse of a shining armor hanging in the air around you, then it goes invisible.$\
    |^With a flick of your hand you call upon magic to protect you.$\
    |^The Lords of Orhan accept your plea for protection.$\
    |^The Lords of Orhan elect to renew your armor spell.$\
    |^You concentrate upon your magic armor and channel more power into it.$\
    |^You update your armor spell.$\
    |^You feel the Lords of Orhan protecting you.$\
    |^You feel someone protecting you.$' gotarm = \
    /set arm=1%;/gotspell arm
/def -p2 -aBCmagenta -mglob -t'*The ground gets covered with ancient runes of protection.*' gotcop = \
    /set cop=1%;/set coppen=0%;\
    /if (fighting=0) \
        /endoffight%;\
    /endif

/def -F -p2 -aBCmagenta -mglob -t'*The ground is covered with ancient looking runes.*' gotcop2 = \
    /set coppen=0%;/set cop=1

/def -p2 -aBCmagenta -mglob -t'{*} quickly circles the area, drawing ancient runes on the ground.' gotcop3 = \
    /set coppen=0%;/set cop=1

/def -p2 -aBCmagenta -mregexp -t'^The dark elemental blesses you with the power to see in the dark.$|^The dark elemental agrees to renew your darkvision.$' gotdv = \
    /set dv=1%;/gotspell dv

/def -p2 -aBCmagenta -msimple -t'Suddenly the world starts to slow down.' gothaste = \
    /set haste=1%;/gotspell haste

/def -p2 -aBCmagenta -msimple -t'Cool it, any more haste and you would get a heart attack.' gothaste2=\
    /set haste=1%;/gotspell haste

/def -p2 -aBCmagenta -msimple -t'Combat we shall, now fast and hard!' gotcombat = \
    /set combat=1%;/gotspell combat

/def -p2 -aBCmagenta -msimple -t'You will keep yourself alert for a while longer.' gotcombat2 = \
    /set combat=1%;/gotspell combat

/def -p2 -aBCmagenta -mglob -t'You focus your energy and create a reflective shield about your body.' gotmirror = \
    /set bmirror=1%;/spellup bmirror

/def -p2 -mglob -t'You wield a {Green|Golden|Red} force blade.' gotmord = \
    /set morden=1%;/gotspell morden

/def -p2 -aBCmagenta -mglob -t'You lack the energy to create another sword.*' gotmord2 = \
    /set morden=1%;/gotspell morden

/def -p2 -aBCmagenta -mregexp -t'^You make your holy suit of armor stay a while longer.$|^You make the sign of the cross. Protect me my deity!$' gotharm = \
    /set harm=1%;/gotspell harm

/def -p2 -aBCmagenta -mregexp -t'^Your eyes tingle.$|^Your eyes tingle briefly.$|^You cast a spell of detect invisibility.$' gotdi = \
    /set di=1%;/gotspell di

/def -p2 -aBCmagenta -mregexp -t'^You feel stronger.$|^You tense your hard muscles.$' gotstr = \
    /set str=1%;/gotspell str

/def -p2 -aBCmagenta -mregexp -t'^You start to blur in and out of phase.$|^You blur a bit longer.$' gotblur = \
    /set blur=1%;/gotspell blur

/def -p2 -aBCmagenta -msimple -t'You vanish.' gotimp = \
    /set imp=1%;/gotspell imp

/def -p2 -aBCmagenta -mregexp -t'^You meld with the shadows.$|^You draw the shadows around you again.$' gotmask = \
    /set mask=1%;/gotspell mask

/def -p2 -aBCmagenta -msimple -t'No pain no gain!' gotmh = \
    /set mh=1%;/gotspell mh

/def -p2 -aBCmagenta -mregexp -t'^You grow small black bat-wings and start flapping.$|^You make your wings stay longer.$' gotfly = \
    /set fly=1%;/gotspell fly

/def -p2 -aBCmagenta -msimple -t'You rip a rift in the space-time continuum connecting your soul with your body.' gotms = \
    /set ms=1%;/gotspell ms

/def -p2 -aBCmagenta -mregexp -t'^You feel a slight sensation as your body system speeds up.$|^You feel comfortable as you prolong your regenerative powers.$' gotregen = \
    /set regen=1%;/gotspell regen

/def -p2 -aBCmagenta -mregexp -t'^You start glowing.$|^You glow even brighter.$' gotsanc = \
    /if (sanc=0) \
        /set holy=0%;\
    /endif%;\
    /set holy=$[holy+1]%;\
    /set sanc=1%;\
    /gotspell sanc

/def -p2 -aBCmagenta -msimple -t'You are protected from great harm!!!' gotconting = /set contingency=1%;/gotspell contingency

/def -p2 -aBCmagenta -mregexp -t'^You have a righteous feeling!$|^Praise the Lords, your plea for extra protection is granted!$' gotprotection = /set protection=1%;/gotspell protection

/def -p2 -aBCmagenta -mregexp -t'^You bless yourself again, for safety\'s sake.|^You bless yourself. Glory B!$|^You feel righteous.$' gotbless = \
    /set bles=1%;/gotspell bles

/def -p2 -aBCmagenta -msimple -t'You focus your mind and create a magical force field around you.' gotffield = \
    /set ffield=1%;/gotspell ffield

/def -p2 -aBCmagenta -mregexp -t'^You feel spiritual.$|^You pray for yourself again\, for safety\'s sake.$' gotpray = /set prayer=1%;/gotspell prayer

/def -p2 -aBCmagenta -mglob -t'Your shadow merges with*' gotsd = /set sd=1%;/gotspell sd

/def -p2 -aBCmagenta -mglob -t'{*} shadow refused to merge with your shadow.' gotsd2 = /set sd=1%;/gotspell sd

/def -p2 -aBCmagenta -mregexp -t'^Ah, much better now I look like a tree...$|^You remove the old dry bark, replacing it with a new fresh one.$' gotbark = \
    /set bark=1%;/gotspell bark

/def -p2 -aBCmagenta -mregexp -t'^You feel your muscles grow and stretch!$|^You already look like a bear!$' gotgsize = \
    /set gsize=1%;/gotspell gsize

/def -p3 -aBCmagenta -mregexp -t'^You feel the heat of the sun as you start glowing.$|^Sunny day today, isn\'t\?$' gotsshield = \
    /set sshield=1%;/gotspell sshield

/def -p2 -aBCmagenta -msimple -t'Eight-inch, wickedly-sharp thorns sprout from your barkskin!' gotthorns = \
    /set thorns=1%;/gotspell thorns

/def -p2 -aBCmagenta -msimple -t'The dark elemental blesses you with the power to see in the dark.' = gotdv = \
    /set dv=1%;/gotspell dv

/def -p2 -aCmagenta -mregexp -t'^You renew your ties to life blood.$|^A warm feeling fills your body as you channel life\'s blood from within.$' gotlblood = \
    /set lblood=1%;/gotspell lblood

/def -p2 -aBCred -mregexp -t'^You bleed more freely but you feel an inner energy building inside you.$|^Your field of pain absorbs your magic.$' gotritual = \
    /set ritual=1%;/gotspell ritual

/def -p2 -F -msimple -t"You become a blur of kaleidoscopic color and split into mirror images of yourself." gotmirrorimage = \
    /set mirrorimage=1%;/gotspell mirrorimage


/def ma= \
    /set mage=%{1}%;\
    /ecko Magician set to: %{htxt2}%{mage}

/def pr= \
    /set askpr=%{1}%;\
    /ecko Priest set to: %{htxt2}%{askpr}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;,,

;;;;;;;;;;;
;;Affects;;
;;;;;;;;;;;

/def -F -mregexp -p1 -t'------ Affecting Spells ------' reset_affects= \
    /set spellup=null%;\
    /set focus=0%;\
    /set str=0%;\
    /set haste=0%;\
    /set arm=0%;\
    /set imp=0%;\
    /set blur=0%;\
    /set combat=0%;\
    /set mh=0%;\
    /set ms=0%;\
    /set haura=0%;\
    /set sanc=0%;\
    /set fly=0%;\
    /set bles=0%;\
    /set prayer=0%;\
    /set regen=0%;\
    /set ffield=0%;\
    /set di=0%;\
    /set lblood=0%;\
    /set immo=0%;\
    /set aod=0%;\
    /set harm=0%;\
    /set bmirror=0%;\
    /set protection=0%;\
    /set contingency=0%;\
    /set sshield=0%;\
    /set thorns=0%;\
    /set gsize=0%;\
    /set bark=0%;\
    /set mirrorimage=0%;\
    /set dv=0

/def -F -p100 -mglob -t'Immolation Fire         {\[*|P*}*' affimmof=/set immo=1%;/set immotype=fire
/def -F -p100 -mglob -t'Immolation Cold         {\[*|P*}*' affimmoc=/set immo=1%;/set immotype=cold
/def -F -p100 -mglob -t'Aura Of Despair         {\[*|P*}*' affaod=/set aod=1
/def -F -p100 -mglob -t'Adrenal Focus           {\[*|P*}*' affoc=/set focus=1
/def -F -p100 -mglob -t'Holy Aura               {\[*|P*}*' afhaura=/set haura=1
/def -F -p100 -mglob -t'Mana Shield             {\[*|P*}*' afms=/set ms=1
/def -F -p100 -mglob -t'Ritual Of Pain          {\[*|P*}*' afrit=/set ritual=1
/def -F -p100 -mglob -t'Mountain Heart          {\[*|P*}*' afmh=/set mh=1
/def -F -p100 -mglob -t'Life Blood              {\[*|P*}*' aflblood=/set lblood=1
/def -F -p100 -mglob -t'Combat                  {\[*|P*}*' afcom=/set combat=1
/def -F -p100 -mglob -t'Strength                {\[*|P*}*' afstr=/set str=1
/def -F -p100 -mglob -t'Invisibility            {\[*|P*}*' afimp=/set imp=1
/def -F -p100 -mglob -t'Haste                   {\[*|P*}*' afhas=/set haste=1
/def -F -p100 -mglob -t'Blur                    {\[*|P*}*' afblu=/set blur=1
/def -F -p100 -mglob -t'Contingency             Permanent.*' afcont=/set contingency=1
/def -F -p100 -mglob -t'Armor                   {\[*|P*}*' afarm=/set arm=1
/def -F -p100 -mglob -t'Darkvision              {\[*|P*}*' afdv=/set dv=1
/def -F -p100 -mglob -t'Detect Invisibility     {\[*|P*}*' afdet=/set di=1
/def -F -p100 -mglob -t'Regenerate              {\[*|P*}*' afreg=/set regen=1
/def -F -p100 -mglob -t'Holy Armor              {\[*|P*}*' afharm=/set harm=1
/def -F -p100 -mglob -t'Prayer                  {\[*|P*}*' afpra=/set prayer=1
/def -F -p100 -mglob -t'Force Field             {\[*|P*}*' afffield=/set ffield=1
/def -F -p100 -mglob -t'Protection              {\[*|P*}*' afprot=/set protection=1
/def -F -p100 -mglob -t'Bless                   {\[*|P*}*' afble=/set bles=1
/def -F -p100 -mglob -t'Fly                     {\[*|P*}*' affly=/set fly=1
/def -F -p100 -mglob -t'Sanctuary               {\[*|P*}*' afsanc=/set sanc=1%;/if (holy<1) /set holy=$[holy+1]%;/endif
/def -F -p100 -mglob -t'Blood Mirror            {\[*|P*}*' afbmirr=/set bmirror=1
/def -F -p100 -mglob -t'Barkskin                {\[*|P*}*' afbark=/set bark=1
/def -F -p100 -mglob -t'Sun Shield              {\[*|P*}*' afsun=/set sshield=1
/def -F -p100 -mglob -t'Giant Size              {\[*|P*}*' afgsize=/set gsize=1
/def -F -p100 -mglob -t'Armor Of Thorns         {\[*|P*}*' afthorns=/set thorns=1
/def -F -p100 -mglob -t'Mirror Image            {\[*|P*}*' afmirror=/set mirrorimage=1

/def -aBCred -mglob -t'Impossible!  You can\'t concentrate enough!' castonkill = \
    /set castonkill=1%;\
    /set spellingup=0%;\
    /set spellup=null%;\
    /set fighting=1%;\
    /if ((autocop=1)&(coppen=1)) \
        /set coppen=0%;\
        cop%;\
    /elseif (lspell=/'cop') \
        cop%;\
    /endif

/def -aBCred -mglob -t'Sorry, it ain\'t happening yet.' nospellcast = \
    /set castonkill=1%;\
    /set spellingup=0%;\
    /repeatdamage%;\
    /set spellup=null

/def -aBCred -mglob -t'You can\'t summon enough energy to cast the spell.' nomanacast = \
    /set castonkill=1%;\
    /set spellingup=0%;\
    /repeatdamage%;\
    /set spellup=null

/def aftertick = /spellup

/def -mregexp -aBCmagenta -t'^Nah... You feel too relaxed to do that...$|^You can\'t do this sitting!$|^Maybe you should get on your feet first\?$|^In your dreams, or what\?$' nospellsitting = \
    /set spellup=null%;\
    /set dofoc=0%;\
    /resetdamage%;\
    /if (leading=1 & rescuetype!=0) \
        /standresc%;\
    /endif

/def respell = \
    /debug - spellup=%{spellup}  .    casting=%{casting}%;\
    /eval -sfull /set %{1}=0%;\
    /if (fighting=0 & currentmana > 0 & sentassist=0) \
        /if (spellup!~'spelling') \
            /spellup%;\
        /elseif (spellup=~'null') \
            /set spellup=spelling%;\
            /dospellup %{1}%;\
        /else \
            /spellup %spellup%;\
        /endif%;\
    /endif%;\
    /debug - spellup=%{spellup}  .    casting=%{casting}

/def gotspell = \
    /debug Spellup- spellup=%{spellup}  .    casting=%{casting}%;\
    /if ({1}=~spellup | spellup=~'null') \
        /dospellup%;\
    /else \
        /repeat -0:00:15 1 /set spellup=null%;\
    /endif%;\
    /debug Spellup- spellup=%{spellup}  .    casting=%{casting}

/def spellup = \
    /debug Spellup- spellup=%{spellup}  .    casting=%{casting}%;\
    /if (fighting=0 & currentmana > 0) \
        /if (spellup!~'' & spellup=~{1} & casting!~{1}) \
            /set spellup=spelling%;/dospellup%;\
        /elseif (spellup=~'spelling') \
            /repeat -0:00:10 1 /set spellup=null%;\
        /elseif (spellup=~'null') \
            /set spellup=spelling%;/dospellup%;\
        /else \
            /set _check_spell=%%{%{1}}%;\
            /if (_check_spell=1) \
                /set spellup=null%;/dospellup%;\
            /else \
                /repeat -0:00:04 1 /set spellup=null%;\
            /endif%;\
        /endif%;\
        /debug Spellup- spellup=%{spellup}  .    casting=%{casting}%;\
        /set casting=%{1}%;\
    /endif

/def dospellup = \
    /set lspell= %;/set spellingup=1%;\
    /if (sanc=0 & autoholy=1 & (templar|priest)>0) \
        /if (ingroup>0 & priest>0) \
            cast 'Holyword'%;\
        /else \
            cast 'Sanctuary'%;\
        /endif%;\
        /set holy=0%;\
        /set spellup=sanc%;\
    /elseif (di=0 & race !/ 'ktv') \
        /if ((warlock|magician|priest|nightblade|animist)>0) \
            cast 'detect invisibility'%;\
        /else \
            gc detect%;quaff detect%;\
        /endif%; \
        /set spellup=di%;\
    /elseif (sshield=0 & animist>0) \
        cast 'Sun Shield'%;\
        /set spellup=sshield%;\
    /elseif (regen=0 & priest>0) \
        cast 'regenerate'%;\
        /set spellup=regen%;\
    /elseif (haste=0 & (warlock|magician)>0) \
        cast 'haste'%;\
        /set spellup=haste%;\
    /elseif (combat=0 & warlock>0) \
        cast 'Combat'%; \
        /set spellup=combat%;\
    /elseif (prayer=0 & (priest|templar)>0) \
        cast 'prayer'%;\
        /set spellup=prayer%;\
    /elseif (morden=0 & weapon=/'mord*') \
        cast 'Mordenkainen's Sword'%; \
        /set spellup=morden%;\
    /elseif (imp=0 & (magician|warlock|nightblade)>0 & (solo|selfprot)) \
        cast 'Improved Invisibility'%; \
        /set spellup=imp%;\
    /elseif (mh=0 & nightblade>0) \
        cast 'Mountain Heart'%; \
        /set spellup=mh%;\
    /elseif (str=0 & (magician|templar|warlock)>0 & strspell=1) \
        cast 'Strength'%;\
        /set spellup=str%;\
    /elseif (dv=0 & (magician>0|nightblade>1)) \
        cast 'Darkvision'%; \
        /set spellup=dv%;\
    /elseif (gsize=0 & animist>0) \
        cast 'Giant Size'%;\
        /set spellup=gsize%;\
    /elseif (arm=0 & (warlock|magician|templar|nightblade|priest|animist)>0 & (solo|selfprot)=1) \
        cast 'armor'%;\
        /set spellup=arm%;\
    /elseif (bark=0 & animist>0) \
        cast 'Barkskin'%;\
        /set spellup=bark%;\
    /elseif (bark=1 & thorns=0 & animist>0) \
        cast 'Armor Of Thorns'%;\
        /set spellup=thorns%;\
    /elseif (harm=0 & templar>0) \
        cast 'holy armor'%;\
        /set spellup=harm%;\
    /elseif (blur=0 & (nightblade|magician|warlock)>0 & (solo|selfprot)=1) \
        cast 'blur'%; \
        /set spellup=blur%;\
    /elseif (ms=0 & ritual=0 & amshield=1 & warlock>0 & currentmana>manatest1) \
        cast 'Mana Shield'%; \
        /set spellup=ms%;\
    /elseif (ms=0 & ritual=0 & aritual=1 & warlock>0) \
        cast 'Ritual Of Pain'%; \
        /set spellup=ritual%;\
    /elseif (bles=0 & blessme!~'0' & (priest|templar)>0) \
        /if (groupbless=1) \
            cast 'group bless'%;\
        /else \
            cast 'bless'%;\
        /endif%;\
        /set spellup=bles%;\
    /elseif (fly=0 & magician>0) \
        cast 'fly'%;\
        /set spellup=fly%;\
    /elseif (lblood=0 & nightblade>1) \
        cast 'life blood'%;\
        /set spellup=lblood%;\
    /elseif (haura=0 & autohaura=1) \
        /haura on%;\
        /set spellup=haura%;\
    /elseif (immo=0 & autoimmo=1) \
        /immo %{immotype}%;\
    /elseif (aod=0 & autoaod=1) \
        /despair on%;\
        /set spellup=aod%;\
    /elseif (protection=0 & (priest|templar)>0 & (solo|selfprot)=1) \
        cast 'protection'%;\
        /set spellup=protection%;\
    /elseif (bmirror=0 & magician>0 & abmirror=1 & ffield=0 & affield=0) \
        cast 'blood mirror'%;\
        /set spellup=bmirror%;\
    /elseif (ffield=0 & magician>0 & affield=1 & bmirror=0 & abmirror=0) \
        cast 'force field'%;\
        /set spellup=ffield%;\
    /elseif (mirrorimage=0 & amirrorimage=1 & magician > 0) \
        cast 'mirror image'%;\
        /set spellup=mirrorimage%;\
    /elseif (contingency=0 & magician>0) \
        cast 'contingency'%;\
        /set spellup=contingency%;\
    /elseif (nightblade>0 & magician=0 & gpsize>1 & sd!=1 & tank!~char & autosd=1) \
        sd %tank%;\
        /set spellup=sd%;\
    /elseif (didfoc=0 & focus=0 & nightblade>0 & autofocus>0) \
        /adr%;\
    /else \
        /set spellingup=0%;/set lostspell=0%;/set respelling=0%;/set spellup=null%;\
    /endif

/def mshield = \
    /if (amshield!=1) \
        /if (aritual) \
            /ecko Ritual of pain OFF%;\
            /set aritual=0%;\
        /endif%;\
        /ecko Mana shield will automatically be casted.%;\
        /set amshield=1%; \
    /else \
        /ecko No more mana shield casting.%;\
        /set amshield=0%;\
    /endif

/def ritual = \
    /if (!aritual) \
        /if (amshield) \
            /set amshield=0%;\
            /ecko Mana-shield OFF%;\
        /endif%;\
        /ecko Ritual of Pain ON%;\
        /set aritual=1%;\
    /else \
        /ecko Ritual of Pain OFF%;\
        /set aritual=0%;\
    /endif

/def bmirror = \
    /if (abmirror!=1) \
        /if (!affield) \
            /ecko Blood Mirror will automatically be casted.%;\
        /else \
            /ecko Blood Mirror will automatically be casted. (No more Force Field)%;\
            /set affield=0%;\
        /endif%;\
        /set abmirror=1%; \
    /else \
        /ecko No more Blood Mirror casting.%;\
        /set abmirror=0%;\
    /endif

/def mi = \
    /if (amirrorimage != 1) \
        /ecko Mirror image will automatically be casted.%;\
        /set amirrorimage=1%;\
    /else \
        /ecko Won't cast mirror image.%;\
        /set amirrorimage=0%;\
    /endif

/def ffield = \
    /if (affield!=1) \
        /ecko Force field will automatically be casted.%;\
        /set affield=1%; \
        /if (abmirror) /set abmirror=0%;/endif%;\
    /else \
        /ecko Won't cast force field. (Nice option if you want bloodmirror e.g.>;> )%;\
        /set affield=0%;\
    /endif

/def abt = \
    /if (abt!=1) \
        /ecko Blade turn will automatically be casted during fights.%;\
        /set abt=1%; \
    /else \
        /ecko No more bladeturning.%;\
        /set abt=0%;\
    /endif

/def aholy = \
    /if (priest>0 & sanctype !~ 'holyword' & autoholy!=1) \
;        /set sanctype=holyword%;\
        /set autoholy=1%;\
        /ecko Auto-casting Holyword.%;\
;    /elseif ((priest>0 | templar>0) & (autoholy!=1 | sanctype=~'holyword')) \
;        /set sanctype=sanctuary%;\
;        /set autoholy=1%;\
;        /ecko Auto-casting sanctuary self.%;\
    /elseif (priest=0 & autoholy!=1) \
        /if (askpr!~'' & askpr !~ 'self') \
            /ecko You will now ask %askpr for holyword automaticly. (/set sanctype=sanc to ask sanc) Note: This only works in /solo - mode.%;\
            /set sanctype=holy%;\
            /set autoholy=1%;\
        /else \
            /ecko You will now send the command 'sanc' to get sanctuary. Note: This only works in /solo - mode.%;\
            /set autoholy=1%;\
        /endif%;\
    /else \
        /set sanctype=%;\
        /set autoholy=0%;\
        /ecko Autoholy totally off.%;\
    /endif


/def solo = \
    /if (solo!=1) \
        /ecko NOW IN SOLO MODE!%;\
        /set solo=1%;\
        /if (autowimpy=1) \
            /wimpy%;\
        /endif%;\
    /else \
        /ecko NO MORE SOLO MODE!%;\
        /set solo=0%;\
        /if (autowimpy=0) \
            /wimpy%;\
        /endif%;\
    /endif

/send aff


;; COP-fail
/def -msimple -t'Your magical circle offers no protection here.' cant_cop = \
    /if (ingroup=1 & leading=0) \
        gtell Can't cop in this room!%;\
    /endif


;; Equipment related spells

/def -msimple -Fp1200 -t'You stop using the Warhammer of Justice.' woj_respell = \
    /respell bles
