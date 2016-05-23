
/def -Phx -p1 -F -t'\*\*\*' bigultra = \
    /if (ultralite =~ 1) \
      /set hiliteattr=BCred%;\
      /set ultralite=0%;\
    /else \
      /set hiliteattr=n%;\
    /endif

/def -Phx -F -t'vaporizes' vaporize2 = /set hiliteattr=Ccyan
/def -Phx -F -t'annihilates' annihilate2 = /set hiliteattr=Ccyan
/def -Phx -F -t'pulverizes' pulverize2 = /set hiliteattr=Ccyan
/def -Phx -F -t'atomizes' atomize2 = /set hiliteattr=Ccyan
/def -Phx -F -t'ultraslays' ultraslay2 = /set hiliteattr=Ccyan
/def -p2 -F -t'*\*\*\*ULTRASLAYS\*\*\**' bigultra3 = /set ultralite=1
/def -p2 -F -t'*\*\*\*U\*L\*T\*R\*A\*S\*L\*A\*Y\*S\*\*\**' bigultra5 = /set ultralite=1

/def -Phx -F -t'annihilate' annihilate = /set hiliteattr=BCwhite
/def -Phx -F -t'pulverize' pulverize = /set hiliteattr=BCblue
/def -Phx -F -t'atomize' atomize = /set hiliteattr=BCcyan
/def -Phx -F -t'ultraslay' ultraslay = /set hiliteattr=BCgreen
/def -p2 -F -t'*\*\*\*ULTRASLAY\*\*\**' bigultra2 = /set ultralite=1
/def -p2 -F -t'*\*\*\*U\*L\*T\*R\*A\*S\*L\*A\*Y\*\*\**' bigultra4 = /set ultralite=1
/def -Phx -F -t'vaporize' vaporize = /set hiliteattr=BCmagenta

;/def -i -msimple -Pagreen -t'west' hi_west

