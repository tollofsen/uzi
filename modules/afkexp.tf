; // vim: set ft=tf:

/if (autoJoinV=1) /set afkexp=1%;/unset autoJoinV%;/endif

/def afkexp = \
	/if ({1} =~ 'on') \
		/set afkexp=1%;\
		/ecko Autojoining exp!%;\
	/elseif ({1} =~ 'off') \
		/set afkexp=0%;\
		/ecko No longer autojoining exp!%;\
	/else \
		/if (afkexp) \
			/afkexp off%;\
		/else \
			/afkexp on%;\
		/endif%;\
	/endif

/alias afkexp /afkexp %{1}


/def afkwell = \
	/if ({1} =~ 'on') \
		/set afkwell=1%;\
		/ecko Autojoining well groups!%;\
	/elseif ({1} =~ 'off') \
		/set afkwell=0%;\
		/ecko No longer autojoining well groups!%;\
	/else \
		/if (afkwell) \
			/afkwell off%;\
		/else \
			/afkwell on%;\
		/endif%;\
	/endif

/alias afkwell /afkwell %{1}

/def uzi_autojoin_afkexp = \
	/if ((afkexp > 0 & (ismember({1}, blacklist) == 0)) | (afkexp == 0 & (ismember({1}, whitelist)|ismember({1}, userlist)))) \
		/if (shadowform=1) \
			return%;\
		/endif%;\
		/if (playing<1) \
			toggle play%;\
		/endif%;\
		follow %{1}%; \
	/endif

/def uzi_autojoin_afkwell = \
	/if ((afkwell > 0 & (ismember({1}, blacklist) == 0))) \
		/if (shadowform=1) \
			return%;\
		/endif%;\
		/if (playing<1) \
			toggle play%;\
		/endif%;\
		follow %{1}%;\
	/endif

/def -mregexp -Fp1000 -t'^([A-z]+) tells the ([A-z ]+), \'exp\'' uzi_afkexp_merc = \
	/if ({P2}=~merc) \
		follow %{P1}%;\
	/endif

/def -msimple -F -t'The Overseer appears in the middle of the room and bows deeply.' overseer_beep = \
	/beeper%;\
	/if (tank!~char & tank !~'-' & idle()>10) \
		/if (mailgunapikey!~'' & email!~'') \
			/eval /quote /void !curl -s --user 'api:%{mailgunapikey}' https://api.mailgun.net/v3/mud.mongoklubben.se/messages -F from='%{char}@Uzi <uzi@mongoklubben.se>' -F to=%{email} -F subject='[uzi] %{tank} summoned the Overseer!' -F text='%{tank} summoned the Overseer!'%;\
		/endif%;\
	/endif
