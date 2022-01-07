
/def -Ecountstab=1 -ag -msimple -F -t'Damlog' uzi_countstab_dl0

/def -Ecountstab=1 -ag -msimple -F -t'Name                  Miss  Hits  Weapon   Skill   Spell    Total Average Ticks' uzi_countstab_dl1 = \
	/set countstab=2

/def -Ecountstab=2 -ag -mregexp -p2147483647 -F -t'^([A-z]*)[ ]+[0-9]+[ ]+[0-9]+[ ]+[0-9]+[ ]+([0-9]*)[ ]+([0-9]+).*' uzi_countstab_dl2 = \
	/if ({P1}=~char) \
		/if ({P2}!=totalskilldam) \
			/if ({P2}<totalskilldam) \
				/set skills=1%;\
			/else \
				/test ++skills%;\
			/endif%;\
			/set skilldam=$[%{P2}-%{totalskilldam} ]%;\
			/set totalskilldam=%{P2}%;\
			/set avgskilldam=$[{totalskilldam} / {skills}]%;\
			/echo -p %{htxt2}(%{ntxt2}DAMAGE%{htxt2})%{ntxt} Last skill: %{htxt2}%{skilldam}%{ntxt} (Average: %{avgskilldam})%;\
			/if (skilldam>maxskill) \
				/set maxskill=%{skilldam}%;\
			/endif%;\
		/endif%;\
		/if ({P3}!=totalspelldam) \
			/if ({P3}<totalspelldam) \
				/set spells=1%;\
			/else \
				/test ++spells%;\
			/endif%;\
			/set spelldam=$[%{P3}-%{totalspelldam} ]%;\
			/set totalspelldam=%{P3}%;\
			/set avgspelldam=$[{totalspelldam} / {spells}]%;\
			/echo -p %{htxt2}(%{ntxt2}DAMAGE%{htxt2})%{ntxt} Last spell: %{htxt2}%{spelldam}%{ntxt} (Average: %{avgspelldam})%;\
			/if (spelldam>maxspell) \
				/set maxspell=%{spelldam}%;\
			/endif%;\
		/endif%;\
	/endif

/def -msimple -t'DAMLOG: Reset.' uzi_stablog_reset = \
	/set skilldam=0%;\
	/set totalskilldam=0%;\
	/set totalspelldam=0%;\
	/set avgskilldam=0%;\
	/set avgspelldam=0%;\
	/set stabs=0%;\
	/set skills=0%;\
	/set spells=0%;\
	/set stabmisses=0%;\
	/set maxskill=0%;\
	/set maxspell=0

/def uzi_prompt_stablog = \
	/if (countstab=2) \
		/set countstab=0%;\
	/endif

/def countstab = \
	/test ++stabs

/def do_damage_analysis = \
  /if (countstab < 1) \
	/set countstab=1%;\
	/send damlog show%;\
  /endif

/def damanalyzer = \
	/if (damage_analyzer) \
		/set damage_analyzer=0%;\
		/ecko Damage analyzer: %{htxt2}OFF!%;\
	/else \
		/set damage_analyzer=1%;\
		/ecko Damage analyzer: %{htxt2}ON!%;\
	/endif

/def stabshow = \
	/let _hitpercent=$[(stabs * 100)/(stabs + stabmisses )]%;\
	/echo -p %{htxt2}(%{ntxt2}STABLOG%{htxt2})%{ntxt} Hits: %{skills}(%{_hitpercent}\%) Average: %{avgskilldam} Max: %{maxskill}

