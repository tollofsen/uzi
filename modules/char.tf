; // vim: set ft=tf:


;;; Set score related values

/if (!level) \
    /send score%;\
/endif

/def -msimple -t'                            S    C    O    R    E' uzi_score_init = \
    /set protectee=

/def -mregexp -t'^    Level: ([0-9]+) [ ]+ Exp: (.*) [ ]+ Age: ([0-9]+)$' uzi_score_set1 = \
    /set level=%{P1}%;\
    /set exp=$[replace(',', '', {P2})]%;\
    /set age=%{P3}

/def -mregexp -t'^     Hits: [0-9]+\([0-9]+\) [ ]+ (Excess|Needed): (.*) [ ]+ Gold: (.*)$' uzi_score_set2 = \
    /if ({P1}=~'Needed') \
        /set needed=$[replace(',', '', {P2})]%;\
    /else \
        /set needed=$[replace(',', '', {P2})*-1]%;\
    /endif%;\
    /set gold=$[replace(',', '', {P3})]

/def -mregexp -t'^     Mana: [0-9]+\([0-9]+\) [ ]+ QuestP: ([0-9]+) [ ]+ Bank: (.*)$' uzi_score_set3 = \
    /set qp=%{P1}%;\
    /set bank=$[replace(',', '', {P2})]

/def -mregexp -t'^    Class: (.*) [ ]+ Alignment: ([A-z]+) [ ]+ Played:' uzi_score_set4 = \
    /set align=%{P2}

/def -mregexp -t'^Mercenary Group: ([A-z ]+)  [  ]+' uzi_set_merc = \
    /set merc=$[strip_right({P1})]

/def -mregexp -t'^     Protecting: ([A-z]+)$' uzi_score_protecting = \
    /set protectee=%{P1}

