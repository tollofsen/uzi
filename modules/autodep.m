; // vim: set ft=tf

/def -mregexp -Fp100 -t'^A Large device from the Lords of Orhan has been put here.$' uzi_autodep0 = \
    /if (gold>autodep_amount & autodep_amount>100000) \
        deposit $[gold-autodep_amount]%;\
        /set gold=autodep_amount%;\
    /elseif (gold<100000) \
        withdraw 100000%;\
        /set gold=$[gold+100000]%;\
    /endif

