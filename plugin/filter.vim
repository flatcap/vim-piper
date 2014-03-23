" filter.vim - The magic of pipes
" Maintainer:	Rich Russon (flatcap) <rich@flatcap.org>
" Version:	0.1

if exists("g:loaded_filter") || &cp || v:version < 700
	finish
endif
let g:loaded_filter = 1

function! s:go(start, stop) "abort
	echomsg 'execute '.a:start.','.a:stop.'!sort'
endfunction

xnoremap <silent> <Plug>Filter :<C-U>call <SID>go(line("'<"),line("'>"))<CR>
nnoremap <silent> <Plug>Filter :call <SID>go(1,'$')<CR>

if !hasmapto('<Plug>Filter') || maparg('cps','n') ==# ''
	xmap cps <Plug>Filter
	nmap cps <Plug>Filter
endif

" vim:set noet ts=8 sw=8:
