if !exists('g:html2jade_loaded')
    let g:html2jade_loaded = 1
else
    finish
endif

if !exists('g:html2jade_use_split')
    let g:html2jade_use_split = 1
endif

if !exists('g:html2jade_split_cmd')
    let g:html2jade_split_cmd = 'vnew'
endif

function! s:Html2Jade(...)
    if !executable('html2jade')
        if executable('npm')
            exe '!npm install -g html2jade'
        else
            echoerr 'Please npm install -g html2jade first!'
            return
        endif
    endif

    if a:0 == 1
        let jade_file = a:1
    else
        let file = expand('%:p')
        let jade_file = fnamemodify(file, ':r').'.jade'
    endif

    if eval('g:html2jade_use_split')
        let cmd = eval('g:html2jade_split_cmd')
        exe cmd.' '.jade_file
    else
        exe 'edit '.jade_file
    endif

    normal Gdgg
    exe '0read '.file
    silent exe '%!html2jade'
endfunction

au filetype html,xhtml,xml command! -buffer -nargs=? Html2Jade call s:Html2Jade(<f-args>)
