" A pop up calculator 
" Toby Thurston -- 07 Apr 2010 
"
command! -nargs=0 Rpn call Popup_Calculator()

let s:stack = [] 
let s:prompt = ""
let s:eparator = "----------------------\n"
let s:keep_going = 1
function! Popup_Calculator()
    while s:keep_going
        redraw!
        let s:prompt = s:eparator . join(s:stack,"\n")."\nRPN: "
        let s:expr = input(s:prompt)
        if s:expr == ""
            call add(s:stack, s:stack[-1])
        else
            for s:w in s:Space_out(s:expr)
                if s:w == "pop"
                    let s:stack =  s:stack[:-2]
                elseif s:w == "quit"
                    let s:keep_going = 0 
                    break
                elseif s:w =~ '^=\+$'
                    execute "normal I" . string(s:stack[-1]) . "\<Esc>" 
                    let s:keep_going = 0 
                    break
                elseif s:w == "dup"
                    call add(s:stack, s:stack[-1])
                elseif s:w == "over"
                    call add(s:stack, s:stack[-2])
                elseif s:w == "dupp"
                    call add(s:stack, s:stack[-2:-1])
                elseif s:w == "+"
                    let s:stack[-2] = s:stack[-2]+s:stack[-1]
                    let s:stack = s:stack[:-2]
                elseif s:w == "-"
                    let s:stack[-2] = s:stack[-2]-s:stack[-1]
                    let s:stack = s:stack[:-2]
                elseif s:w == "*"
                    let s:stack[-2] = s:stack[-2]*s:stack[-1]
                    let s:stack = s:stack[:-2]
                elseif s:w == "/"
                    let s:stack[-2] = s:stack[-2]/s:stack[-1]
                    let s:stack = s:stack[:-2]
                elseif s:w == "pow"   
                    let s:stack[-2] = pow(s:stack[-2],s:stack[-1])
                    let s:stack = s:stack[:-2]
                elseif s:w == "**"   
                    let s:stack[-2] = pow(s:stack[-2],s:stack[-1])
                    let s:stack = s:stack[:-2]
                elseif s:w == "sqrt"
                    let s:stack[-1] = sqrt(s:stack[-1])
                elseif s:w == "v"
                    let s:stack[-1] = 1/s:stack[-1]
                elseif s:w == "c"
                    let s:stack[-1] = -s:stack[-1]
                elseif s:w == "x"
                    let s:temp = s:stack[-2]
                    let s:stack[-2]=s:stack[-1]
                    let s:stack[-1]=s:temp
                elseif s:w == "abs"   
                    let s:stack[-1] =   abs(s:stack[-1])
                elseif s:w == "ceil"  
                    let s:stack[-1] =  ceil(s:stack[-1])
                elseif s:w == "floor" 
                    let s:stack[-1] = floor(s:stack[-1])
                elseif s:w == "trunc" 
                    let s:stack[-1] = trunc(s:stack[-1])
                elseif s:w == "sin"   
                    let s:stack[-1] =   sin(s:stack[-1])
                elseif s:w == "cos"   
                    let s:stack[-1] =   cos(s:stack[-1])
                elseif s:w == "atan"  
                    let s:stack[-1] =  atan(s:stack[-1])
                else
                    call add(s:stack, str2float(s:w))
                endif
            endfor
        endif
    endwhile        

endfunction

function! s:Space_out(string)
    let s:out = []
    for s:w in split(substitute(a:string, '\(\d\)\([-+*/%!=":]\)','\1 \2', ""))
        call add(s:out, s:w)
    endfor
    return s:out
endfunction


