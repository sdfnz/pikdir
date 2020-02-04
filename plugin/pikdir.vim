" pikdir - popup directory viewer
" Last update: 2020/02/04
" Maintainer: Ryan Parker <contact@sdf.nz>

if exists("g:loaded_pikdir")
	finish
endif
let g:loaded_pikdir = 1

let g:pikdirStartDir = getcwd() 

function ShowFiles(dir)
	let g:pikdirFileList = split(globpath(a:dir, '*'), '\n')
	:call add(g:pikdirFileList, '..')
	:call popup_menu(g:pikdirFileList, #{
		\ callback: 'HandleChoice',
		\ })
endfunc

function HandleChoice(id, choice)
	if a:choice >= 0
		let pikdirFile = g:pikdirFileList[a:choice-1]
		let pikdirIsDir = isdirectory(pikdirFile)
		if pikdirIsDir
			let pikdirPath = fnamemodify(pikdirFile, ":p")
			execute "cd" pikdirPath
			:call ShowFiles(pikdirPath)
		else
			execute "vsplit" pikdirFile
			execute "cd" g:pikdirStartDir
		endif
	endif
endfunc

nnoremap <Plug>pikDir :call ShowFiles(".")<CR>

if !hasmapto('<Plug>pikDir')
	map <C-n> <Plug>pikDir
endif
