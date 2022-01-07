;;; an

/def -p5 -Phx -mregexp -t'^([A-Za-z^\']+)\'s Wolf gained a new level.$' petlevel = \
	/if (replace("'s","",{1}) =~ char) \
		/set hiliteattr=BCyellow%;\
	/else \
		/set hiliteattr=n%;\
	/endif

/def -p40000000 -F -mregexp -t'([A-Za-z^\']+)\'s (Water Elemental|Air Elemental|Earth Elemental|Wolf|Phoenix)' pethilite = \
	/if ({P1} =~ char) \
		/if ({P2} =~ 'Wolf') \
			/set hiliteattr=Cyellow%;\
		/elseif ({P2} =~ 'Air Elemental') \
			/set hiliteattr=Cwhite%;\
		/elseif ({P2} =~ 'Water Elemental') \
			/set hiliteattr=Cblue%;\
		/elseif ({P2} =~ 'Earth Elemental') \
			/set hiliteattr=Cgreen%;\
		/elseif ({P2} =~ 'Phoenix') \
			/set hiliteattr=BCred%;\
		/else \
			/set hiliteattr=n%;\
		/endif%;\
		/substitute -p %PL@{%{hiliteattr}}%P0@{n}%PR%;\
	/endif

/def -Phx -F -p4 -mregexp -t'^There is no one here to share your wealth.  \:\($' gagannoy = \
	/if (gpsize > 1) \
		/set hiliteattr=BCred%;\
	/else \
		/substitute %PR%;\
	/endif
