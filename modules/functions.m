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

;;;;
