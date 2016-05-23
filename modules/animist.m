;;; an

;/def -Phx -mregexp -t'^([^\']+)\'s [A-Za-z]* gained a new level.$' petlevel = \
;/def -p999 -F -Phx -mregexp -t'gained a new level.' petlevel = \

/def -p5 -Phx -mregexp -t'^([A-Za-z^\']+)\'s Wolf gained a new level.$' petlevel = \
    /if ($[replace("'s","",{1})] =~ char) \
      /set hiliteattr=BCyellow%;\
    /else \
      /set hiliteattr=n%;\
    /endif

/def -p4 -F -Phx -mregexp -t'([A-Za-z^\']+)\'s (Water Elemental|Air Elemental|Earth Elemental|Wolf)' pethilite = \
    /if ({P1} =~ char) \
      /if ({P2} =~ 'Wolf') \
        /set hiliteattr=Cyellow%;\
      /elseif ({P2} =~ 'Air Elemental') \
        /set hiliteattr=Ccyan%;\
      /elseif ({P2} =~ 'Water Elemental') \
        /set hiliteattr=Cblue%;\
      /elseif ({P2} =~ 'Earth Elemental') \
        /set hiliteattr=Cgreen%;\
      /endif%;\
    /else \
      /set hiliteattr=n%;\
    /endif

/def -Phx -F -p4 -mregexp -t'^There is no one here to share your wealth.  \:\($' gagannoy = \
    /if (gpsize > 1) \
      /set hiliteattr=BCred%;\
    /else \
      /substitute %PR%;\
    /endif
