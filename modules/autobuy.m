/def -mregexp -Fp12333131 -t"^(Sheila|The secretary) says 'Sorry ([A-z]+), you don't have the ([0-9]+) gold coins that we would have to" autbuy_0 = \
    /if ({P2}=~char) \
        wit %{P3}%;\
        buy corpse%;\
    /endif
