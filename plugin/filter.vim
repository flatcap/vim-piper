" filter.vim - The magic of pipes
" Maintainer:   Rich Russon (flatcap) <rich@flatcap.org>
" Version:      0.1

" Filter blocks of text through various system commands.
" Each mapping is of the form cpX (mnemonic Change-Pipe-X):
"
"  Mapping  Command      Description
" -------------------------------------------------
"  cpc      column -t    Arrange in columns
"  cpn      nl -nrz -w4  4 digit line numbers
"  cpr      rev          Write each line backwards
"  cps      sort -f      Sort the file
"  cpt      tac          Reverse the file
"  cpu      uniq         Remove duplicates
"  cpx      sort -R      Randomise (miX up)

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

function! s:go_column(...)
	call s:go("LANG=C column -t", a:000)
endfunction

function! s:go_nl(...)
	call s:go("LANG=C nl -nrz -w4", a:000)
endfunction

function! s:go_random(...)
	call s:go("LANG=C sort -R", a:000)
endfunction

function! s:go_rev(...)
	call s:go("LANG=C rev", a:000)
endfunction

function! s:go_sort(...)
	call s:go("LANG=C sort -f", a:000)
endfunction

function! s:go_tac(...)
	call s:go("LANG=C tac", a:000)
endfunction

function! s:go_uniq(...)
	call s:go("LANG=C uniq", a:000)
endfunction

" Four mappings for each command
"       FilterV visual
"       FilterM motion
"       FilterA all the file
"       FilterL line (single)

xnoremap <silent> <Plug>FilterV_Column :<C-U>call <SID>go_column(line("'<"),line("'>"))<CR>
nnoremap <silent> <Plug>FilterM_Column :<C-U>set opfunc=<SID>go_column<CR>g@
nnoremap <silent> <Plug>FilterA_Column :call <SID>go_column(1,line('$'))<CR>
nnoremap <silent> <Plug>FilterL_Column :call <SID>go_column(line('.'),line('.'))<CR>

xnoremap <silent> <Plug>FilterV_Nl     :<C-U>call <SID>go_nl(line("'<"),line("'>"))<CR>
nnoremap <silent> <Plug>FilterM_Nl     :<C-U>set opfunc=<SID>go_nl<CR>g@
nnoremap <silent> <Plug>FilterA_Nl     :call <SID>go_nl(1,line('$'))<CR>
nnoremap <silent> <Plug>FilterL_Nl     :call <SID>go_nl(line('.'),line('.'))<CR>

xnoremap <silent> <Plug>FilterV_Random :<C-U>call <SID>go_random(line("'<"),line("'>"))<CR>
nnoremap <silent> <Plug>FilterM_Random :<C-U>set opfunc=<SID>go_random<CR>g@
nnoremap <silent> <Plug>FilterA_Random :call <SID>go_random(1,line('$'))<CR>
nnoremap <silent> <Plug>FilterL_Random :call <SID>go_random(line('.'),line('.'))<CR>

xnoremap <silent> <Plug>FilterV_Rev    :<C-U>call <SID>go_rev(line("'<"),line("'>"))<CR>
nnoremap <silent> <Plug>FilterM_Rev    :<C-U>set opfunc=<SID>go_rev<CR>g@
nnoremap <silent> <Plug>FilterA_Rev    :call <SID>go_rev(1,line('$'))<CR>
nnoremap <silent> <Plug>FilterL_Rev    :call <SID>go_rev(line('.'),line('.'))<CR>

xnoremap <silent> <Plug>FilterV_Sort   :<C-U>call <SID>go_sort(line("'<"),line("'>"))<CR>
nnoremap <silent> <Plug>FilterM_Sort   :<C-U>set opfunc=<SID>go_sort<CR>g@
nnoremap <silent> <Plug>FilterA_Sort   :call <SID>go_sort(1,line('$'))<CR>
nnoremap <silent> <Plug>FilterL_Sort   :call <SID>go_sort(line('.'),line('.'))<CR>

xnoremap <silent> <Plug>FilterV_Tac    :<C-U>call <SID>go_tac(line("'<"),line("'>"))<CR>
nnoremap <silent> <Plug>FilterM_Tac    :<C-U>set opfunc=<SID>go_tac<CR>g@
nnoremap <silent> <Plug>FilterA_Tac    :call <SID>go_tac(1,line('$'))<CR>
nnoremap <silent> <Plug>FilterL_Tac    :call <SID>go_tac(line('.'),line('.'))<CR>

xnoremap <silent> <Plug>FilterV_Uniq   :<C-U>call <SID>go_uniq(line("'<"),line("'>"))<CR>
nnoremap <silent> <Plug>FilterM_Uniq   :<C-U>set opfunc=<SID>go_uniq<CR>g@
nnoremap <silent> <Plug>FilterA_Uniq   :call <SID>go_uniq(1,line('$'))<CR>
nnoremap <silent> <Plug>FilterL_Uniq   :call <SID>go_uniq(line('.'),line('.'))<CR>

if !hasmapto('<Plug>FilterV_Sort') || maparg('cpc','n') ==# ''
	xmap cpc  <Plug>FilterV_Column
	nmap cpc  <Plug>FilterM_Column
	nmap cpcc <Plug>FilterL_Column
	nmap cpC  <Plug>FilterA_Column

	xmap cpn  <Plug>FilterV_Nl
	nmap cpn  <Plug>FilterM_Nl
	nmap cpnn <Plug>FilterL_Nl
	nmap cpN  <Plug>FilterA_Nl

	xmap cpr  <Plug>FilterV_Rev
	nmap cpr  <Plug>FilterM_Rev
	nmap cprr <Plug>FilterL_Rev
	nmap cpR  <Plug>FilterA_Rev

	xmap cps  <Plug>FilterV_Sort
	nmap cps  <Plug>FilterM_Sort
	nmap cpss <Plug>FilterL_Sort
	nmap cpS  <Plug>FilterA_Sort

	xmap cpt  <Plug>FilterV_Tac
	nmap cpt  <Plug>FilterM_Tac
	nmap cptt <Plug>FilterL_Tac
	nmap cpT  <Plug>FilterA_Tac

	xmap cpu  <Plug>FilterV_Uniq
	nmap cpu  <Plug>FilterM_Uniq
	nmap cpuu <Plug>FilterL_Uniq
	nmap cpU  <Plug>FilterA_Uniq

	xmap cpx  <Plug>FilterV_Random
	nmap cpx  <Plug>FilterM_Random
	nmap cpxx <Plug>FilterL_Random
	nmap cpX  <Plug>FilterA_Random
endif

" vim:set noet ts=8 sw=8:
