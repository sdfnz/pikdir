" pikdir - popup window directory viewer plugin
" Last update: 2020/01/22
" Maintainer: Ryan Parker <contact@sdf.nz>

if exists("g:loaded_pikdir")
	finish
endif
let g:loaded_pikdir = 1

function MyDialogH(id, result)
	if a:result
		echo "sweet"	
	endif
endfunc

if !hasmapto('<Plug>pikdir')
	nnoremap <C-n> :call popup_dialog('hello, world', #{
				\ filter: 'popup_filter_yesno',
				\ callback: 'MyDialogH',
				\ })<CR>
endif
