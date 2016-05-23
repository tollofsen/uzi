; -*- mode: tf -*-
;;;;;;;;;;;;;;;;;;;Key bindings for vt100
;/set TERM=vt100

;;;;Walkings for vt100
/bind ^[OM = /if (enterkill=1) x%;/else /dokey newline%;/endif
/bind ^[OQ = aff
/bind ^[OR = group
/bind ^[OS = eq all
/bind ^[Ow = flee
/bind ^[Ox = n%;/set walkeddir=North
/bind ^[Oy = u%;/set walkeddir=Up
/bind ^[Ol = inv
/bind ^[Ot = w%;/set walkeddir=West
/bind ^[Ou = look
/bind ^[Ov = e%;/set walkeddir=East
/bind ^[Oq = exits
/bind ^[Or = s%;/set walkeddir=South
/unbind ^[Os
/bind ^[Os = d%;/set walkeddir=Down
/bind ^[Op = score
/bind ^[On = stats

;;;;Repeat Last command binds
/bind § = /dokey recallb%;/dokey NEWLINE
/bind ^[' = /dokey recallb%;/dokey NEWLINE

