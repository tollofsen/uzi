; // vim: set ft=tf:

/def m_isinlist = /if ({askperson}=/{1}) /set inlist=1%; /endif

/def ismember = \
	/set askperson=%{1}%;\
	/set inlist=0%;\
	/mapcar /m_isinlist %{-1}%;\
	/return inlist

/def m_askspell = \
	/if (botall=1) \
		/set inlist=1%;\
	/elseif (botgroup=1) \
		/mapcar /m_isinlist %{gplist}%; \
	/elseif \
		/mapcar /m_isinlist %{userlist}%;\
	/endif

/def addxspaces = \
	/let _addxspaces=%{*}%;\
	/let _showspell_len=$[20-$[strlen({1})]]%;\
	/let _showspell_break=.%;\
	/while (_showspell_len > 0) \
		/let _showspell_len=$[{_showspell_len}-1]%;\
		/let _showspell_break=.%{_showspell_break}%;\
	/done%;\


	/def rmfirstword = \
		/let _word=%%{%{1}}%;\
		/ecko Variable: %{1}    Original words: %%{%{1}}%;\
		/eval /rmfirstword2 %{1} %%{%{1}}%;\
		/ecko Variable: %{1}    New words: %%{%{1}}

/def rmfirstword2 = \
	/let _tmpvar=%1%;\
	/let _word=%*%;\
	/let _result=%;\
	/let _stopin=0%;\
	/if ({1}!~'') \
		/while (shift(), {#}) \
			/if (_stopin=1) \
				/let _result=%{_result} %{1}%;\
			/else \
				/let _stopin=1%;\
			/endif%;\
		/done%;\
	/endif%;\
	/eval /set %{_tmpvar}=%{_result}%;\

	/def file_exists = \
		/set file_exists=0%;\
		/eval /quote -S /set file_exists=!if [ -r %{*} ]; then echo 1;else echo 0;fi

/def uzisavevar = \
	/if (uzisavefile !~ '' & {1} !~ '') \
		/eval /test fwrite(uzisavefile, "/set %1=%%{%{1}}")%;\
	/endif

/def uzisavetxt = \
	/if (uzisavefile !~ '') \
		/eval /test fwrite(uzisavefile, {*})%;\
	/endif

; Execute a command everywhere we're connected
; Posted on the TF list by David Moore <dmoore@UCSD.EDU>
/def command_in_all =\
	/let body=%{*}%;\
	/command_in_all_ $(/listsockets -s)

/def command_in_all_ =\
	/while ({#}) \
		/repeat -S -w%{1} 1 %{body}%;\
		/shift%;\
	/done

/def strip_right = /result "$(/echo %*)"

;;;;

/alias avgdam /avgdam %{*}
/def avgdam = \
	/if (regmatch('([0-9]+)d([0-9]+)', {1})) \
		/let _d1=%{P1}%;\
        /let _d2=%{P2}%;\
		/avgdam_func %{*}%;\
		/echo -a -p @{BCred}*** @{Cyellow}Avdam @{Cred}***%;\
		/echo -a -p @{BCblack} Dice:   @{Ccyan}%{_d1}@{Cwhite}D@{Ccyan}%{_d2}%;\
		/echo -a -p @{BCblack} Avdam:  @{Ccyan}%{avdam}%;\
		/echo -a -p @{BCblack} Maxdam: @{Ccyan}%{maxdam}%;\
		/echo -a -p @{BCblack} Mindam: @{Ccyan}%{mindam}%;\
		/echo -a -p @{BCred}*************%;\
	/else \
		/ecko Usage: /avgdam <X>d<Y> <DR>. Note: Add 1 to the result for forged weapons.%;\
	/endif%;\

/def avgdam_func = \
	/if (regmatch('([0-9]+)d([0-9]+)', {1})) \
		/let _d1=%{P1}%;\
		/let _d2=%{P2}%;\
		/if ({2}!~'') \
			/let _dr=%{2}%;\
		/else \
			/let _dr=0%;\
		/endif%;\
		/test avdam:=(%{_d1}.0 * (%{_d2}.0+1)/2)+%{_dr}.0%;\
		/test maxdam:=(%{_d1}.0 * (%{_d2}.0))+%{_dr}.0%;\
		/test mindam:=(%{_d1}.0 * (1)) + %{_dr}.0%;\
		/test avdam_slay:=((%{_d1}.0*2) * (%{_d2}.0+1)/2)+%{_dr}.0%;\
		/test maxdam_slay:=((%{_d1}.0*2) * (%{_d2}.0))+%{_dr}.0%;\
		/test mindam_slay:=((%{_d1}.0*2) * (1)) + %{_dr}.0%;\
		/if (regmatch('^[0-9]+\.$', avdam)) \
			/set avdam=%{avdam}0%;\
		/endif%;\
		/if (regmatch('^[0-9]+\.$', maxdam)) \
			/set maxdam=%{maxdam}0%;\
		/endif%;\
		/if (regmatch('^[0-9]+\.$', mindam)) \
			/set mindam=%{mindam}0%;\
		/endif%;\
		/if (regmatch('^[0-9]+\.$', avdam_slay)) \
			/set avdam_slay=%{avdam_slay}0%;\
		/endif%;\
		/if (regmatch('^[0-9]+\.$', maxdam_slay)) \
			/set maxdam_slay=%{maxdam_slay}0%;\
		/endif%;\
				/if (regmatch('^[0-9]+\.$', mindam_slay)) \
			/set mindam_slay=%{mindam_slay}0%;\
		/endif%;\
	/else \
		/unset avdam%;\
		/unset maxdam%;\
		/unset mindam%;\
	/endif

/def void

/def -ip%{maxpri} -mregexp -h'send ^:([^ ]*)$$$' test_func = /ecko %{P1}
