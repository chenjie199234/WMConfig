"设置插件
call plug#begin($HOME..'/.config/nvim/plugs')
	Plug 'preservim/nerdcommenter'
	Plug 'morhetz/gruvbox'
	Plug 'bling/vim-bufferline'
	"lsp
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
filetype plugin indent on

set updatetime=100
"禁止使用备份
set nobackup
set nowritebackup
set noswapfile
"设置显示行号
set number
"移动到行尾自动换行
set whichwrap=h,l,<,>
"设置搜索时对大小写的响应
set ignorecase
set smartcase
"设置新行缩进
set autoindent
set smartindent
"垂直滚动时，光标距离顶部/底部的行数
set scrolloff=5
"保存文件的历史变更记录
"set undofile
"设置剪切板
set clipboard+=unnamedplus
"设置鼠标使用
set mouse=a
set shortmess+=c
"从光标所在处删除到行首第一个非空字符
	nnoremap dh d^
"从光标所在处删除到行尾部
	nnoremap dl d$
"从光标所在处复制到行首第一个非空字符
	nnoremap yh y^
"从光标所在处复制到行尾部
	nnoremap yl y$
"重新设置跳转到文本行开头第一个非空字符
	nnoremap <C-h> ^
"重新设置跳转到文本行尾
	nnoremap <C-l> $
"取消在文本列中搜索指定字符，使用/搜索代替
	nnoremap t <NOP>
	nnoremap T <NOP>
	nnoremap f <NOP>
	nnoremap F <NOP>
	nnoremap ; <NOP>
	nnoremap , <NOP>
"取消多余的向下移动快捷键
	nnoremap <C-j> <NOP>
	nnoremap <C-m> <NOP>
	nnoremap <C-n> <NOP>
	nnoremap + <NOP>
"取消多余的向上移动快捷键
	nnoremap <C-p> <NOP>
	nnoremap - <NOP>
"重设单词移动
	nnoremap <M-h> b
	nnoremap <M-l> w
"取消单词移动，大写是以空格为分隔符
	nnoremap w <NOP>
	nnoremap W <NOP>
	nnoremap e <NOP>
	nnoremap E <NOP>
	nnoremap b <NOP>
	nnoremap B <NOP>
	nnoremap ge <NOP>
	nnoremap gE <NOP>
"取消屏幕移动
	nnoremap % <NOP>
	nnoremap H <NOP>
	nnoremap M <NOP>
	nnoremap L <NOP>
	nnoremap go <NOP>
"取消tag相关
	nnoremap <C-]> <NOP>
	nnoremap <C-t> <NOP>
	nnoremap <C-w>} <NOP>
	nnoremap <C-w>z <NOP>
"取消ctrl-e屏幕单行滚动
	nnoremap <C-e> <NOP>
	nnoremap <C-y> <NOP>
"重新设定ctrl-j为向下翻一整页
	nnoremap <C-j> <PageDown>
	nnoremap <M-j> <PageDown>
	nnoremap <C-f> <NOP>
"重新设定ctrl-k为向上翻一整页
	nnoremap <C-k> <PageUp>
	nnoremap <M-k> <PageUp>
	nnoremap <C-b> <NOP>
"操作回退
	nnoremap <C-u> <C-r>
	nnoremap <M-u> <C-r>
	nnoremap <C-r> <NOP>
"文件保存退出
	nnoremap ww :w<CR>
	nnoremap wq :wq<CR>
	nnoremap qq :q!<CR>
	nnoremap <C-q> :q!<CR>
	nnoremap <M-q> :q!<CR>
	nnoremap <C-d> :bd<CR>
	nnoremap <M-d> :bd<CR>
	nnoremap <C-n> :bn<CR>
	nnoremap <M-n> :bn<CR>
	nnoremap <C-b> :bp<CR>
	nnoremap <M-b> :bp<CR>
	nnoremap ZZ <NOP>
"窗口移动
	nnoremap <M-w> <C-w>w
	nnoremap <C-w> <C-w>w
"取消绘制当前行到屏幕顶部中部或下部的重复的快捷键，使用zt,zz,zb代替
	nnoremap z<CR> <NOP>
	nnoremap z. <NOP>
	nnoremap z- <NOP>
	nnoremap zh <NOP>
	nnoremap zl <NOP>
	nnoremap zH <NOP>
	nnoremap zL <NOP>
"插入模式下移动快捷键,以及补全快捷键
	inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<Down>"
	inoremap <expr><M-j> pumvisible() ? "\<C-n>" : "\<Down>"
	inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<Up>"
	inoremap <expr><M-k> pumvisible() ? "\<C-p>" : "\<Up>"
	inoremap <C-h> <Left>
	inoremap <C-l> <Right>
	inoremap <C-o> <Esc>o
	cnoremap <C-h> <Left>
	cnoremap <C-l> <Right>
	cnoremap <C-p> <C-r>"
	cnoremap <M-p> <C-r>"
"缩进快捷键
	nnoremap , <h
	nnoremap . >l
	vnoremap , <h
	vnoremap . >l
	nnoremap <C-a> <NOP>
	nnoremap <C-c> <NOP>
	nnoremap <C-v> <NOP>
	nnoremap <C-x> <NOP>
"terminal
	nnoremap tt :botright split<CR>:terminal<CR>
	tnoremap <Esc> <C-\><C-n>
	tnoremap <M-w> <C-\><C-n><C-w>w
	tnoremap <C-w> <C-\><C-n><C-w>w
"coc
	let g:coc_global_extensions = ['coc-snippets','coc-pairs','coc-explorer']
	inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm():"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
	nmap <silent> <C-r> <ESC>:<C-u>call CocActionAsync('rename')<CR>
	nmap <silent> <M-r> <ESC>:<C-u>call CocActionAsync('rename')<CR>
	nmap <silent> <C-i> <ESC>:<C-u>call CocActionAsync('jumpDefinition')<CR>
	nmap <silent> <M-i> <ESC>:<C-u>call CocActionAsync('jumpDefinition')<CR>
	nmap <silent> ` <ESC>:<C-u>call CocActionAsync('doHover')<CR>
	nmap <silent> <C-`> <ESC>:<C-u>call CocActionAsync('doHover')<CR>
	nmap <silent> <M-`> <ESC>:<C-u>call CocActionAsync('doHover')<CR>
	nmap <silent> <ESC> <ESC>:<C-u>call coc#float#close_all()<CR>
	nmap <M-o> <C-o>
	inoremap <silent><expr> <TAB>
	  \ pumvisible() ? coc#_select_confirm() :
	  \ coc#expandableOrJumpable() ?
	  \ "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
	  \ <SID>check_back_space() ? "\<TAB>" :
	  \ coc#refresh()
	function! s:check_back_space() abort
	  let col = col('.') - 1
	  return !col || getline('.')[col - 1]  =~# '\s'
	endfunction
	let g:coc_snippet_next = '<tab>'
	call coc#config('coc.preferences',{
	\ 	"formatOnSaveFiletypes":["go","h","c","cpp","hxx","cxx"],
	\ 	"bracketEnterImprove":"true"
	\})
	call coc#config('diagnostic',{
	\ 	"checkCurrentLine":"true"
	\})
	call coc#config('languageserver',{
	\ 'golang': {
	\ 	"command": "gopls",
      	\ 	"rootPatterns": ["go.mod",".git/"],
      	\ 	"disableWorkspaceFolders": "true",
      	\ 	"filetypes": ["go"]
	\ },
	\ 'clangd': {
      	\ 	"command": "clangd",
      	\ 	"rootPatterns": ["compile_flags.txt", "compile_commands.json"],
      	\ 	"filetypes": ["c", "cc", "cpp", "c++", "objc", "objcpp"]
	\ },
    	\ 'lua': {
      	\ 	"command": "lua-lsp",
      	\ 	"filetypes": ["lua"]
    	\ }
	\})

	"优先search,然后warning/error,最后reference
	function SearchNext()
		"获取当前行和列
		let s:bl=line(".")
		let s:bc=col(".")
		silent! execute "normal! n"
		let s:al=line(".")
		let s:ac=col(".")
		if s:bl == s:al && s:bc == s:ac
			let s:eandw = 0
			if exists("b:coc_diagnostic_info")
				let s:eandw = b:coc_diagnostic_info['error']+b:coc_diagnostic_info['warning']
			endif
			if s:eandw > 0
				call CocActionAsync('diagnosticNext')
			else
				call CocActionAsync('jumpReferences')
			endif
		endif
	endfunction
	""优先search,然后warning/error,最后reference
	function SearchPrev()
		let s:bl=line(".")
		let s:bc=col(".")
		silent! execute "normal! N"
		let s:al=line(".")
		let s:ac=col(".")
		if s:bl == s:al && s:bc == s:ac
			let s:eandw = 0
			if exists("b:coc_diagnostic_info")
				let s:eandw = b:coc_diagnostic_info['error']+b:coc_diagnostic_info['warning']
			endif
			if s:eandw > 0
				call CocActionAsync('diagnosticPrevious')
			else
				call CocActionAsync('jumpReferences')
			endif
		endif
	endfunction
	nmap <silent> n :call SearchNext()<CR>
	nmap <silent> N :call SearchPrev()<CR>
	nnoremap <C-f> <ESC>:CocCommand explorer --toggle --position floating<CR>
	nnoremap <M-f> <ESC>:CocCommand explorer --toggle --position floating<CR>
"nerdcommenter
	let g:NERDCreateDefaultMappings=0
	let g:NERDDefaultAlign='left'
	let g:NERDCompactSexyComs=1
	nmap ; <plug>NERDCommenterToggle
	vmap ; <plug>NERDCommenterToggle
"bufferline
	let g:bufferline_show_bufnr=0
	let g:bufferline_solo_highlight=0
	let g:bufferline_echo=0
	autocmd VimEnter * let &statusline='%{bufferline#refresh_status()}' .bufferline#get_status_string().'%<%=%r %m %f %-5.15(%l,%c-%v%) %p%%'
"Color
	colorscheme gruvbox
	set background=dark
	"取消gruvbox的背景颜色,使用term自带的背景颜色,以此来使用透明背景
	if has("gui_running") || !has("mac")
		hi normal guibg=none ctermbg=none
	endif
"设置折叠
	set foldmethod=indent
	set foldlevel=1
	function FoldSwitch()
		if foldclosed(line("."))<0
			if foldlevel(line("."))>0
				execute "normal! zc"
			endif
		else
			exec "normal! zo"
		endif
	endfunction
	nnoremap <silent><space> :call FoldSwitch()<CR>
"vim退出编辑模式时关闭fcitx的中文输入
	function Fcitx2en()
		let s:input_status=system("fcitx-remote")
		if s:input_status==2
			let l:a=system("fcitx-remote -c")
		endif
	endfunction
	autocmd InsertLeave * call Fcitx2en()
