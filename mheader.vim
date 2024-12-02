"let s:asciiart = [
"			   \"            ################",
"			   \"          ####################",
"			   \"        ########################",
"			   \"       #############+########### #,
"			   \"       ######-..        .+########",
"			   \"       ####-..            ..+#### ",
"			   \"       ###-...             .-####",
"			   \"       ###...              ..+##",
"			   \"        #-.++###.      -###+..##",
"			   \"        #....  ...   .-.  ....##",
"			   \"     --.#.-#+## -..  -+ ##-#-.-...",
"			   \"      ---....... ..  ........... -",
"			   \"      -+#..     ..   .       .+-.",
"			   \"       .--.     .     .     ..+.",
"			   \"         -..    .+--.-.     ...",
"			   \"         +.... .-+#.#+.    ..-",
"			   \"          +...#####-++###-..-",
"			   \"          #---..----+--.---+##",
"			   \"        ###-+--.... ....--+#####",
"			   \"  ##########--#-.......-#-###########",
"		  	   \]

let s:asciiart = [
			  \"  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣦⣴⣶⣾⣿⣶⣶⣶⣶⣦⣤⣄⠀⠀⠀⠀⠀⠀⠀",
			  \"  ⠀⠀⠀⠀⠀⠀⠀⢠⡶⠻⠛⠟⠋⠉⠀⠈⠤⠴⠶⠶⢾⣿⣿⣿⣷⣦⠄⠀⠀⠀",
			  \"  ⠀⠀⠀⠀⠀⢀⠔⠋⠀⠀⠤⠒⠒⢲⠀⠀⠀⢀⣠⣤⣤⣬⣽⣿⣿⣿⣷⣄⠀⠀",
			  \"  ⠀⠀⠀⣀⣎⢤⣶⣾⠅⠀⠀⢀⡤⠏⠀⠀⠀⠠⣄⣈⡙⠻⢿⣿⣿⣿⣿⣿⣦⠀",
			  \"  ⢀⠔⠉⠀⠊⠿⠿⣿⠂⠠⠢⣤⠤⣤⣼⣿⣶⣶⣤⣝⣻⣷⣦⣍⡻⣿⣿⣿⣿⡀",
			  \"  ⢾⣾⣆⣤⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠉⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇",
			  \"  ⠀⠈⢋⢹⠋⠉⠙⢦⠀⠀⠀⠀⠀⠀⢀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇",
			  \"  ⠀⠀⠀⠑⠀⠀⠀⠈⡇⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇",
			  \"  ⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⢀⣾⣿⣿⠿⠟⠛⠋⠛⢿⣿⣿⠻⣿⣿⣿⣿⡿⠀",
			  \"  ⠀⠀⠀⠀⠀⠀⠀⢀⠇⠀⢠⣿⣟⣭⣤⣶⣦⣄⡀⠀⠀⠈⠻⠀⠘⣿⣿⣿⠇⠀",
			  \"  ⠀⠀⠀⠀⠀⠱⠤⠊⠀⢀⣿⡿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠘⣿⠏⠀⠀",
			  \"  ⠀⠀⠀⠀⠀⡄⠀⠀⠀⠘⢧⡀⠀⠀⠸⣿⣿⣿⠟⠀⠀⠀⠀⠀⠀⠐⠋⠀⠀⠀",
			  \"  ⠀⠀⠀⠀⠀⠘⠄⣀⡀⠸⠓⠀⠀⠀⠠⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
			  \]

let s:start		= '//'
let s:end		= ''
let s:fill		= ''
let s:length	= 140
let s:margin	= 1

let s:types		= {
			\'\.c$\|\.h$\|\.cc$\|\.hh$\|\.cpp$\|\.hpp$\|\.php$\|\.tpp':
			\['//', '', ''],
			\'\.htm$\|\.html$\|\.xml$':
			\['<!--', '-->', '*'],
      \'\.lua$':
      \['--', '--', ''],
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

	let s:start	= '#'
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
	if a:n == 1
		return s:textline(s:ascii(a:n), '')
	elseif a:n == 2 " filename
		return s:textline(s:ascii(a:n), "𓐓  " . s:filename() . " 𓐔 " . "          ")
	elseif a:n == 3 
		return s:textline(s:ascii(a:n), '')
	elseif a:n == 4 " author
		return s:textline(s:ascii(a:n), "Student: " . s:user() . " <" . s:mail() . "> ")
	elseif a:n == 5 || a:n == 6
		return s:textline(s:ascii(a:n), '')
	elseif a:n == 7 " created
		return s:textline(s:ascii(a:n), "Created: " . s:date() . " by " . s:user())
	elseif a:n == 8 " updated
		return s:textline(s:ascii(a:n), "Updated: " . s:date() . " by " . s:user())
	elseif a:n == 9 || a:n == 10 || a:n == 13
		return s:textline(s:ascii(a:n), '')
	elseif a:n == 11
		return s:textline(s:ascii(a:n), '𓆩♕𓆪      ')
	elseif a:n == 12
		return s:textline(s:ascii(a:n), "𓄂 oussama ezzaou𓆃  ")
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
	let l:line = 13

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
	if getline(8) =~ s:start . '\s*' . '.*Updated: '
		call setline(8, s:line(8))
		call setline(2, s:line(2))
		return 0
	endif
	return 1
endfunction

function! s:Mheader()
	if s:update ()
		call s:insert()
	endif
endfunction

" Bind command & shortcut
command! Mheader call s:Mheader ()
map <F1> :Mheader<CR>
autocmd BufWritePre * call s:update ()
