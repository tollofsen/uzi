;// vim: set ft=tf

/def -p1000000 -mregexp -F -t'^You (annihilate|vaporize|pulverize|atomize|ultraslay|\*\*\*ULTRASLAY\*\*\*|\*\*\*U\*L\*T\*R\*A\*S\*L\*A\*Y\*\*\*)' hitcolor1 = \
    /if ({P1} =~ 'annihilate') \
        /set hitcolor=BCwhite%;\
    /elseif ({P1} =~ 'vaporize') \
        /set hitcolor=BCmagenta%;\
    /elseif ({P1} =~ 'pulverize') \
        /set hitcolor=BCblue%;\
    /elseif ({P1} =~ 'atomize') \
        /set hitcolor=BCcyan%;\
    /elseif ({P1} =~ 'ultraslay') \
        /set hitcolor=BCgreen%;\
    /endif%;\
    /if ({P1} =~ '***ULTRASLAY***') \
        /substitute -p @{Cgreen}You @{BCwhite}***ULTRASLAY***@{nCgreen}%{PR}%;\
    /elseif ({P1} =~ '***U*L*T*R*A*S*L*A*Y***') \
        /substitute -p @{Cgreen}You @{BCwhite}***U*L*T*R*A*S*L*A*Y***@{nCgreen}%{PR}%;\
    /else \
        /substitute -p @{Cgreen}You @{%{hitcolor}}%{P1}@{nCgreen}%{PR}%;\
    /endif
