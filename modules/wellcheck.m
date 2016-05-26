;// vim: set ft=tf

;  ===========  WELL LEVEL  start  ===========

; This is how the where-checks are done:
;  known  do-where   found-on
;  1-20: elemental   ( 9-20)  * (earth)

;  1-8 : darkenbeast ( 4-8 )  *
;  9-20: horgar      (14-20)  *

;  1-3 : wolverine   ( 2-3 )  *
;  4-8 : medusa      ( 6-8 )  * (normal & greater)
;  9-13: beholder    (11-13)  * (normal, gauth)
; 14-20: balrog      (18-20)  *

;  2-3 : ?
;  4-5 : toad        (    5)  * (fire)
;  6-8 : hound       (    8)  *
;  9-10: toad        (    9)
; 11-13: hound       (12-13)  *
; 14-17: terrorite   (16-17)  *
; 18-20: manticore   (   18)  *

;  6-7 : ooze        (    6)  * (crystal)
; 12-13: ice         (   12)  * (elemental)
; 14-15: ?
; 16-17: thonis      (   17)
; 19-20: god         (   20)

/set checkForWellMob none
/alias checklevel \
    /if ({*} =~ '') \
      /set checklevelshow= %; \
    /else \
      /set checklevelshow %*%; \
    /endif%; \
    /set checkForWellMob elemental%; \
    whe elemental%; \
    /def -F -ah -msimple -t"No-one around by that name." wellevelcheckNone = \
      /if (checkForWellMob =~ 'elemental') \
        /set checkForWellMob darkenbeast%%; \
        whe darkenbeast%%; \
      /elseif (checkForWellMob =~ 'darkenbeast') \
        /set checkForWellMob wolverine%%; \
        whe wolverine%%; \
      /elseif (checkForWellMob =~ 'wolverine') \
        /set wellevel=1%%; \
        wellevelcheckreport Lvl 1 (No elemental, no darkenbeast, no wolverine)%%; \
      /elseif (checkForWellMob =~ 'medusa') \
        /set checkForWellMob toad%%; \
        whe toad%%; \
      /elseif (checkForWellMob =~ 'toad') \
        /set wellevel=4%%; \
        wellevelcheckreport Lvl 4 (No elemental, no toad but darkenbeast and medusa)%%; \
      /elseif (checkForWellMob =~ 'hound') \
        /set checkForWellMob ooze%%; \
        whe ooze%%; \
      /elseif (checkForWellMob =~ 'ooze') \
        /set wellevel=7%%; \
        wellevelcheckreport Lvl 7 (No elemental, no hell hound, no ooze but darkenbeast and medusa)%%; \
      /elseif (checkForWellMob =~ 'horgar') \
        /set checkForWellMob beholder%%; \
        whe beholder%%; \
      /elseif (checkForWellMob =~ 'beholder') \
        /set checkForWellMob toad2%%; \
        whe toad%%; \
      /elseif (checkForWellMob =~ 'toad2') \
        /set wellevel=10%%; \
        wellevelcheckreport Lvl 10 (No horgar, no beholder, no toad but elemental)%%; \
      /elseif (checkForWellMob =~ 'hound2') \
        /set wellevel=13%%; \
        wellevelcheckreport Lvl 13 (No horgar, no hell hound but elemental & beholder)%%; \
      /elseif (checkForWellMob =~ 'balrog') \
        /set checkForWellMob terrorite%%; \
        whe terrorite%%; \
      /elseif (checkForWellMob =~ 'terrorite') \
        /if ({wellevel} <= '14') \
          /set wellevel=14%%; \
        /elseif ({wellevel} >= '15') \
          /set wellevel=15%%; \
        /endif%%; \
        wellevelcheckreport Lvl 14-15 (No balrog, no terrorite but horgar and elemental)%%; \
      /elseif (checkForWellMob =~ 'thonis') \
        /set wellevel=16%%; \
        wellevelcheckreport Lvl 16 (No balrog, no thonis but horgar and terrorite)%%; \
      /elseif (checkForWellMob =~ 'manticore') \
        /set checkForWellMob god%%; \
        whe god%%; \
      /elseif (checkForWellMob =~ 'god') \
        /set wellevel=19%%; \
        wellevelcheckreport Lvl 19 (No manticore, no Elvis but elemental, horgar & balrog)%%; \
      /elseif (checkForWellMob =~ 'ice') \
        /set wellevel=11%%; \
        wellevelcheckreport Lvl 11 (No horgar, no ice elemental but elemental, beholder and Hell Hound)%%; \
      /endif%; \
    /def -F -ah -t"The giant wolverine       - *" wellevelcheckWolverine = \
      /if ({wellevel} <= '2') \
        /set wellevel=2%%; \
      /endif%%; \
      /if ({wellevel} >= '3') \
        /set wellevel=3%%; \
      /endif%%; \
      wellevelcheckreport Lvl 2-3 (No elemental, no darkenbeast but wolverine)%; \
    /def -F -ah -t"The darkenbeast           - *" wellevelcheckDarkenbeast = \
      /set checkForWellMob medusa%%; \
      whe medusa%; \
    /def -F -ah -t"The *medusa      * - *" wellevelcheckMedusa = \
      /set checkForWellMob hound%%; \
      whe hound%; \
    /def -F -ah -t"The hell hound            - *" wellevelcheckHound = \
      /if (checkForWellMob =~ 'hound') \
        /set wellevel=8%%; \
        wellevelcheckreport Lvl 8 (No elemental but hell hound, medusa & darkenbeast)%%; \
      /else \
        /set checkForWellMob ice%%; \
        whe ice%%; \
      /endif%; \
    /def -F -ah -t"The * ooze    * - *" wellevelcheckOoze = \
      /set wellevel=6%%; \
      wellevelcheckreport Lvl 6 (No elemental, no hound but darkenbeast, medusa and ooze)%; \
    /def -F -ah -t"The * elemental   * - *" wellevelcheckElemental = \
      /set checkForWellMob horgar%%; \
      whe horgar%; \
    /def -F -ah -t"The * toad     * - *" wellevelcheckToad = \
      /if (checkForWellMob =~ 'toad') \
        /set wellevel=5%%; \
        wellevelcheckreport Lvl 5 (No elemental, no medusa but darkenbeast and toad)%%; \
      /else \
        /set wellevel=9%%; \
        wellevelcheckreport Lvl 9 (No beholder, no horgar but elemental & toad)%%; \
      /endif%; \
    /def -F -ah -mregexp -t"(t|T)(he gauth                 -|he beholder              -) *" wellevelcheckBeholder = \
      /set checkForWellMob hound2%%; \
      whe hound%; \
    /def -F -ah -t"The Horgar          * - *" wellevelcheckHorgar = \
      /set checkForWellMob balrog%%; \
      whe balrog%; \
    /def -F -ah -t"The Ice elemental   * - *" wellevelcheckIce = \
      /if (checkForWellMob =~ 'ice') \
        /set wellevel=12%%; \
        wellevelcheckreport Lvl 12 (No horgar, but elemental, ice elemental, beholder and Hell Hound)%%; \
      /endif%; \
    /def -F -ah -t"the Terrorite Demon       - *" wellevelcheckTerrorite = \
      /set checkForWellMob thonis%%; \
      whe thonis%; \
    /def -F -ah -t"The Thonis            * - *" wellevelcheckThonis = \
      /set wellevel=17%%; \
      wellevelcheckreport Lvl 17 (No balrog but elemental, horgar, terrorite and thonis)%; \
    /def -F -ah -t"The Balrog            * - *" wellevelcheckBalrog = \
      /set checkForWellMob manticore%%; \
      whe manticore%; \
    /def -F -ah -t"The Manticore         * - *" wellevelcheckManticore = \
      /set wellevel=18%%; \
      wellevelcheckreport Lvl 18 (Elemental, horgar, balrog and manticore)%; \
    /def -F -ah -t"Morgoth the Valar God     - *" wellevelcheckGod = \
      /set wellevel=20%%; \
      wellevelcheckreport Lvl 20 (No manticore but elemental, horgar, balrog and Elvis)

/alias wellevelcheckreport /wls %{*}
/def wls = \
	/if ({checklevelshow}=~'') \
	  /ecko %*%; \
	  /set checkForWellMob none%; \
	  /purge wellevelcheck*%; \
	 /else%;\
	 %{checklevelshow} %*%; \
	 /set checkForWellMob none%; \
	 /purge wellevelcheck*%;\
	/endif

;  ===========  WELL LEVEL   end   ===========
