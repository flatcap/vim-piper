" filter.vim - The magic of pipes
" Maintainer:	Rich Russon (flatcap) <rich@flatcap.org>
" Version:	0.1

" visual	cps		sort block
" operator	cps<motion>	sort motion
" normal	cpss		sort line
" normal	cpS		sort whole file

if exists("g:loaded_filter") || &cp || v:version < 700
	finish
endif
let g:loaded_filter = 1

function! s:go(...) "abort
	if (a:0 == 2)
		let [start, stop] = [a:1, a:2]
	else
		let [start, stop] = [line("'["), line("']")]
	endif

	execute start.','.stop.'!sort'
endfunction

xnoremap <silent> <Plug>Filter       :<C-U>call <SID>go(line("'<"),line("'>"))<CR>
nnoremap <silent> <Plug>FilterMotion :<C-U>set opfunc=<SID>go<CR>g@
nnoremap <silent> <Plug>FilterAll    :call <SID>go(1,line('$'))<CR>
nnoremap <silent> <Plug>FilterLine   :call <SID>go(line('.'),line('.'))<CR>

if !hasmapto('<Plug>Filter') || maparg('cps','n') ==# ''
	xmap cps  <Plug>Filter
	nmap cps  <Plug>FilterMotion
	nmap cpss <Plug>FilterLine
	nmap cpS  <Plug>FilterAll
endif

" vim:set noet ts=8 sw=8:
