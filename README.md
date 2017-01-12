c_previewer.vim
===============

c のソースコードをコンパイルしたオブジェクト情報等、各種情報を表示するプラグインです。
表示できる情報は下記の通り。

- アセンブラ(gcc -S)
- ヘッダー一覧(objdump --all-headers)
- シンボル一覧(nm)
- オブジェクトダンプ(hexdump)
- マクロ展開後のソースコード(cpp)


Usage:
------

下記関数をお好みのキーにマッピングしてください。
ウィンドウを分割し、それぞれに応じた情報を表示します。

- ``c_previewer#OpenAssembleBuffer()`` : アセンブラ表示(gcc -S)
- ``c_previewer#OpenHeadersBuffer()`` : ヘッダー一覧(objdump --all-headers)
- ``c_previewer#OpenSymbolsBuffer()`` : シンボル一覧(nm)
- ``c_previewer#OpenHexBuffer()`` : オブジェクトダンプ(hexdump)
- ``c_previewer#OpenPreprocessBuffer()`` : マクロ展開後のソースコード(cpp)

デフォルトのツールチェイン以外を使用したい場合には、
下記グローバル変数を設定してください。

- ``g:c_previewer_toolchain`` : デフォルト空文字列
- ``g:c_previewer_gcc`` : デフォルトは `gcc`
- ``g:c_previewer_objdump`` : デフォルトは `objdump`
- ``g:c_previewer_cpp`` : デフォルトは `cpp`
- ``g:c_previewer_hexdump`` : デフォルトは `hexdump`
- ``g:c_previewer_nm`` : デフォルトは `nm`
- ``g:c_previewer_cflags`` : デフォルトは空文字列


設定例 :

```vim
let g:c_previewer_toolchain = 'aarch64-linux-gnu-'
let g:c_previewer_cflags = ' -I /PATH/TO/include '

command! Assenble c_previewer#OpenAssembleBuffer()
command! Headers c_previewer#OpenHeadersBuffer()
command! Symbols c_previewer#OpenSymbolsBuffer()
command! Hex c_previewer#OpenHexBuffer()
command! Cpp c_previewer#OpenPreprocessBuffer()
```


License:
--------

Copyright (C) 2017 mikoto2000

This software is released under the MIT License, see LICENSE

このソフトウェアは MIT ライセンスの下で公開されています。 LICENSE を参照してください。


Author:
-------

mikoto2000 <mikoto2000@gmail.com>
