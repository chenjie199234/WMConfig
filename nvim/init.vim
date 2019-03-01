"设置插件
set filetype=off
call plug#begin('~/.config/nvim/plugs')
"Plug 'autozimu/LanguageClient-neovim',{'branch': 'next','do': 'bash install.sh'}
Plug 'Shougo/deoplete.nvim',{ 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'zchee/deoplete-go',{'do':'make','for':'go'}
Plug 'fatih/vim-go',{'do':':GoUpdateBinaries godef','for':'go'}
Plug 'scrooloose/nerdtree'
Plug 'jiangmiao/auto-pairs'
Plug 'morhetz/gruvbox'
Plug 'bling/vim-bufferline'
call plug#end()
"deoplete
	let g:deoplete#enable_at_startup = 1
	call deoplete#custom#option({
		\ 'min_pattern_length': 2,
		\ 'ignore_case': v:true,
		\ })
"neosnippet
	imap <expr><TAB>     neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)":"\<TAB>"
	smap <expr><TAB>     neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)":"\<TAB>"
"deoplete-go
	let g:deoplete#sources#go#pointer = 1
	let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
	let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
	autocmd Bufwrite * silent! pclose!
"vim-go
	autocmd BufEnter *.go nnoremap <C-i> :GoDef<CR>
	autocmd BufEnter *.go nnoremap <M-i> :GoDef<CR>
	autocmd BufEnter *.go nnoremap <C-LeftMouse> <LeftMouse>:GoDef<CR>
	autocmd BufEnter *.go vnoremap <C-LeftMouse> <Esc><LeftMouse>:GoDef<CR>
	autocmd BufEnter *.go nnoremap <M-LeftMouse> <LeftMouse>:GoDef<CR>
	autocmd BufEnter *.go vnoremap <M-LeftMouse> <Esc><LeftMouse>:GoDef<CR>
	nmap <M-o> <C-o>
	let g:go_def_mapping_enabled=0
	let g:go_def_mode='godef'
	"解决折叠问题
	let g:go_fmt_experimental=1
"languageclient-neovim
	"let g:LanguageClient_hasSnippetSupport=0
	"let g:LanguageClient_rootMarkers={
		"\ 'go':['.git','go.mod'],
		"\ }
	"let g:LanguageClient_serverCommands={
		"\ 'go':['bingo'],
		"\ }
	"autocmd BufWrite *.go call LanguageClient_textDocument_formatting()
	"let g:LanguageClient_loggingFile=expand('~/.config/nvim/LanguageClient.log')
	"let g:LanguageClient_loggingLevel='WARN'
	"nnoremap <C-i> :call LanguageClient_textDocument_definition()<CR>
	"nnoremap <M-i> :call LanguageClient_textDocument_definition()<CR>
	"nnoremap <C-LeftMouse> <LeftMouse>:call LanguageClient_textDocument_definition()<CR>
	"vnoremap <C-LeftMouse> <Esc><LeftMouse>:call LanguageClient_textDocument_definition()<CR>
	"nnoremap <M-LeftMouse> <LeftMouse>:call LanguageClient_textDocument_definition()<CR>
	"vnoremap <M-LeftMouse> <Esc><LeftMouse>:call LanguageClient_textDocument_definition()<CR>
	"nnoremap <M-o> <C-o>
"auto-pairs
	let g:AutoPairsMapCh=0
	let g:AutoPairsShortcutToggle=''
	let g:AutoPairsShortcutFastWrap=''
	let g:AutoPairsShortcutJump=''
	let g:AutoPairsShortcutBackInsert=''
"bufferline
	let g:bufferline_show_bufnr=0
	let g:bufferline_solo_highlight=0
	let g:bufferline_echo=0
	autocmd VimEnter *
		\ let &statusline='%{bufferline#refresh_status()}'
		\ .bufferline#get_status_string()
"Color
	colorscheme gruvbox
	set termguicolors
	set background=dark
"NERDTree
	nnoremap <M-f> :NERDTreeToggle<CR>
	nnoremap <C-f> :NERDTreeToggle<CR>
	"没有指定文件地打开neovim时，自动打开nerdtree
	autocmd VimEnter * if argc() == 0 | NERDTree | endif
	"自动变更当前工作目录
	let NERDTreeChDirMode=2
	"窗口的宽度
	let NERDTreeWinSize=25
	"不显示帮助信息
	let NERDTreeMinimalUI=1
	"目录前显示的导航箭头
	let g:NERDTreeDirArrowExpandable='>'
	let g:NERDTreeDirArrowCollapsible='<'
	"自动删除不存在的buffer
	let NERDTreeAutoDeleteBuffer=1
"Q_de Q_cm
"从光标所在处删除到行首第一个非空字符
nnoremap dh d^
"从光标所在处删除到行尾部
nnoremap dl d$
"从光标所在处复制到行首第一个非空字符
nnoremap yh y^
"从光标所在处复制到行尾部
nnoremap yl y$
"Q_lr
"取消向左移动
nnoremap <C-h> <NOP>
nnoremap <BS> <NOP>
"取消向右移动
nnoremap <Space> <NOP>
"取消跳转到文本行开头
nnoremap 0 <NOP>
nnoremap g0 <NOP>
"重新设置跳转到屏幕行开头第一个非空字符
nnoremap g<C-h> g^
nnoremap g^ <NOP>
"重新设置跳转到文本行开头第一个非空字符
nnoremap <C-h> ^
nnoremap ^ <NOP>
"重新设置跳转到屏幕行尾
nnoremap g<C-l> g$
nnoremap g$ <NOP>
"重新设置跳转到文本行尾
nnoremap <C-l> $
nnoremap $ <NOP>
"取消跳转到屏幕行中间列
nnoremap gm <NOP>
"取消跳转到指定列
nnoremap <Bar> <NOP>
"取消在文本列中搜索指定字符，使用/搜索代替
nnoremap t <NOP>
nnoremap T <NOP>
nnoremap f <NOP>
nnoremap F <NOP>
nnoremap ; <NOP>
nnoremap , <NOP>
"Q_ud
"取消向下移动
nnoremap <C-j> <NOP>
nnoremap <C-m> <NOP>
nnoremap <C-n> <NOP>
nnoremap <NL> <NOP>
nnoremap _ <NOP>
nnoremap + <NOP>
"取消向上移动
nnoremap <C-p> <NOP>
nnoremap - <NOP>
"Q_tm
"重设单词移动
nnoremap <M-h> B
nnoremap <M-l> W
"取消单词移动，大写是以空格为分隔符
nnoremap w <NOP>
nnoremap W <NOP>
nnoremap e <NOP>
nnoremap E <NOP>
nnoremap b <NOP>
nnoremap B <NOP>
nnoremap ge <NOP>
nnoremap gE <NOP>
nnoremap ) <NOP>
nnoremap ( <NOP>
nnoremap { <NOP>
nnoremap } <NOP>
nnoremap [[ <NOP>
nnoremap ]] <NOP>
nnoremap ][ <NOP>
nnoremap [] <NOP>
nnoremap [m <NOP>
nnoremap [M <NOP>
nnoremap ]m <NOP>
nnoremap ]M <NOP>
nnoremap [# <NOP>
nnoremap ]# <NOP>
"Q_vm
"取消屏幕移动
nnoremap % <NOP>
nnoremap H <NOP>
nnoremap M <NOP>
nnoremap L <NOP>
nnoremap go <NOP>
"Q_ta
"nnoremap <C-[> <C-t>
nnoremap <C-]> <NOP>
nnoremap <C-t> <NOP>
nnoremap <C-w>} <NOP>
nnoremap <C-w>z <NOP>
"Q_sc
"取消ctrl-e屏幕单行滚动
nnoremap <C-e> <NOP>
nnoremap <C-y> <NOP>
"重新设定ctrl-j为向下翻一整页
nnoremap <C-j> <PageDown>
"nnoremap <C-f> <NOP>
"重新设定ctrl-k为向上翻一整页
nnoremap <C-k> <PageUp>
nnoremap <C-b> <NOP>
"重新设定alt-j为向下翻半页
nnoremap <C-M-j> <C-d>
"重新设定alt-k为向下翻半页
nnoremap <C-M-k> <C-u>
nnoremap <C-u> <NOP>
"取消绘制当前行到屏幕顶部中部或下部的重复的快捷键，使用zt,zz,zb代替
nnoremap z<CR> <NOP>
nnoremap z. <NOP>
nnoremap z- <NOP>
nnoremap zh <NOP>
nnoremap zl <NOP>
nnoremap zH <NOP>
nnoremap zL <NOP>
"Q_ss
inoremap <NL> <NOP>
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-o> <Esc>o
inoremap < <><ESC>i
inoremap << <<
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
vnoremap <C-o> <Esc>o
"Q_ch
nnoremap , <h
nnoremap . >l
vnoremap , <h
vnoremap . >l
nnoremap < <NOP>
nnoremap << <NOP>
nnoremap > <NOP>
nnoremap >> <NOP>
nnoremap <C-a> <NOP>
nnoremap <C-c> <NOP>
nnoremap <C-v> <NOP>
nnoremap <C-x> <NOP>
"Q_re
nnoremap q <NOP>
nnoremap gs <NOP>
"Q_ur
nnoremap <C-u> <C-r>
nnoremap <C-r> <NOP>
"Q_wq
nnoremap ww :w<CR>
nnoremap qq :q!<CR>
nnoremap wq :wq<CR>
nnoremap ZZ <NOP>
"Q_wi
nnoremap <M-w> <C-w>w
nnoremap <C-w> <NOP>
"Q_bu
nnoremap <M-d> :bd<CR>
nnoremap <C-d> :bd<CR>
inoremap <M-d> <ESC>:bd<CR>
inoremap <C-d> <ESC>:bd<CR>
nnoremap <M-k> :bp<CR>
inoremap <M-k> <ESC>:bp<CR>
nnoremap <M-j> :bn<CR>
inoremap <M-j> <ESC>:bn<CR>
"terminal
nnoremap <M-t> :botright split<CR>:terminal<CR>
tnoremap <Esc> <C-\><C-n>
tnoremap <M-w> <C-\><C-n><C-w>w
"Q_op
"设置显示行号
set number
"设置搜索时对大小写的响应
set ignorecase
set smartcase
"设置剪切板
set clipboard+=unnamedplus
"设置折叠
set foldmethod=indent
set foldlevel=2
function FoldSwitch()
	if foldclosed(line("."))<0
		if foldlevel(line("."))>0
			execute "normal zc"
		endif
	else
		exec "normal zo"
	endif
endfunction
nnoremap <space> :call FoldSwitch()<CR>
"设置鼠标使用
set mouse=a
"移动到行尾自动换行
set whichwrap=h,l,<,>

"vim退出编辑模式时关闭fcitx的中文输入
function Fcitx2en()
	let s:input_status=system("fcitx-remote")
	if s:input_status==2
		let l:a=system("fcitx-remote -c")
	endif
endfunction
autocmd InsertLeave * call Fcitx2en()

"注释
nnoremap ; :call SetComment()<CR>
vnoremap ; :<BS><BS><BS><BS><BS>call SetCommentV()<CR>
function SetComment()
	let s:filename=expand("%:t")
	let s:lastindex=strridx(s:filename,".")
	if s:lastindex<0||s:lastindex==(strlen(s:filename)-1)
		return
	endif
	let s:type=strpart(s:filename,s:lastindex)
	let s:lineindex=line(".")
	if foldclosed(s:lineindex)>0
		return
	endif
	let s:str=getline(s:lineindex)
	let s:length=strlen(s:str)
	if s:length==0
		return
	endif
	"check
	let s:isComment=0
	if s:type==".html"
		let s:laststr=getline(s:lineindex-1)
		let s:nextstr=getline(s:lineindex+1)
		if strlen(s:laststr)==0||strlen(s:nextstr)==0
			let s:isComment=0
		else
			let s:count=0
			let s:islast=0
			let s:isnext=0
			while s:count<strlen(s:laststr)
				if s:laststr[s:count]!=" "&&s:laststr[s:count]!="\t"
					if s:laststr[s:count]=="<"&&s:laststr[s:count+1]=="!"&&s:laststr[s:count+2]=="-"&&s:laststr[s:count+3]=="-"
						let s:islast=1
					endif
					break
				endif
				let s:count+=1
			endwhile
			let s:count=strlen(s:nextstr)-1
			while s:count>=0
				if s:nextstr[s:count]!=" "&&s:nextstr[s:count]!="\t"
					if s:nextstr[s:count]==">"&&s:nextstr[s:count-1]=="-"&&s:nextstr[s:count-2]=="-"
						let s:isnext=1
					endif
					break
				endif
				let s:count-=1
			endwhile
			if s:islast==1&&s:isnext==1
				let s:isComment=1
			endif
		endif
	endif
	let s:count=0
	while s:count<s:length
		if s:str[s:count]!=" "&&s:str[s:count]!="\t"
			if s:type==".sh"
				if s:str[s:count]=="#"
					let s:isComment=1
				else
					let s:isComment=0
				endif
			elseif s:type==".vim"
				if s:str[s:count]=="\""
					let s:isComment=1
				else
					let s:isComment=0
				endif
			elseif s:type==".go"||s:type==".js"||s:type==".h"||s:type==".hpp"||s:type==".hxx"||s:type==".c"||s:type==".cc"||s:type==".cpp"||s:type==".cxx"||s:type==".C"||s:type==".c++"
				if s:count==(s:length-1)
					let s:isComment=0
				elseif (s:str[s:count]=="/"&&s:str[s:count+1]=="*")||(s:str[s:count]=="*"&&s:str[s:count+1]=="/")
					return
				elseif s:str[s:count]=="/"&&s:str[s:count+1]=="/"
					let s:isComment=1
				else
					let s:isComment=0
				endif
			elseif s:type==".lua"
				if s:count==(s:length-1)
					let s:isComment=0
				elseif s:str[s:count]=="-"&&s:str[s:count+1]=="-"
					if s:length-s:count>=4&&((s:str[s:count+2]=="["&&s:str[s:count+3]=="[")||(s:str[s:count+2]=="]"&&s:str[s:count+3]=="]"))
						let s:isComment=0
					else
						let s:isComment=1
					endif
				else
					let s:isComment=0
				endif
			endif
			break
		endif
		let s:count+=1
	endwhile
	"comment
	call cursor(s:lineindex,s:count+1)
	if s:isComment==1
		if s:type==".html"
			execute "normal kdd"
			execute "normal jddk"
		elseif s:type==".vim"||s:type==".sh"
			execute "normal x"
		elseif s:type==".go"||s:type==".js"||s:type==".lua"
			execute "normal xx"
		elseif s:type==".h"||s:type==".hpp"||s:type==".hxx"||s:type==".c"||s:type==".cc"||s:type==".cpp"||s:type==".cxx"||s:type==".C"||s:type==".c++"
			execute "normal xx"
		endif
	elseif s:isComment==0
		if s:type==".html"
			execute "normal O<!--"
			let s:temp=join(split(getline(line(".")),">"),"")
			call setline(line("."),s:temp)
			execute "normal jo-->"
			execute "normal k"
		elseif s:type==".sh"
			execute "normal i#"
		elseif s:type==".vim"
			execute "normal i\""
		elseif s:type==".go"||s:type==".js"
			execute "normal i//"
		elseif s:type==".h"||s:type==".hpp"||s:type==".hxx"||s:type==".c"||s:type==".cc"||s:type==".cpp"||s:type==".cxx"||s:type==".C"||s:type==".c++"
			execute "normal i//"
		elseif s:type==".lua"
			execute "normal i--"
		endif
	endif
endfunction
function SetCommentV()
	let s:filename=expand("%:t")
	let s:lastindex=strridx(s:filename,".")
	if s:lastindex<0||s:lastindex==(strlen(s:filename)-1)
		return
	endif
	let s:type=strpart(s:filename,s:lastindex)
	let s:beginline=line("'<")
	let s:begincol=col("'<")
	let s:endline=line("'>")
	let s:endcol=col("'>")
	if s:beginline == s:endline
		if s:type==".html"||s:type==".vim"||s:type==".sh"
			call SetComment()
		elseif s:type==".go"||s:type==".js"
			call cursor(s:beginline,s:begincol)
			execute "normal i/*"
			call cursor(s:endline,s:endcol+2)
			execute "normal a*/"
		elseif s:type==".h"||s:type==".hpp"||s:type==".hxx"||s:type==".c"||s:type==".cc"||s:type==".cpp"||s:type==".cxx"||s:type==".C"||s:type==".c++"
			call cursor(s:beginline,s:begincol)
			execute "normal i/*"
			call cursor(s:endline,s:endcol+2)
			execute "normal a*/"
		elseif s:type==".lua"
			let s:str=getline(s:beginline)
			let s:front=strpart(s:str,0,s:begincol-1)
			let s:middle=strpart(s:str,s:begincol-1,s:endcol-s:begincol+1)
			let s:back=strpart(s:str,s:endcol)
			call setline(s:beginline,s:front."--[[".s:middle."--]]".s:back)
		endif
	else
		if s:type==".sh"
			execute s:beginline.",".s:endline."s/^/#/"
		elseif s:type==".vim"
			execute s:beginline.",".s:endline."s/^/\"/"
		elseif s:type==".html"
			call cursor(s:beginline,0)
			execute "normal O<!--"
			call setline(line("."),join(split(getline(line(".")),">"),""))
			call cursor(s:endline+1,0)
			execute "normal o-->"
		elseif s:type==".go"||s:type==".js"
			call cursor(s:beginline,0)
			execute "normal O/*"
			call cursor(s:endline+1,0)
			execute "normal o*/"
		elseif s:type==".h"||s:type==".hpp"||s:type==".hxx"||s:type==".c"||s:type==".cc"||s:type==".cpp"||s:type==".cxx"||s:type==".C"||s:type==".c++"
			call cursor(s:beginline,0)
			execute "normal O/*"
			call cursor(s:endline+1,0)
			execute "normal o*/"
		elseif s:type==".lua"
			call cursor(s:beginline,0)
			execute "normal O--[["
			call setline(line("."),join(split(getline(line(".")),"]"),""))
			call cursor(s:endline+1,0)
			execute "normal o--]]"
		endif
	endif
endfunction
