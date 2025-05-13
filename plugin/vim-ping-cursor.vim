""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cursor Pinging
"
" This is a work around for the fact that the cursorcolumn setting makes
" moving the cursor to the left and the right horribly slow when using h and
" l. Instead this creates a function which can be bound to a key combo to
" basically make the cross-hair appear and for a short period of time and then
" disappear letting you get back to work
" http://briancarper.net/blog/590/cursorcolumn--cursorline-slowdown
" https://gist.github.com/pera/2624765
" http://vim.1045645.n5.nabble.com/Vim-7-slows-down-when-highlighting-cursor-line-td1148280.html
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !exists('g:ping_cursor_flash_milliseconds')
  let g:ping_cursor_flash_milliseconds = 250
endif

function! s:PingCursor()
  if exists('g:ping_cursor_color') && !empty(g:ping_cursor_color)
    " Save current CursorLine and CursorColumn attributes.
    let l:cur_cursorline = matchstr(execute('hi CursorLine'), 'term=.*')
    let l:cur_cursorcolumn = matchstr(execute('hi CursorColumn'), 'term=.*')
    " Change the color
    execute 'highlight CursorLine ctermbg=' . g:ping_cursor_color . ' guibg=' . g:ping_cursor_color
    execute 'highlight CursorColumn ctermbg=' . g:ping_cursor_color . ' guibg=' . g:ping_cursor_color
  endif

  set cursorline cursorcolumn
  redraw
  execute 'sleep' g:ping_cursor_flash_milliseconds . 'm'
  set nocursorline nocursorcolumn

  " Restore previous highlight attributes
  if exists('l:cur_cursorline') && !empty(l:cur_cursorline)
    execute 'highlight CursorLine ' . l:cur_cursorline
  endif
  if exists('l:cur_cursorcolumn') && !empty(l:cur_cursorcolumn)
    execute 'highlight CursorColumn ' . l:cur_cursorcolumn
  endif
endfunction



command PingCursor :call s:PingCursor()
