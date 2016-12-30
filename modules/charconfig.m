; // vim: set ft=tf:

;======================================
;   Character configuration
;======================================

/def charconf_prompt = \
    /set equipment_check=0



/def -msimple -F -t'You are using:' uzi_equipment_check_enable = \
    /set equipment_check=1

/def -mregexp -Eequipment_check -F -t'^<surrounded by>      aura of ([A-z]+)$' uzi_equipment_check_aura_set0 = \
    /set aura_check=0%;\
    /set aura=%{P1}

/def -mregexp -Eequipment_check -F -t'^<surrounded by>      Nothing$' uzi_equipment_check_aura_set1 = \
    /set aura_check=0%;\
    /set aura=

/def -mregexp -F -t'An aura of ([A-z]+) surrounds you.' uzi_equipment_set2 = \
    /set aura=%{P1}%;\
    /set race=ktv

/def -mregexp -F -t'^The aura of [A-z+] around you fades away, replaced by an aura of ([A-z]+).$' uzi_equipment_invoke_aura_set3 = \
    /set aura=%{P1}%;\
    /set race=ktv


