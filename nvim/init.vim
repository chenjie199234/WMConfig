"设置插件
call plug#begin($HOME..'/.config/nvim/plugs')
	Plug 'preservim/nerdcommenter'
	Plug 'scrooloose/nerdtree'
	Plug 'morhetz/gruvbox'
	Plug 'bling/vim-bufferline'
	Plug 'jiangmiao/auto-pairs'
	"lsp
	Plug 'prabirshrestha/async.vim'
	Plug 'prabirshrestha/vim-lsp'
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'
	"snippets
	Plug 'prabirshrestha/asyncomplete-neosnippet.vim'
	Plug 'Shougo/neosnippet.vim'
	Plug 'Shougo/neosnippet-snippets'
call plug#end()
filetype plugin indent on

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
	nnoremap qq :q!<CR>
	nnoremap wq :wq<CR>
	nnoremap ZZ <NOP>
"窗口移动
	nnoremap <M-w> <C-w>w
	nnoremap <C-w> <C-w>w
"打开文件选择
	nnoremap <M-d> :bd<CR>
	nnoremap <C-d> :bd<CR>
	nnoremap <C-n> :bn<CR>
	nnoremap <M-n> :bp<CR>
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
	inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<Up>"
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
"asyncomplete
	function! s:MySort(options, matches) abort
		let l:items = []
		for [l:source_name, l:matches] in items(a:matches)
			for l:item in l:matches['items']
				"format neosnippets
				if l:source_name == 'neosnippet'
					let l:item['menu']=strpart(l:item['menu'],7)
					let l:item['kind']='snippets'
				endif
				"mark score
				let l:matchpos = stridx(tolower(l:item['word']), tolower(a:options['base']))
				if l:matchpos == 0
					let l:item['priority'] = get(asyncomplete#get_source_info(l:source_name),'priority',0)+10
					call add(l:items, l:item)
				elseif l:matchpos > 0
					let l:item['priority'] = get(asyncomplete#get_source_info(l:source_name),'priority',0)+5
					call add(l:items, l:item)
				endif
			endfor
		endfor
		let l:items = sort(l:items, {a, b -> b['priority'] - a['priority']})
		call asyncomplete#preprocess_complete(a:options, l:items)
	endfunction
	let g:asyncomplete_preprocessor = [function('s:MySort')]
"vim-lsp
	if executable('gopls')
		autocmd User lsp_setup call lsp#register_server({
			\ 'name': 'gopls',
			\ 'cmd': {server_info->['gopls']},
			\ 'whitelist': ['go'],
			\ })
		autocmd BufWritePre *.go silent LspDocumentFormatSync 
	endif
	if executable('clangd')
		autocmd User lsp_setup call lsp#register_server({
			\ 'name': 'clangd',
			\ 'cmd': {server_info->['clangd', '-background-index']},
			\ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
			\ })
	endif
	if executable('flow')
		autocmd User lsp_setup call lsp#register_server({
			\ 'name': 'flow',
			\ 'cmd': {server_info->['flow', 'lsp', '--from', 'vim-lsp']},
			\ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.flowconfig'))},
			\ 'whitelist': ['javascript', 'javascript.jsx'],
			\ })
	endif
	let g:lsp_diagnostics_float_cursor = 1
	let g:lsp_diagnostics_float_delay = 200
	let g:lsp_virtual_text_enabled = 0
	let g:lsp_highlight_references_enabled = 1
	"代码跳转
	nmap <M-o> <C-o>
	nmap <C-i> <plug>(lsp-definition)
	nmap <M-i> <plug>(lsp-peek-definition)
	"显示光标下的变量或者函数的信息
	nmap ` <plug>(lsp-hover)
	"如果存在preview窗口就关闭
	nmap <ESC> <plug>(lsp-preview-close)
	"如果存在preview窗口就进入
	nmap <CR> <plug>(lsp-preview-focus)
	"重命名变量
	nmap <C-r> <plug>(lsp-rename)
	nmap <M-r> <plug>(lsp-rename)
	"优先search,然后error,最后reference
	function SearchNext()
		"获取当前行和列
		let s:bl=line(".")
		let s:bc=col(".")
		silent! execute "normal! /\<CR>"
		let s:al=line(".")
		let s:ac=col(".")
		if s:bl == s:al && s:bc == s:ac
			let s:ec=lsp#get_buffer_diagnostics_counts()
			if s:ec['error'] > 0
				silent! execute "normal! :LspNextError\<CR>"
			else
				silent! execute "normal! :LspNextReference\<CR>"
			endif
		endif
	endfunction
	"优先search,然后error,最后reference
	function SearchPrev()
		let s:bl=line(".")
		let s:bc=col(".")
		silent! execute "normal! ?\<CR>"
		let s:al=line(".")
		let s:ac=col(".")
		if s:bl == s:al && s:bc == s:ac
			let s:ec=lsp#get_buffer_diagnostics_counts()
			if s:ec['error'] > 0
				silent! execute "normal! :LspPreviousError\<CR>"
			else
				silent! execute "normal! :LspPreviousReference\<CR>"
			endif
		endif
	endfunction
	nmap <silent> n :call SearchNext()<CR>
	nmap <silent> N :call SearchPrev()<CR>
"snippets
	call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
		\ 'name': 'neosnippet',
		\ 'whitelist': ['*'],
		\ 'completor': function('asyncomplete#sources#neosnippet#completor'),
		\ 'priority': -1,
		\ }))
	let g:neosnippet#enable_completed_snippet=1
	imap <expr> <TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
	smap <expr> <TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"nerdcommenter
	let g:NERDCreateDefaultMappings=0
	let g:NERDDefaultAlign='left'
	let g:NERDCompactSexyComs=1
	nmap ; <plug>NERDCommenterToggle
	vmap ; <plug>NERDCommenterToggle
"auto-pairs
	let g:AutoPairsShortcutToggle = ''
	let g:AutoPairsShortcutFastWrap = ''
	let g:AutoPairsShortcutJump = ''
	let g:AutoPairsShortcutBackInsert = ''
	let g:AutoPairsMapCh=0
	inoremap < <><ESC>i
	inoremap << <<
"bufferline
	let g:bufferline_show_bufnr=0
	let g:bufferline_solo_highlight=0
	let g:bufferline_echo=0
	autocmd VimEnter * let &statusline='%{bufferline#refresh_status()}' .bufferline#get_status_string().'%<%=%r %m %f %-5.15(%l,%c-%v%) %p%%'
"Color
	colorscheme gruvbox
	set termguicolors
	set background=dark
	"取消gruvbox的背景颜色,使用term自带的背景颜色,以此来使用透明背景
	hi normal guibg=none ctermbg=none
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
