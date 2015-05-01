" piper.vim - The magic of pipes
" Author:       Rich Russon (flatcap) <rich@flatcap.org>
" Website:      https://flatcap.org
" Copyright:    2014-2015 Richard Russon
" License:      GPLv3 <http://fsf.org/>
" Version:      1.0

if (exists ('g:loaded_piper') || &cp || (v:version < 700))
	finish
endif
let g:loaded_piper = 1

if (!exists ('g:piper_command_list'))
	let g:piper_command_list = {
		\ 'c': 'LANG=C column -t',
		\ 'e': 'LANG=C uniq -c',
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

function! g:PiperShowMappings()
	let l:old_more = &l:more
	let &l:more = 1

	echohl MoreMsg
	echo 'Vim Piper mappings:'
	echohl none

	for l:i in sort (keys (g:piper_command_list))
		echom printf ("    %s : %s", l:i, g:piper_command_list[l:i])
	endfor

	let &l:more = l:old_more
endfunction

function! s:go (...)
	if (a:0 == 2)
		let [l:start, l:stop] = [a:1, a:2]
	else
		let [l:start, l:stop] = [line ('''['), line (''']')]
	endif

	execute l:start . ',' . l:stop . '!' . g:piper_command_list[g:piper_command]
endfunction

function s:set_up_mappings()
	for l:i in keys (g:piper_command_list)
		let l:u = toupper (l:i)

		execute 'nnoremap <silent> <Plug>PiperA_' . l:i . ' :let g:piper_command="'     . l:i . '"<bar>call <SID>go (1, line (''$''))<CR>'
		execute 'nnoremap <silent> <Plug>PiperL_' . l:i . ' :let g:piper_command="'     . l:i . '"<bar>call <SID>go (line (''.''), line (''.''))<CR>'
		execute 'nnoremap <silent> <Plug>PiperM_' . l:i . ' :<C-U>let g:piper_command="'. l:i . '"<bar>set opfunc=<SID>go<CR>g@'
		execute 'xnoremap <silent> <Plug>PiperV_' . l:i . ' :<C-U>let g:piper_command="'. l:i . '"<bar>call <SID>go (line ("''<"), line ("''>"))<CR>'

		" Four mappings for each command
		"       PiperA all the file
		"       PiperL line (single)
		"       PiperM motion
		"       PiperV visual
		if (get (g:, 'piper_create_mappings', 1))
			execute 'nmap cp' . l:u       . ' <Plug>PiperA_' . l:i
			execute 'nmap cp' . l:i . l:i . ' <Plug>PiperL_' . l:i
			execute 'nmap cp' . l:i       . ' <Plug>PiperM_' . l:i
			execute 'xmap cp' . l:i       . ' <Plug>PiperV_' . l:i
		endif
	endfor

	nnoremap <Plug>PiperShowMappings :call g:PiperShowMappings()<CR>
endfunction


call s:set_up_mappings()

" vim:set noet ts=8 sw=8:
