" filter.vim - The magic of pipes
" Maintainer:   Rich Russon (flatcap) <rich@flatcap.org>
" Version:      0.1

if exists("g:loaded_filter") || &cp || v:version < 700
	finish
endif
let g:loaded_filter = 1

if !exists("g:filter_command_list")
	let g:filter_command_list = {
		\ 's': 'LANG=C sort -f',
		\ 'c': 'LANG=C column -t',
		\ 'n': 'LANG=C nl -nrz -w4',
		\ 'r': 'LANG=C rev',
		\ 't': 'LANG=C tac',
		\ 'u': 'LANG=C uniq',
		\ 'x': 'LANG=C sort -R',
	\ }
endif

let g:filter_command = ''

function! s:go(...)
	if (a:0 == 2)
		let [start, stop] = [a:1, a:2]
	else
		let [start, stop] = [line("'["), line("']")]
	endif

	execute start.','.stop.'!'.g:filter_command_list[g:filter_command]
endfunction

for i in keys(g:filter_command_list)
	let u = toupper(i)

	execute 'xnoremap <silent> <Plug>FilterV_'.i.' :<C-U>let g:filter_command="'.i.'"<bar>call <SID>go(line("''<"),line("''>"))<CR>'
	execute 'nnoremap <silent> <Plug>FilterM_'.i.' :<C-U>let g:filter_command="'.i.'"<bar>set opfunc=<SID>go<CR>g@'
	execute 'nnoremap <silent> <Plug>FilterA_'.i.' :let g:filter_command="'.i.'"<bar>call <SID>go(1,line(''$''))<CR>'
	execute 'nnoremap <silent> <Plug>FilterL_'.i.' :let g:filter_command="'.i.'"<bar>call <SID>go(line(''.''),line(''.''))<CR>'

	" Four mappings for each command
	"       FilterV visual
	"       FilterM motion
	"       FilterA all the file
	"       FilterL line (single)

	execute 'xmap cp'.i.'   <plug>FilterV_'.i
	execute 'nmap cp'.i.'   <plug>FilterM_'.i
	execute 'nmap cp'.i.i.' <plug>FilterL_'.i
	execute 'nmap cp'.u.'   <plug>FilterA_'.i
endfor

" vim:set noet ts=8 sw=8:
