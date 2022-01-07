; // vim: set ft=tf:
;;;;;;;;;;;;;;;;;;;Key bindings for vt100
;/set TERM=vt100

;;;;Walkings for vt100
;/bind ^[OM = /if (enterkill=1) x%;/else /dokey newline%;/endif
/def key_nkpEnt = /if (enterkill=1) x%;/else /dokey newline%;/endif
;/bind ^[OQ = aff
/def key_f2 = group priest
;/bind ^[OR = group
/def key_f3 = group
;/bind ^[OS = eq all
/def key_f4 = eq all
;/bind ^[Ow = flee
/def key_nkp7 = flee
;/bind ^[Ox = n%;/set walkeddir=North
/def key_nkp8 = n%;/set walkeddir=North
;/bind ^[Oy = u%;/set walkeddir=Up
/def key_nkp9 = u%;/set walkeddir=Up
;/bind ^[Ol = inv
/def key_nkp, = aff
;/bind ^[Ot = w%;/set walkeddir=West
/def key_nkp4 = w%;/set walkeddir=West
;/bind ^[Ou = look
/def key_nkp5 = look
;/bind ^[Ov = e%;/set walkeddir=East
/def key_nkp6 = e%;/set walkeddir=East
;/bind ^[Oq = exits
/def key_nkp1 = exits
;/bind ^[Or = s%;/set walkeddir=South
/def key_nkp2 = s%;/set walkeddir=South
;/unbind ^[Os
;/bind ^[Os = d%;/set walkeddir=Down
/def key_nkp3 = d%;/set walkeddir=Down
;/bind ^[Op = score
;/bind ^[On = stats
/def key_nkp0 = score
/def key_nkp. = stats

;;;;Repeat Last command binds
/bind � = /dokey recallb%;/dokey NEWLINE
/bind ^[' = /dokey recallb%;/dokey NEWLINE
/bind \96 = /dokey recallb%;/dokey NEWLINE
