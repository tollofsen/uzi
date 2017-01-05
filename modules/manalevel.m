;// vim: set ft=tf:

/uzi_checkmana = \
    /if ((animist|magician|nightblade|warlock|priest)=0) \
        /set manalevel=high%;\
    /else \
        /let _manapercent=$[ currentmana / maxmana ]%;\
        /if (currentmana<100 | _mana_percent < 5) \
            /set manalevel=low%;\
        /elseif ((magician>0 & autocop=1)|((priest>0|animist>0) & autoheal=1)) \
            /if (_manapercent<60) \
                /set manalevel=low%;\
            /elseif (_manapercent<80) \
                /set manalevel=mid%;\
            /else \
                /set manalevel=hi%;\
            /endif%;\
        /else \
            /if (_manapercent>20) \
                /set manalevel=mid%;\
            /else \
                /set manalevel=hi%;\
            /endif
        /endif
    /endif
