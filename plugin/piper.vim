" piper.vim - The magic of pipes
" Author:       Rich Russon (flatcap) <rich@flatcap.org>
" Website:      https://flatcap.org
" Copyright:    2014-2026 Richard Russon
" License:      GPLv3 <http://fsf.org/>
" Version:      1.0

if (exists('g:loaded_piper') || &cp || (v:version < 700))
	finish
endif
let g:loaded_piper = 1

" Set default value
let g:piper_command_list = get(g:, 'piper_command_list', {
		\ 'a': 'LANG=C ansifilter',
		\ 'c': 'LANG=C column --table --output-separator " "',
		\ 'd': 'LANG=C uniq --repeated',
		\ 'e': 'LANG=C uniq --count',
		\ 'f': 'LANG=C clang-format -assume-filename=%',
		\ 'k': 'LANG=C sort --field-separator=: --key=1,1 --key=2,2n --key=3,3n',
		\ 'l': 'LANG=C nl --number-format=rz --number-width=4',
		\ 'n': 'LANG=C sort --numeric-sort',
		\ 'r': 'LANG=C rev',
		\ 's': 'LANG=C sort --ignore-case',
		\ 't': 'LANG=C tac',
		\ 'u': 'LANG=C uniq',
		\ 'x': 'LANG=C shuf',
		\ 'z': 'LANG=C cat --squeeze-blank',
	\ })
" Unused: bghijmopqvwy

let s:piper_command = ''
let s:old_opfunc = ''

function! s:set_command(key) abort
	let s:piper_command = a:key
	let s:old_opfunc = &operatorfunc
endfunction

function! PiperShowMappings() abort
	let l:old_more = &more
	let &more = 1

	echohl MoreMsg
	echo 'Vim Piper mappings:'
	echohl none

	for l:i in sort(keys(g:piper_command_list))
		echom printf("    %s : %s", l:i, g:piper_command_list[l:i])
	endfor

	let &more = l:old_more
endfunction

function! s:go(...) abort
	if !has_key(g:piper_command_list, s:piper_command)
		echoerr 'piper: unknown command key: ' . string(s:piper_command)
		return
	endif

	if !&l:modifiable
		echoerr 'piper: buffer is not modifiable'
		return
	endif

	let l:cmd = g:piper_command_list[s:piper_command]
	let l:exe = matchstr(l:cmd, '\%(LANG=\S\+\s\+\)\?\zs\S\+')
	if !executable(l:exe)
		echoerr 'piper: command not found: ' . l:exe
		return
	endif

	if (a:0 == 2)
		let [l:start, l:stop] = [a:1, a:2]
	else
		let [l:start, l:stop] = [line("'["), line("']")]
		let &operatorfunc = s:old_opfunc
	endif

	let l:view = winsaveview()

	silent! undojoin
	execute l:start . ',' . l:stop . '!' . g:piper_command_list[s:piper_command]

	if v:shell_error
		echoerr 'piper: command failed (exit ' . v:shell_error . '): ' . g:piper_command_list[s:piper_command]
	endif

	call winrestview(l:view)
endfunction

function! s:motion_or_count(key) abort
	call s:set_command(a:key)
	if v:count > 0
		return ":\<C-U>call " . s:go_ref . "(line('.'), line('.') + " . v:count1 . " - 1)\<CR>"
	endif
	let &operatorfunc = s:go_ref
	return 'g@'
endfunction

function! s:_init_ref() abort
	let s:go_ref = matchstr(expand('<sfile>'), '.*\zs<SNR>\d\+_') . 'go'
endfunction
call s:_init_ref()

function! s:set_up_mappings() abort
	for l:i in keys(g:piper_command_list)
		let l:u = toupper(l:i)

		execute 'nnoremap <silent> <Plug>PiperA_' . l:i . ' :call <SID>set_command("'     . l:i . '")<bar>call <SID>go(1, line(''$''))<CR>'
		execute 'nnoremap <silent> <Plug>PiperL_' . l:i . ' :call <SID>set_command("'     . l:i . '")<bar>call <SID>go(line(''.''), line(''.''))<CR>'
		execute 'nnoremap <silent> <expr> <Plug>PiperM_' . l:i . ' <SID>motion_or_count("'. l:i . '")'
		execute 'xnoremap <silent> <Plug>PiperV_' . l:i . ' :<C-U>call <SID>set_command("'. l:i . '")<bar>call <SID>go(line("''<"), line("''>"))<CR>'

		" Four mappings for each command
		"       PiperA all the file
		"       PiperL line (single)
		"       PiperM motion
		"       PiperV visual
		if (get(g:, 'piper_create_mappings', 1))
			execute 'nmap cp' . l:u       . ' <Plug>PiperA_' . l:i
			execute 'nmap cp' . l:i . l:i . ' <Plug>PiperL_' . l:i
			execute 'nmap cp' . l:i       . ' <Plug>PiperM_' . l:i
			execute 'xmap cp' . l:i       . ' <Plug>PiperV_' . l:i
		endif
	endfor

	nnoremap <silent> <Plug>PiperShowMappings :call PiperShowMappings()<CR>

	command! -nargs=1 -range=% -complete=customlist,s:complete_keys Piper
		\ call s:set_command(<q-args>) | call s:go(<line1>, <line2>)
	command! -nargs=0 PiperShowMappings call PiperShowMappings()
endfunction

function! s:complete_keys(ArgLead, CmdLine, CursorPos) abort
	return filter(sort(keys(g:piper_command_list)), 'v:val =~# "^" . a:ArgLead')
endfunction


call s:set_up_mappings()

