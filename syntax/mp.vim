" Vim syntax file
" Language:     MetaPost
" Maintainer:   Lifepillar <lifepillar@lifepillar.me>
" Last Change:  Setember 18, 2016

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

if exists("g:plain_mf_macros")
  let s:plain_mf_macros = g:plain_mf_macros
endif
if exists("g:plain_mf_modes")
  let s:plain_mf_modes = g:plain_mf_modes
endif
if exists("g:other_mf_macros")
  let s:other_mf_macros = g:other_mf_macros
endif

let g:plain_mf_macros = v:false " plain.mf has no special meaning for MetaPost
let g:plain_mf_modes  = v:false " No MetaFont modes
let g:other_mf_macros = v:false " cmbase.mf, logo.mf, ... neither

" Read the Metafont syntax to start with
runtime! syntax/mf.vim
unlet b:current_syntax " Necessary for syn include below

" Restore the value of existing global variables
if exists("s:plain_mf_macros")
  let g:plain_mf_macros = s:plain_mf_macros
else
  unlet g:plain_mf_macros
endif
if exists("s:plain_mf_modes")
  let g:plain_mf_modes = s:plain_mf_modes
else
  unlet g:plain_mf_modes
endif
if exists("s:other_mf_macros")
  let g:other_mf_macros = s:other_mf_macros
else
  unlet g:other_mf_macros
endif

" Use TeX highlighting inside verbatimtex/btex... etex
syn include @MPTeX syntax/tex.vim
" unlet b:current_syntax
syn region mpTeX matchgroup=mpTeXDelim start=/\<verbatimtex\>\|\<btex\>/ end=/\<etex\>/ contains=@MPTeX

" This must appear after the syn include above, because tex.vim sets `syn iskeyword`.
syn iskeyword @,48-57,_

" MetaPost primitives not found in Metafont
syn keyword mpBoolExp bounded clipped filled stroked textual
syn keyword mpNumExp arclength arctime blackpart bluepart colormodel cyanpart fontsize
syn keyword mpNumExp greenpart greypart magentapart redpart yellowpart
syn keyword mpPairExp llcorner lrcorner ulcorner urcorner
" envelope is seemingly undocumented, but it exists since mpost 1.003.
" The syntax is: envelope <polygonal pen> of <path primary>. For example,
"     path p;
"     p := envelope pensquare of (up--left);
" (Thanks to Daniel H. Luecking for the example!)
syn keyword mpPathExp envelope pathpart
syn keyword mpPenExp penpart
syn keyword mpPicExp dashpart glyph infont
syn keyword mpStringExp fontpart readfrom textpart
syn keyword mpType cmykcolor color rgbcolor
" Other MetaPost primitives listed in the manual
syn keyword mpPrimitive mpxbreak within
" Internal quantities not found in Metafont (Table 6 in MetaPost: A User's Manual)
syn keyword mpInternal defaultcolormodel hour minute linecap linejoin miterlimit mpprocset
syn keyword mpInternal mpversion numberprecision numbersystem outputfilename outputformat
syn keyword mpInternal outputformatoptions outputtemplate prologues
syn keyword mpInternal restoreclipcolor tracinglostchars troffmode truecorners
" List of commands not found in Metafont (from MetaPost: A User's Manual)
syn keyword mpCommand clip closefrom dashed filenametemplate fontmapfile
syn keyword mpCommand fontmapline setbounds withcmykcolor withcolor withgreyscale
syn keyword mpCommand withoutcolor withpostscript withprescript withrgbcolor write

" Metafont internal variables not found in MetaPost
syn keyword notDefined autorounding chardx chardy fillin granularity
syn keyword notDefined proofing smoothing tracingedges tracingpens
syn keyword notDefined turningcheck xoffset yoffset
" Other not implemented primitives (see MetaPost: A User's Manual, §C.1)
syn keyword notDefined cull display openwindow numspecial totalweight withweight

" Keywords defined by plain.mp
if get(g:, "plain_mp_macros", v:true) " Set to v:false if your source gets too colourful
  syn keyword mpDef beginfig clear_pen_memory clearit clearpen clearpen
  syn keyword mpDef clearxy colorpart cutdraw downto draw drawarrow
  syn keyword mpDef drawdblarrow drawdot drawoptions endfig erase
  syn keyword mpDef exitunless fill filldraw flex gobble hide interact
  syn keyword mpDef label loggingall makelabel numtok penstroke pickup
  syn keyword mpDef pickup range reflectedabout rotatedaround shipit
  syn keyword mpDef stop superellipse takepower tracingall tracingnone
  syn keyword mpDef undraw undrawdot unfill unfilldraw upto
  syn match   mpDef "???"
  syn keyword mpVardef arrowhead bbox bot buildcycle byte ceiling center
  syn keyword mpVardef counterclockwise decr dir direction
  syn keyword mpVardef directionpoint dotlabel dotlabels image incr interpath
  syn keyword mpVardef inverse labels lft magstep max min penlabels penpos round
  syn keyword mpVardef rt savepen solve tensepath thelabel top unitvector whatever
  syn keyword mpPrimaryDef div dotprod gobbled mod
  syn keyword mpSecondaryDef intersectionpoint
  syn keyword mpTertiaryDef cutafter cutbefore softjoin thru
  syn keyword mpNewInternal ahangle ahlength bboxmargin beveled butt defaultpen
  syn keyword mpNewInternal defaultscale dotlabeldiam eps epsilon infinity
  syn keyword mpNewInternal join_radius labeloffset mitered pen_bot pen_lft pen_rt
  syn keyword mpNewInternal pen_top rounded squared tolerance
  " Predefined constants
  syn keyword mpConstant EOF background base_name base_version black
  syn keyword mpConstant blankpicture blue ditto down evenly fullcircle green
  syn keyword mpConstant halfcircle identity left origin penrazor penspeck
  syn keyword mpConstant pensquare quartercircle red right unitsquare up white
  syn keyword mpConstant withdots
  " Other predefined variables
  syn keyword mpVariable currentpen currentpen_path currentpicture cuttings
  syn keyword mpVariable defaultfont extra_beginfig extra_endfig
  syn match   mpVariable /\<\%(laboff\|labxf\|labyf\)\>/
  syn match   mpVariable /\<\%(laboff\|labxf\|labyf\)\.\%(lft\|rt\|bot\|top\|ulft\|urt\|llft\|lrt\)\>/
  " let statements:
  syn keyword mpnumExp abs
  syn keyword mpDef rotatedabout
  syn keyword mpCommand bye relax
  " on and off are no technically keywords, but it is nice to highlight them
  " inside dashpattern().
  syn keyword mpOnOff off on contained
  syn region  mpDashPattern matchgroup=mpVardef start="dashpattern\s*" end=")"he=e-1 contains=mfNumeric,mfLength,mpOnOff
  hi def link mpOnOff mpPrimitive
endif

" Keywords defined by mfplain.mp
if get(g:, "mfplain_mp_macros", v:false) " Set to v:true to include these macro names
  syn keyword mpDef beginchar capsule_def change_width
  syn keyword mpDef define_blacker_pixels define_corrected_pixels
  syn keyword mpDef define_good_x_pixels define_good_y_pixels
  syn keyword mpDef define_horizontal_corrected_pixels
  syn keyword mpDef define_pixels
  syn keyword mpDef define_whole_blacker_pixels define_whole_pixels
  syn keyword mpDef define_whole_vertical_blacker_pixels
  syn keyword mpDef define_whole_vertical_pixels endchar
  syn keyword mpDef font_coding_scheme font_extra_space font_identifier
  syn keyword mpDef font_normal_shrink font_normal_space
  syn keyword mpDef font_normal_stretch font_quad font_size
  syn keyword mpDef font_slant font_x_height italcorr labelfont
  syn keyword mpDef lowres_fix makebox makegrid maketicks mode_def mode_setup
  syn keyword mpDef proofrule smode
  syn keyword mpVardef hround proofrulethickness vround
  syn keyword mpNewInternal blacker o_correction
  syn keyword mpVariable extra_beginchar extra_endchar extra_setup rulepen
  " plus some no-ops, also from mfplain.mp
  syn keyword mpDef cull cullit gfcorners imagerules nodisplays notransforms openit proofoffset screenchars screenrule
  syn keyword mpDef screenstrokes showit
  syn keyword mpVardef grayfont slantfont titlefont
  syn keyword mpVariable currenttransform
  syn keyword mpConstant unitpixel
  " These are not listed in the MetaPost manual, and some are ignored by MetaPost,
  " but are nonetheless defined in mfplain.mp
  syn keyword mpDef killtext
  syn match mpVardef "\<good\.\%(x\|y\|lft\|rt\|top\|bot\)\>"
  syn keyword mpVariable aspect_ratio localfont mag mode mode_name proofcolor
  syn keyword mpConstant lowres proof smoke
  syn keyword mpNewInternal autorounding bp_per_pixel granularity
  syn keyword mpNewInternal number_of_modes proofing smoothing
  syn keyword mpNewInternal turningcheck
endif

" Keywords defined by other macro packages, e.g., boxes.mp
if get(g:, "other_mp_macros", v:true) " Set to v:false if your source gets too colourful
  syn keyword mpDef boxjoin drawboxed drawboxes drawunboxed
  syn keyword mpNewInternal circmargin defaultdx defaultdy rbox_radius
  syn keyword mpVardef bpath boxit circleit generic_declare generic_redeclare
  syn keyword mpVardef generisize fixpos fixsize pic rboxit str_prefix
endif

" Define the default highlighting
" Only when an item doesn't have highlighting yet

hi def link mpTeXDelim     mpPrimitive
hi def link mpBoolExp      mfBoolExp
hi def link mpNumExp       mfNumExp
hi def link mpPairExp      mfPairExp
hi def link mpPathExp      mfPathExp
hi def link mpPenExp       mfPenExp
hi def link mpPicExp       mfPicExp
hi def link mpStringExp    mfStringExp
hi def link mpInternal     mfInternal
hi def link mpCommand      mfCommand
hi def link mpType         mfType
hi def link mpPrimitive    mfPrimitive
hi def link mpDef          mfDef
hi def link mpVardef       mpDef
hi def link mpPrimaryDef   mpDef
hi def link mpSecondaryDef mpDef
hi def link mpTertiaryDef  mpDef
hi def link mpNewInternal  mpInternal
hi def link mpVariable     mfVariable
hi def link mpConstant     mfConstant


let b:current_syntax = "mp"

" vim: ts=8
