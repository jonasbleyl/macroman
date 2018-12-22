" Description: Macroman - manage your vim macros
" Author: Jonas Bleyl

if exists("g:loaded_macroman") || &cp || v:version < 700
  finish
endif
let g:loaded_macroman = 1

let s:register = get(g:, "macroman_register", "q")
let s:path = expand("~/.vim-macroman")

if !isdirectory(s:path)
  call mkdir(s:path)
endif

command! -nargs=1 MacroSave call macroman#save(<f-args>)
command! -nargs=0 -range MacroList call macroman#list(<line1>, <line2>)

function! macroman#save(name)
  let path = s:path . "/" . a:name
  let contents = getreg(s:register)
  call writefile([contents], path, "b")
  echo "Macro saved"
endfunction

function! macroman#list(line1, line2)
  let s:multiline = a:line1 != a:line2
  silent belowright new
  call s:show_macros()
  call s:init_buffer()

  nnoremap <silent> <buffer> q :quit!<cr>
  nnoremap <silent> <buffer> <cr> :call macroman#select()<cr>
  nnoremap <silent> <buffer> dd :call macroman#delete()<cr>
endfunction

function! macroman#select()
  let reg_save = @q
  execute "let @q = s:macros[line('.') - 1].content"
  quit!
  call s:run_macro()
  let @q = reg_save
endfunction

function! macroman#delete()
  let path = s:path . "/" . s:macros[line(".") - 1].name
  call delete(expand(path))
  setlocal modifiable
  normal! dd
  call s:init_buffer()
  echo "Macro deleted"
endfunction

function! s:run_macro()
  if s:multiline
    '<,'>normal! @q
  else
    normal! @q
  endif
endfunction

function! s:show_macros()
  let files = split(globpath(s:path, "*"), "\n")
  let s:macros = []
  let index = 1

  for file in files
    let name = fnamemodify(file, ":t")
    let content = readfile(file)[0]
    call add(s:macros, {"name": name, "content": content})
    call setline(index, s:pad(name, 30) . "➤  " . content)
    let index += 1
  endfor
  normal! gg
endfunction

function! s:init_buffer()
  resize 8
  setlocal nonumber
  setlocal norelativenumber
  setlocal noswapfile
  setlocal nomodifiable
  setlocal nomodified
  setlocal bufhidden=wipe
  setlocal statusline=%=%l/%-2L
endfunction


function! s:pad(text, amount)
  return a:text . repeat(" ", a:amount - len(a:text))
endfunction
