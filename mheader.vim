let s:asciiart = [
			   \"            ################",
			   \"          ####################",
			   \"        ########################",
			   \"       #############+########### #",
			   \"       ######-..        .+########",
			   \"       ####-..            ..+#### ",
			   \"       ###-...             .-####",
			   \"       ###...              ..+##",
			   \"        #-.++###.      -###+..##",
			   \"        #....  ...   .-.  ....##",
			   \"     --.#.-#+## -..  -+ ##-#-.-...",
			   \"      ---....... ..  ........... -",
			   \"      -+#..     ..   .       .+-.",
			   \"       .--.     .     .     ..+.",
			   \"         -..    .+--.-.     ...",
			   \"         +.... .-+#.#+.    ..-",
			   \"          +...#####-++###-..-",
			   \"          #---..----+--.---+##",
			   \"        ###-+--.... ....--+#####",
			   \"  ##########--#-.......-#-###########",
			   \]


let s:start		= '//'
let s:end		= ''
let s:fill		= ''
let s:length	= 80
let s:margin	= 1

let s:types		= {
			\'\.c$\|\.h$\|\.cc$\|\.hh$\|\.cpp$\|\.hpp$\|\.php$\|\.tpp':
			\['//', '', ''],
			\'\.htm$\|\.html$\|\.xml$':
			\['<!--', '-->', '*'],
			\'\.js$':
			\['//', '', ''],
			\'\.tex$':
			\['%', '%', '*'],
			\'\.ml$\|\.mli$\|\.mll$\|\.mly$':
			\['(*', '*)', '*'],
			\'\.vim$\|\vimrc$':
			\['"', '"', '*'],
			\'\.el$\|\emacs$':
			\[';', ';', '*'],
			\'\.f90$\|\.f95$\|\.f03$\|\.f$\|\.for$':
			\['!', '!', '/']
			\}

function! s:filetype()
	let l:f = s:filename()

	let s:start	= '# '
	let s:end	= ''
	let s:fill	= ''

	for type in keys(s:types)
		if l:f =~ type
			let s:start	= s:types[type][0]
			let s:end	= s:types[type][1]
			let s:fill	= s:types[type][2]
		endif
	endfor

endfunction

function! s:ascii(n)
	return s:asciiart[a:n - 1]
endfunction

function! s:textline(left, right)
	let l:left = strpart(a:left, 0, s:length - s:margin * 2 - strlen(a:right))

	return s:start . repeat(' ', s:margin - strlen(s:start)) . l:left . repeat(' ', s:length - s:margin * 2 - strlen(l:left) - strlen(a:right)) . a:right . s:end
endfunction

function! s:line(n)
	if a:n == 1 || a:n == 2 || a:n == 3  || a:n == 4 || a:n == 6 || a:n == 7 || a:n == 9 || a:n == 12
		return s:textline(s:ascii(a:n), '')
	elseif a:n == 13 || a:n == 14 || a:n == 15 || a:n == 16 || a:n == 17 || a:n == 18 || a:n == 19
		return s:textline(s:ascii(a:n), '')
	elseif a:n == 20
		return s:textline(s:ascii(a:n), "Made By Oussama Ezzaou <OEZZAOU> :)")
	elseif a:n == 5 " filename
		return s:textline(s:ascii(a:n), "< " . s:filename() . " >" . "                        ")
	elseif a:n == 8 " author
		return s:textline(s:ascii(a:n), "Student: " . s:user() . " <" . s:mail() . ">")
	elseif a:n == 10 " created
		return s:textline(s:ascii(a:n), "Created: " . s:date() . " by " . s:user())
	elseif a:n == 11 " updated
		return s:textline(s:ascii(a:n), "Updated: " . s:date() . " by " . s:user())
	endif
endfunction

function! s:user()
	if exists('g:user42')
		return g:user42
	endif
	let l:user = $USER
	if strlen(l:user) == 0
		let l:user = "oezzaou"
	endif
	return l:user
endfunction

function! s:mail()
	if exists('g:mail42')
		return g:mail42
	endif
	let l:mail = $MAIL
	if strlen(l:mail) == 0
		let l:mail = "oezzaou@student.1337.ma"
	endif
	return l:mail
endfunction

function! s:filename()
	let l:filename = expand("%:t")
	if strlen(l:filename) == 0
		let l:filename = "< new >"
	endif
	return l:filename
endfunction

function! s:date()
	return strftime("%Y/%m/%d %H:%M:%S")
endfunction

function! s:insert()
	let l:line = 20

	" empty line after header
	call append(0, "")

	" loop over lines
	while l:line > 0
		call append(0, s:line(l:line))
		let l:line = l:line - 1
	endwhile
endfunction

function! s:update()
	call s:filetype()
	if getline(11) =~ s:start . '\s*' . '.*Updated: '
		call setline(11, s:line(11))
		return 0
	endif
	return 1
endfunction

function! s:Mheader()
	if s:update()
		call s:insert()
	endif
endfunction

" Bind command and shortcut
command! Mheader call s:Mheader ()
map <F1> :Mheader<CR>
autocmd BufWritePre * call s:Mheader ()
