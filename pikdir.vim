" pikdir - popup window directory viewer plugin
" Last update: 2020/01/22
" Maintainer: Ryan Parker <contact@sdf.nz>

if exists("g:loaded_pikdir")
	finish
endif
let g:loaded_pikdir = 1

function ShowFiles(dir)
	let g:files = split(globpath(a:dir, '*'), '\n')
	:call add(g:files, '..')
	:call popup_dialog(g:files, #{
		\ filter: 'popup_filter_menu',
		\ callback: 'HandleChoice',
		\ })
endfunc

function HandleChoice(id, choice)
	let f = g:files[a:choice-1]
	let isDir = isdirectory(f)
	if isDir
		:call ShowFiles(f)
	else
		execute "vsplit" f
	endif
endfunc

nnoremap <Plug>pikDir :call ShowFiles(".")<CR>

if !hasmapto('<Plug>pikDir')
	map <C-n> <Plug>pikDir
endif
