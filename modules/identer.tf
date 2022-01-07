;// vim: set ft=tf:

/def uzi_ident_prompt = \
	/purge uzi_ident_spell_temp%;\
	/if (uzi_ident=1) \
		/set uzi_ident=0%;\
		/if (uzi_ident_damdice!~'') \
			/let _damroll=$[{uzi_ident_damroll}+uzi_ident_forged]%;\
			/avgdam_ident %{uzi_ident_damdice} %{_damroll}%;\
		/endif%;\
		/if (uzi_ident_affects!~'') \
			/let _length=$[strlen(uzi_ident_affects)-1]%;\
			/set uzi_ident_affects=$[substr(uzi_ident_affects, 0, _length)]%;\
			/set uzi_ident_json=%{uzi_ident_json}, "affects": [%{uzi_ident_affects}]%;\
			/unset uzi_ident_affects%;\
		/endif%;\
		/if (uzi_ident_slays!~'') \
			/let _length=$[strlen(uzi_ident_slays)-1]%;\
			/set uzi_ident_slays=$[substr(uzi_ident_slays, 0, _length)]%;\
			/set uzi_ident_json=%{uzi_ident_json}, "slays": [%{uzi_ident_slays}]%;\
			/unset uzi_ident_slays%;\
		/endif%;\
		/if (uzi_ident_spells!~'') \
			/let _length=$[strlen(uzi_ident_spells)-1]%;\
			/set uzi_ident_spells=$[substr(uzi_ident_spells, 0, _length)]%;\
			/set uzi_ident_json=%{uzi_ident_json}, "spells": [%{uzi_ident_spells}]%;\
			/unset uzi_ident_spells%;\
		/endif%;\
		/set uzi_ident_json=\{"source": "%{char}", "data": \{%{uzi_ident_json}\}\}%;\
;        /ecko %uzi_ident_json%;\
;        /eval /quote /uzi_ident_push_response !curl -d '%uzi_ident_json' -H "Content-Type: application/json" http://localhost:3000/api/item/add%;\
    /if (uzi_ident_idscroll!='') \
      /echo a scroll of identify dissolves.%;\
      /unset uzi_ident_idscroll%;\
    /endif%;\
	/endif


/def uzi_ident_push_response = \
	/ecko %{*}

/def -p99999999 -F -msimple -t'You feel informed:' uzi_ident_init = \
	/quote -S /unset `/listvar -s uzi_ident*%;\
	/set uzi_ident=1%;\
	/set uzi_ident_json=

/def -q -p9999999 -E(uzi_ident>0) -F -mregexp -t"^Object \'(.*)\'\, Item type\: ([^\']*)\, Worn\: ([^\']*)$" uzi_ident_object = \
	/let _slots=%{P3}%;\
	/let _slot=$(/first %{_slots})%;\
	/let _slots=$(/remove %{_slot} %{_slots})%;\
	/let _string="%{_slot}"%;\
	/while (_slots!~'') \
		/let _slot=$(/first %{_slots})%;\
		/let _slots=$(/remove %{_slot} %{_slots})%;\
		/let _string=%{_string}, "%{_slot}"%;\
	/done%;\
	/set uzi_ident_json=%{uzi_ident_json} "keywords": "%{P1}", "type": "%{P2}", "worn": [%{_string}]

/def -q -p9999999 -E(uzi_ident>0) -F -mregexp -t"^Short Description\: (.*)" uzi_ident_name = \
	/let short_desc=$[replace('"', '\\\"', {P1})]%;\
	/set uzi_ident_json=%{uzi_ident_json}, "name": "%{short_desc}"

/def -q -p9999999 -E(uzi_ident>0) -F -mregexp -t'^([ ]+)(Magician|Priest|Rogue|Fighter|Warlock|Animist|Nightblade|Templar)\: ([0-9]+)' uzi_ident_class = \
	/let _string="$[tolower({P2})]": %{P3}%;\
	/set uzi_ident_json=%{uzi_ident_json}, %{_string}

/def -q -p9999999 -E(uzi_ident>0) -F -mregexp -t'^Item is\: ([^\']*)$' uzi_ident_3 =\
	/if (ismember('FORGED', {P1})>0) \
		/set uzi_ident_forged=1%;\
	/endif%;\
	/let _bits=%{P1}%;\
	/let _bit=$(/first %{_bits})%;\
	/let _bits=$(/remove %{_bit} %{_bits})%;\
	/let _string="%{_bit}"%;\
	/while (_bits!~'') \
		/let _bit=$(/first %{_bits})%;\
		/let _bits=$(/remove %{_bit} %{_bits})%;\
		/let _string=%{_string}, "%{_bit}"%;\
	/done%;\
	/set uzi_ident_json=%{uzi_ident_json}, "bits": [%{_string}]

/def -q -p9999999 -E(uzi_ident>0) -F -mregexp -t'^Weight\: ([0-9\. ]+) lbs\, Value\: ([^ ]*)' uzi_ident_weight = \
	/set uzi_ident_json=%{uzi_ident_json}, "weight": %{P1}, "value": %{P2}

/def -q -p9999999 -E(uzi_ident>0) -F -mregexp -t'^Damage dice is \'([0-9]+)D([0-9]+)\'$' uzi_ident_damdice = \
	/purge uzi_ident_spell_temp%;\
	/set uzi_ident_damdice=%{P1}d%{P2}%;\
	/set uzi_ident_json=%{uzi_ident_json}, "damage_dice": {"number": %{P1}, "sides": %{P2}}

/def -q -p9999999 -E(uzi_ident>0) -F -mregexp -t'^Damage type is ([A-z]+)  \(([^\']*)\)$' uzi_ident_weapon = \
	/purge uzi_ident_spell_temp%;\
	/let _damtypes=%{P2}%;\
	/let _damtype=$(/first %{_damtypes})%;\
	/let _damtypes=$(/remove %{_damtype} %{_damtypes})%;\
	/let _string="%{_damtype}"%;\
	/while (_damtypes!~'') \
		/let _damtype=$(/first %{_damtypes})%;\
		/let _damtypes=$(/remove %{_damtype} %{_damtypes})%;\
		/let _string=%{_string}, "%{_damtype}"%;\
	/done%;\
	/set uzi_ident_json=%{uzi_ident_json}, "weapon_type": "%{P1}", "weapon_damage": [%{_string}]


/def -q -p9999999 -E(uzi_ident>0) -F -mregexp -t'^AC-apply is ([0-9]+)' uzi_ident_6 = \
	/purge uzi_ident_spell_temp%;\
	/set uzi_ident_json=%{uzi_ident_json}, "ac": %{P1}

/def -q -p9999998 -E(uzi_ident>0) -mregexp -t'^    Affects : ([^\']*) By (-?[0-9]+)$' uzi_ident_7 = \
	/purge uzi_ident_spell_temp%;\
	/if ({P1}=/'Damroll') \
		/set uzi_ident_damroll=%{P2}%;\
	/endif%;\
	/set uzi_ident_affects=%{uzi_ident_affects}\{"affect": "%{P1}", "value": %{P2}},

/def -q -p9999999 -E(uzi_ident>0) -mregexp -t'^    Affects : SLAY vs ([A-z]+)$' uzi_ident_8 = \
	/purge uzi_ident_spell_temp%;\
	/set uzi_ident_slays=%{uzi_ident_slays}"%{P1}",

/def -q -p9999999 -E(uzi_ident>0) -mregexp -t'^Has ([0-9]+) charges, with [0-9]+ charges left.$' uzi_ident_10 = \
	/set uzi_ident_spells_charges=%{P1}

/def -q -p9999999 -E(uzi_ident>0) -mregexp -t'^Level ([0-9]+) (spells|spell) of:' uzi_ident_9 = \
	/set uzi_ident_spells_level=%{P1}%;\
	/def -p999000 -F -mregexp -t'^(.*)$$' uzi_ident_spell_temp = \\
		/let _temp=%{*}%%;\
		/if (regmatch('^@{Ccyan*', encode_attr({_temp})) | regmatch('^@{Cgreen*', encode_attr({_temp}))) \
			/set uzi_ident_spells=%{uzi_ident_spells} \{"spell": "%%{*}", "level": "%%{uzi_ident_spells_level}", "charges": "%%{uzi_ident_spells_charges}"\},%%;\
		/else \
			/purge uzi_ident_spell_temp%%;\
		/endif

/def -q -p9999999 -E(uzi_ident>0) -msimple -t'Can affect you as :' uzi_affacts_start = \
	/purge uzi_ident_spell_temp


/def avgdam_ident = \
	/if ($(/length %{uzi_ident_slays})>0) \
		/let _slay=1%;\
	/endif%;\
	/avgdam_func %{*}%;\
	/if (_slay=1) \
		/echo -a -p @{Cgreen}Calculated damage (SLAY):%;\
	/else \
		/echo -a -p @{Cgreen}Calculated damage :%;\
	/endif%;\
	/if (_slay=1) \
		/echo -a -p @{Cgreen}    Average : @{Cyellow}%{avdam} (%{avdam_slay})%;\
	/else \
		/echo -a -p @{Cgreen}    Average : @{Cyellow}%{avdam}%;\
	/endif%;\
	/if (_slay=1) \
		/echo -a -p @{Cgreen}    Maximum : @{Cyellow}%{maxdam} (%{maxdam_slay})%;\
	/else \
		/echo -a -p @{Cgreen}    Maximum : @{Cyellow}%{maxdam}%;\
	/endif%;\
	/if (_slay=1) \
		/echo -a -p @{Cgreen}    Minimum : @{Cyellow}%{mindam} (%{mindam_slay})%;\
	/else \
		/echo -a -p @{Cgreen}    Minimum : @{Cyellow}%{mindam}%;\
	/endif


/def -msimple -ag -t'a scroll of identify dissolves.' uzi_ident_idscroll = \
  /set uzi_ident_idscroll=1
