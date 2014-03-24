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

function! s:go(command,args)
	if (len(a:args) == 2)
		let [start, stop] = [a:args[0], a:args[1]]
	else
		let [start, stop] = [line("'["), line("']")]
	endif

	execute start.','.stop.'!'.a:command
endfunction

function! s:go_sort(...)
	call s:go("LANG=C sort -f", a:000)
endfunction

function! s:go_uniq(...)
	call s:go("LANG=C uniq", a:000)
endfunction

function! s:go_rev(...)
	call s:go("LANG=C rev", a:000)
endfunction

function! s:go_column(...)
	call s:go("LANG=C column -t", a:000)
endfunction

function! s:go_nl(...)
	call s:go("LANG=C nl -nrz -w4", a:000)
endfunction

function! s:go_random(...)
	call s:go("LANG=C sort -R", a:000)
endfunction

function! s:go_tac(...)
	call s:go("LANG=C tac", a:000)
endfunction

xnoremap <silent> <Plug>FilterSortVisual :<C-U>call <SID>go_sort(line("'<"),line("'>"))<CR>
nnoremap <silent> <Plug>FilterSortMotion :<C-U>set opfunc=<SID>go_sort<CR>g@
nnoremap <silent> <Plug>FilterSortAll    :call <SID>go_sort(1,line('$'))<CR>
nnoremap <silent> <Plug>FilterSortLine   :call <SID>go_sort(line('.'),line('.'))<CR>

xnoremap <silent> <Plug>FilterUniqVisual :<C-U>call <SID>go_uniq(line("'<"),line("'>"))<CR>
nnoremap <silent> <Plug>FilterUniqMotion :<C-U>set opfunc=<SID>go_uniq<CR>g@
nnoremap <silent> <Plug>FilterUniqAll    :call <SID>go_uniq(1,line('$'))<CR>
nnoremap <silent> <Plug>FilterUniqLine   :call <SID>go_uniq(line('.'),line('.'))<CR>

xnoremap <silent> <Plug>FilterRevVisual :<C-U>call <SID>go_rev(line("'<"),line("'>"))<CR>
nnoremap <silent> <Plug>FilterRevMotion :<C-U>set opfunc=<SID>go_rev<CR>g@
nnoremap <silent> <Plug>FilterRevAll    :call <SID>go_rev(1,line('$'))<CR>
nnoremap <silent> <Plug>FilterRevLine   :call <SID>go_rev(line('.'),line('.'))<CR>

xnoremap <silent> <Plug>FilterColumnVisual :<C-U>call <SID>go_column(line("'<"),line("'>"))<CR>
nnoremap <silent> <Plug>FilterColumnMotion :<C-U>set opfunc=<SID>go_column<CR>g@
nnoremap <silent> <Plug>FilterColumnAll    :call <SID>go_column(1,line('$'))<CR>
nnoremap <silent> <Plug>FilterColumnLine   :call <SID>go_column(line('.'),line('.'))<CR>

xnoremap <silent> <Plug>FilterNlVisual :<C-U>call <SID>go_nl(line("'<"),line("'>"))<CR>
nnoremap <silent> <Plug>FilterNlMotion :<C-U>set opfunc=<SID>go_nl<CR>g@
nnoremap <silent> <Plug>FilterNlAll    :call <SID>go_nl(1,line('$'))<CR>
nnoremap <silent> <Plug>FilterNlLine   :call <SID>go_nl(line('.'),line('.'))<CR>

xnoremap <silent> <Plug>FilterRandomVisual :<C-U>call <SID>go_random(line("'<"),line("'>"))<CR>
nnoremap <silent> <Plug>FilterRandomMotion :<C-U>set opfunc=<SID>go_random<CR>g@
nnoremap <silent> <Plug>FilterRandomAll    :call <SID>go_random(1,line('$'))<CR>
nnoremap <silent> <Plug>FilterRandomLine   :call <SID>go_random(line('.'),line('.'))<CR>

xnoremap <silent> <Plug>FilterTacVisual :<C-U>call <SID>go_tac(line("'<"),line("'>"))<CR>
nnoremap <silent> <Plug>FilterTacMotion :<C-U>set opfunc=<SID>go_tac<CR>g@
nnoremap <silent> <Plug>FilterTacAll    :call <SID>go_tac(1,line('$'))<CR>
nnoremap <silent> <Plug>FilterTacLine   :call <SID>go_tac(line('.'),line('.'))<CR>

if !hasmapto('<Plug>FilterSortVisual') || maparg('cps','n') ==# ''
	xmap cps  <Plug>FilterSortVisual
	nmap cps  <Plug>FilterSortMotion
	nmap cpss <Plug>FilterSortLine
	nmap cpS  <Plug>FilterSortAll

	xmap cpu  <Plug>FilterUniqVisual
	nmap cpu  <Plug>FilterUniqMotion
	nmap cpuu <Plug>FilterUniqLine
	nmap cpU  <Plug>FilterUniqAll

	xmap cpr  <Plug>FilterRevVisual
	nmap cpr  <Plug>FilterRevMotion
	nmap cprr <Plug>FilterRevLine
	nmap cpR  <Plug>FilterRevAll

	xmap cpc  <Plug>FilterColumnVisual
	nmap cpc  <Plug>FilterColumnMotion
	nmap cpcc <Plug>FilterColumnLine
	nmap cpC  <Plug>FilterColumnAll

	xmap cpn  <Plug>FilterNlVisual
	nmap cpn  <Plug>FilterNlMotion
	nmap cpnn <Plug>FilterNlLine
	nmap cpN  <Plug>FilterNlAll

	xmap cpx  <Plug>FilterRandomVisual
	nmap cpx  <Plug>FilterRandomMotion
	nmap cpxx <Plug>FilterRandomLine
	nmap cpX  <Plug>FilterRandomAll

	xmap cpt  <Plug>FilterTacVisual
	nmap cpt  <Plug>FilterTacMotion
	nmap cptt <Plug>FilterTacLine
	nmap cpT  <Plug>FilterTacAll
endif

" vim:set noet ts=8 sw=8:
