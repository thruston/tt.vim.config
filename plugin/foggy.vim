" A macro to generate random pseudo-text - use:  foggy [n] | [?] 
"                                                                
" Ported from FOGGY.ERX, an EPM macro                          
"                                                                
" In theory, initiation of critical subsystem development adds   
" explicit performance limits to the most recent level of        
" hardware.                                                      
"                                                                
" Specifically, the incorporation of additional mission          
" constraints maximizes the probability of project success, yet  
" minimizes cost and time required for the total system          
" rationale.                                                     
"
command! -nargs=? Foggy call Foggy(<args>)

" List of LEADINS, all of which mean nothing but buy time 
let s:leads = [ 'In particular,', 'On the other hand,', 'However,', 'Similarly,', 'As a resultant implication,',
	      \ 'In this regard,', 'Based on integral subsystem considerations,', 'For example,', 'Thus,',
	      \ 'In respect to specific goals,', 'Interestingly enough,', 'Without going into the technical details,',
              \ 'Of course,', 'To approach true user-friendliness,', 'In theory,', 'It is assumed that', 'Conversely,',
	      \ 'We can see, in retrospect,', 'It is further assumed that', 'Further,', 'In summary,', 'It should be noted that',
	      \ 'To further describe and annotate,', 'Specifically,']

" List of SUBJECT clauses chosen for no redeeming value whatsoever 
let s:subjs = [ 'a large portion of interface coordination communication',
	       \ 'a constant flow of effective communication',
	       \ 'the characterization of specific criteria', 
	       \ 'initiation of critical subsystem development',
	       \ 'the fully integrated test program',
	       \ 'the product configuration baseline',
	       \ 'any associated supporting element',
	       \ 'the incorporation of additional mission constraints',
               \ 'the independent functional principle',
	       \ 'the interrelation of system and/or subsystem technologies',
	       \ 'the product assurance architecture',
	       \ 'a service-oriented paradigm',
	       \ 'a parameterized product configuration matrix' ]

" List of VERB clauses chosen for auto-recursive obfuscation 

let s:verbs = [ 'must utilize and be functionally interwoven with',
	    \ 'maximizes the probability of project success, yet minimizes cost and time required for',
	    \ 'adds explicit performance limits to',
	    \ 'necessitates that urgent consideration be applied to',
	    \ 'requires considerable systems analysis and trade-off studies to arrive at',
	    \ 'is further compounded when taking into account',
	    \ 'presents extremely interesting challenges to',
	    \ 'recognizes other systems'' importance and the necessity for',
	    \ 'affects a significant implementation of',
	    \ 'adds overriding performance constraints to',
	    \ 'mandates staff-meeting-level attention to',
	    \ 'is functionally equivalent and parallel to' ]

" List of OBJECT clauses selected for profound meaninglessness 
let s:objes = [ 'the most recent level of hardware.  ',
	     \ 'the anticipated fourth-generation equipment.  ',
	     \ 'the subsystem compatibility testing.  ',
	     \ 'the structural design, based on system engineering concepts.  ',
	     \ 'the preliminary qualification limit.  ',
	     \ 'the evolution of specifications over a given time period.  ',
	     \ 'the philosophy of commonality and standardization.  ',
	     \ 'the greater fight-worthiness concept.  ',
	     \ 'any discrete configuration mode.  ',
	     \ 'the management-by-contention principle.  ',
	     \ 'the total system rationale.  ',
	     \ 'possible bidirectional logical relationship approaches.  ',
	     \ 'the postulated use of dialog management technology.  ',
	     \ 'the overall negative profitability.  ']

let s:help_text = "FOGGY is an interactive productivity tool designed to assist"
	    \ . "in the composition of monthly reports, project plans, memos to"
	    \ . "management and so forth.  If entered without parameters,"
	    \ . "FOGGY generates as output a high-fog-index sentence suitable for"
	    \ . "befuddling even the most determined seeker-after-content.  If you"
	    \ . "need vast amounts of FOGGY for really serious tush-covering, enter"
	    \ . "the number of sentences needed as a parameter.  For example,"
	    \ . "entering 'FOGGY 5' outputs half a screen of heat-treated, battle-"
	    \ . "hard, industrial-strength slop, well suited to choking hogs and"
	    \ . "assurance planners. "
	    \ . ""
	    \ . "REMEMBER:"
	    \ . "FOGGY can be a terrible weapon -- never abuse it."

function! Foggy(...)
    if a:0 == 0
	let l:n = 1
    else 
	let l:n = a:1
    endif

    let l:done = 0 
    while l:done < l:n
	let l:rc = append(line("."),Get_random_sentence())
	let l:done += 1
    endwhile	
    normal gqap
endfunction

function! Get_random_sentence()
    return  s:leads[Urndm(0,len(s:leads)-1)] . " "
	\ . s:subjs[Urndm(0,len(s:subjs)-1)] . " "
	\ . s:verbs[Urndm(0,len(s:verbs)-1)] . " "
	\ . s:objes[Urndm(0,len(s:objes)-1)]
endfunction    

