" 使用するコマンドの定義
let g:c_previewer_toolchain = get(g:, 'c_previewer_toolchain', '')
let g:c_previewer_gcc = get(g:, 'c_previewer_gcc', g:c_previewer_toolchain . 'gcc')
let g:c_previewer_objdump = get(g:, 'c_previewer_objdump', g:c_previewer_toolchain . 'objdump')
let g:c_previewer_cpp = get(g:, g:c_previewer_toolchain . 'c_previewer_cpp', 'cpp')
let g:c_previewer_hexdump = 'hexdump'
let g:c_previewer_nm = 'nm'
let g:c_previewer_cflags = get(g:, 'c_previewer_cflags', '')

" ウィンドウを分割し、アセンブラソースコードを表示する
function! c_previewer#OpenAssembleBuffer()
    let source = fnamemodify(expand("%"), ":p")
    let tempfile_assemble = tempname()
    silent execute "!" . g:c_previewer_gcc . " -S " . g:c_previewer_cflags . " -o " . tempfile_assemble . " " . source
    execute "split " . tempfile_assemble

    call c_previewer#SetBufferOption_ro()
endfunction

" ウィンドウを分割し、ヘッダー一覧を表示する
function! c_previewer#OpenHeadersBuffer()
    let source = fnamemodify(expand("%"), ":p")
    let tempfile_object = tempname()
    let tempfile_headers = tempname()
    execute "split " . tempfile_headers
    call c_previewer#SetBufferOption_edit()
    silent execute "!" . g:c_previewer_gcc . " -c " . g:c_previewer_cflags . " -o " . tempfile_object . " " . source
    silent execute "read !" . g:c_previewer_objdump . " --all-headers " . tempfile_object

    call c_previewer#SetBufferOption_ro()
endfunction

" ウィンドウを分割し、シンボル一覧を表示する
function! c_previewer#OpenSymbolsBuffer()
    let source = fnamemodify(expand("%"), ":p")
    let tempfile_object = tempname()
    let tempfile_symbols = tempname()
    execute "split " . tempfile_symbols
    call c_previewer#SetBufferOption_edit()
    silent execute "!" . g:c_previewer_gcc . " -c " . g:c_previewer_cflags . " -o " . tempfile_object . " " . source
    silent execute "read !" . g:c_previewer_nm . " " . tempfile_object

    call c_previewer#SetBufferOption_ro()
endfunction

" ウィンドウを分割し、オブジェクトダンプを表示する
function! c_previewer#OpenHexBuffer()
    let source = fnamemodify(expand("%"), ":p")
    let tempfile_object = tempname()
    let tempfile_hex = tempname()
    execute "split " . tempfile_hex
    call c_previewer#SetBufferOption_edit()

    silent execute "!" . g:c_previewer_gcc . " -c " . g:c_previewer_cflags . " -o " . tempfile_object . " " . source
    silent execute "read !" . g:c_previewer_hexdump . " " . tempfile_object

    call c_previewer#SetBufferOption_ro()
endfunction

" ウィンドウを分割し、マクロ展開後ソースコードを表示する
function! c_previewer#OpenPreprocessBuffer()
    let source = fnamemodify(expand("%"), ":p")
    let tempfile_cpp = tempname()
    silent execute "!" . g:c_previewer_cpp . " " . g:c_previewer_cflags . " -o " . tempfile_cpp . " " . source
    execute "split " . tempfile_cpp

    call c_previewer#SetBufferOption_ro()
    set filetype=c
endfunction

" バッファをリードオンリーにする
function! c_previewer#SetBufferOption_ro()
    setlocal noshowcmd
    setlocal noswapfile
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nobuflisted
    setlocal nomodifiable
    setlocal nowrap
    setlocal nonumber
endfunction

" バッファを編集可能にする
function! c_previewer#SetBufferOption_edit()
    setlocal modifiable
endfunction

