" piper.vim - The magic of pipes
" Author:       Rich Russon (flatcap) <rich@flatcap.org>
" Website:      https://flatcap.org
" Copyright:    2014-2015 Richard Russon
" License:      GPLv2+
" Version:      1.0

if exists("g:loaded_piper") || &cp || v:version < 700
	finish
endif
let g:loaded_piper = 1

if !exists("g:piper_command_list")
	let g:piper_command_list = {
		\ 'c': 'LANG=C column -t',
		\ 'l': 'LANG=C nl -nrz -w4',
		\ 'n': 'LANG=C sort -n',
		\ 'r': 'LANG=C rev',
		\ 's': 'LANG=C sort -f',
		\ 't': 'LANG=C tac',
		\ 'u': 'LANG=C uniq',
		\ 'x': 'LANG=C shuf',
		\ 'z': 'LANG=C cat -s',
	\ }
endif

let g:piper_command = ''

function! s:go(...)
	if (a:0 == 2)
		let [start, stop] = [a:1, a:2]
	else
		let [start, stop] = [line("'["), line("']")]
	endif

	execute start.','.stop.'!'.g:piper_command_list[g:piper_command]
endfunction

for i in keys(g:piper_command_list)
	let u = toupper(i)

	execute 'xnoremap <silent> <Plug>PiperV_'.i.' :<C-U>let g:piper_command="'.i.'"<bar>call <SID>go(line("''<"),line("''>"))<CR>'
	execute 'nnoremap <silent> <Plug>PiperM_'.i.' :<C-U>let g:piper_command="'.i.'"<bar>set opfunc=<SID>go<CR>g@'
	execute 'nnoremap <silent> <Plug>PiperA_'.i.' :let g:piper_command="'.i.'"<bar>call <SID>go(1,line(''$''))<CR>'
	execute 'nnoremap <silent> <Plug>PiperL_'.i.' :let g:piper_command="'.i.'"<bar>call <SID>go(line(''.''),line(''.''))<CR>'

	" Four mappings for each command
	"       PiperV visual
	"       PiperM motion
	"       PiperA all the file
	"       PiperL line (single)

	execute 'xmap cp'.i.'   <plug>PiperV_'.i
	execute 'nmap cp'.i.'   <plug>PiperM_'.i
	execute 'nmap cp'.i.i.' <plug>PiperL_'.i
	execute 'nmap cp'.u.'   <plug>PiperA_'.i
endfor

" vim:set noet ts=8 sw=8:
