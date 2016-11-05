" Vim syntax file
" Language:     Metafont
" Maintainer:   Lifepillar <lifepillar@lifepillar.me>
" Last Change:  September 18, 2016

" quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Metafont 'primitives' as defined in chapter 25 of 'The METAFONTbook'
" Page 210: 'boolean expressions'
syn keyword mfBoolExp and charexists false known not odd or true unknown

" Page 210: 'numeric expression'
syn keyword mfNumExp ASCII angle cosd directiontime floor hex length mexp
syn keyword mfNumExp mlog normaldeviate oct sind sqrt totalweight
syn keyword mfNumExp turningnumber uniformdeviate xpart xxpart xypart ypart
syn keyword mfNumExp yxpart yypart

" Page 211: 'internal quantities'
syn keyword mfInternal autorounding boundarychar charcode chardp chardx chardy
syn keyword mfInternal charext charht charic charwd day designsize fillin
syn keyword mfInternal fontmaking granularity hppp jobname month pausing proofing
syn keyword mfInternal showstopping smoothing time tracingcapsules
syn keyword mfInternal tracingchoices tracingcommands tracingedges
syn keyword mfInternal tracingequations tracingmacros tracingonline
syn keyword mfInternal tracingoutput tracingpens tracingrestores tracingspecs
syn keyword mfInternal tracingstats tracingtitles turningcheck vppp
syn keyword mfInternal warningcheck xoffset year yoffset

" Page 212: 'pair expressions'
syn keyword mfPairExp of penoffset point postcontrol precontrol rotated
syn keyword mfPairExp scaled shifted slanted transformed xscaled yscaled
syn keyword mfPairExp zscaled

" Page 213: 'path expressions'
syn keyword mfPathExp atleast controls curl cycle makepath reverse subpath
syn keyword mfPathExp tension

" Page 214: 'pen expressions'
syn keyword mfPenExp makepen nullpen pencircle

" Page 214: 'picture expressions'
syn keyword mfPicExp nullpicture

" Page 214: 'string expressions'
syn keyword mfStringExp char decimal readstring str substring

" Page 217: 'commands and statements'
syn keyword mfCommand addto also at batchmode contour cull delimiters display
syn keyword mfCommand doublepath dropping dump end errhelp errmessage
syn keyword mfCommand errorstopmode everyjob from interim inwindow keeping
syn keyword mfCommand let message newinternal nonstopmode numspecial
syn keyword mfCommand openwindow outer randomseed save scrollmode shipout
syn keyword mfCommand show showdependencies showstats showtoken showvariable
syn keyword mfCommand special to withpen withweight

" Page 56: 'types'
syn keyword mfType boolean numeric pair path pen picture string transform

" Page 155: 'grouping'
syn keyword mfStatement begingroup endgroup

" Page 165: 'definitions'
syn keyword mfDefinition def enddef expr primary primarydef secondary
syn keyword mfDefinition secondarydef suffix tertiary tertiarydef text vardef

" Page 169: 'conditions and loops'
syn keyword mfCondition else elseif endfor exitif fi for forever forsuffixes if
syn keyword mfCondition step until

" Other primitives listed in the index
syn keyword mfPrimitive charlist endinput expandafter extensible fontdimen
syn keyword mfPrimitive headerbyte inner input intersectiontimes kern ligtable
syn keyword mfPrimitive quote scantokens skipto

" Implicit suffix parameters
syn match mfSuffixParam "@#\|#@\|@"

" Keywords defined by plain.mf (defined on pp.262-278)
if get(g:, "plain_mf_macros", v:true) " Set to v:false if your source gets too colourful
  syn keyword mfDef addto_currentpicture beginchar capsule_def change_width
  syn keyword mfDef clear_pen_memory clearit clearpen clearxy culldraw
  syn keyword mfDef cullit cutdraw define_blacker_pixels
  syn keyword mfDef define_corrected_pixels define_good_x_pixels
  syn keyword mfDef define_good_y_pixels define_horizontal_corrected_pixels
  syn keyword mfDef define_pixels define_whole_blacker_pixels
  syn keyword mfDef define_whole_pixels
  syn keyword mfDef define_whole_vertical_blacker_pixels
  syn keyword mfDef define_whole_vertical_pixels downto draw drawdot
  syn keyword mfDef endchar erase exitunless fill filldraw fix_units flex
  syn keyword mfDef font_coding_scheme font_extra_space font_identifier
  syn keyword mfDef font_normal_shrink font_normal_space
  syn keyword mfDef font_normal_stretch font_quad font_size font_slant
  syn keyword mfDef font_x_height gfcorners gobble hide imagerules interact
  syn keyword mfDef italcorr killtext loggingall lowres_fix makebox
  syn keyword mfDef makegrid maketicks mode_def mode_setup nodisplays
  syn keyword mfDef notransforms numtok openit penrazor pensquare penstroke
  syn keyword mfDef pickup proofoffset proofrule range reflectedabout
  syn keyword mfDef rotatedaround screenchars screenrule screenstrokes
  syn keyword mfDef shipit showit smode stop superellipse takepower
  syn keyword mfDef tracingall tracingnone undraw undrawdot unfill
  syn keyword mfDef unfilldraw upto
  syn match   mfDef "???"
  syn keyword mfVardef bot byte ceiling counterclockwise cutoff decr dir
  syn keyword mfVardef direction directionpoint grayfont hround incr
  syn keyword mfVardef interpath inverse labelfont labels lft magstep
  syn keyword mfVardef makelabel max min penlabels penpos proofrulethickness
  syn keyword mfVardef round rt savepen slantfont solve tensepath titlefont
  syn keyword mfVardef top unitvector vround whatever
  syn match   mpVardef "\<good\.\%(x\|y\|lft\|rt\|top\|bot\)\>"
  syn keyword mfPrimaryDef div dotprod gobbled mod
  syn keyword mfSecondaryDef intersectionpoint
  syn keyword mfTertiaryDef softjoin thru
  syn keyword mfNewInternal blacker currentwindow displaying eps epsilon infinity
  syn keyword mfNewInternal join_radius number_of_modes o_correction pen_bot
  syn keyword mfNewInternal pen_lft pen_rt pen_top pixels_per_inch screen_cols
  syn keyword mfNewInternal screen_rows tolerance
  " Predefined constants
  syn keyword mfConstant base_name base_version blankpicture ditto down
  syn keyword mfConstant fullcircle halfcircle identity left lowres origin
  syn keyword mfConstant penspeck proof quartercircle right rulepen smoke
  syn keyword mfConstant unitpixel unitsquare up
  " Other predefined variables
  syn keyword mfVariable aspect_ratio currentpen extra_beginchar extra_endchar
  syn keyword mfVariable currentpen_path currentpicture currenttransform
  syn keyword mfVariable d extra_setup h localfont mag mode mode_name w
  " let statements:
  syn keyword mfnumExp abs
  syn keyword mfPairExp rotatedabout
  syn keyword mfCommand bye relax
endif

" The default MetaFont format loads modes.mf, too
if get(g:, "plain_mf_modes", v:true) " Set to v:false if your code gets too colourful
  syn keyword mfConstant APSSixMed AgfaFourZeroZero AgfaThreeFourZeroZero
  syn keyword mfConstant AtariNineFive AtariNineSix AtariSLMEightZeroFour
  syn keyword mfConstant AtariSMOneTwoFour CItohEightFiveOneZero
  syn keyword mfConstant CItohThreeOneZero CanonBJCSixZeroZero CanonCX CanonEX
  syn keyword mfConstant CanonLBPLX CanonLBPTen CanonSX ChelgraphIBX
  syn keyword mfConstant CompugraphicEightSixZeroZero
  syn keyword mfConstant CompugraphicNineSixZeroZero DD DEClarge DECsmall
  syn keyword mfConstant DataDiscNew EightThree EpsonAction
  syn keyword mfConstant EpsonLQFiveZeroZeroLo EpsonLQFiveZeroZeroMed EpsonMXFX
  syn keyword mfConstant EpsonSQEightSevenZero EpsonStylusPro EpsonStylusProHigh
  syn keyword mfConstant EpsonStylusProLow EpsonStylusProMed FourFour GThreefax
  syn keyword mfConstant HPDeskJet HPLaserJetIIISi IBMFourTwoFiveZero
  syn keyword mfConstant IBMFourTwoOneSix IBMFourTwoThreeZero IBMFourZeroOneNine
  syn keyword mfConstant IBMFourZeroThreeNine IBMFourZeroTwoNine IBMProPrinter
  syn keyword mfConstant IBMSixOneFiveFour IBMSixSixSevenZero
  syn keyword mfConstant IBMThreeEightOneTwo IBMThreeEightTwoZero
  syn keyword mfConstant IBMThreeOneNineThree IBMThreeOneSevenNine
  syn keyword mfConstant IBMUlfHolleberg LASevenFive LNOthreR LNOthree LNZeroOne
  syn keyword mfConstant LNZeroThree LPSFourZero LPSTwoZero
  syn keyword mfConstant LexmarkFourZeroThreeNine LexmarkOptraR LexmarkOptraS
  syn keyword mfConstant LinotypeLThreeThreeZero LinotypeOneZeroZero
  syn keyword mfConstant LinotypeOneZeroZeroLo LinotypeThreeZeroZeroHi
  syn keyword mfConstant MacTrueSize NeXTprinter NeXTscreen NecTwoZeroOne Newgen
  syn keyword mfConstant NineOne OCESixSevenFiveZeroPS OneTwoZero OneZeroZero
  syn keyword mfConstant PrintwareSevenTwoZeroIQ Prism QMSOneSevenTwoFive
  syn keyword mfConstant QMSOneSevenZeroZero QMSTwoFourTwoFive RicohA
  syn keyword mfConstant RicohFortyEighty RicohFourZeroEightZero RicohLP
  syn keyword mfConstant SparcPrinter StarNLOneZero VAXstation VTSix
  syn keyword mfConstant VarityperFiveZeroSixZeroW VarityperFourThreeZeroZeroHi
  syn keyword mfConstant VarityperFourThreeZeroZeroLo VarityperFourTwoZeroZero
  syn keyword mfConstant VarityperSixZeroZero XeroxDocutech
  syn keyword mfConstant XeroxEightSevenNineZero XeroxFourZeroFiveZero
  syn keyword mfConstant XeroxNineSevenZeroZero XeroxPhaserSixTwoZeroZeroDP
  syn keyword mfConstant XeroxThreeSevenZeroZero Xerox_world agfafzz agfatfzz
  syn keyword mfConstant amiga aps apssixhi aselect atariezf atarinf atarins
  syn keyword mfConstant atariotf bitgraph bjtenex bjtzzex bjtzzl bjtzzs boise
  syn keyword mfConstant canonbjc canonex canonlbp cg cgl cgnszz citohtoz corona
  syn keyword mfConstant crs cthreeten cx datadisc declarge decsmall deskjet
  syn keyword mfConstant docutech dover dp dpdfezzz eighthre elvira epscszz
  syn keyword mfConstant epsdraft epsdrft epsdrftl epsfast epsfastl epshi epslo
  syn keyword mfConstant epsmed epsmedl epson epsonact epsonfx epsonl epsonlo
  syn keyword mfConstant epsonlol epsonlq epsonsq epstylus epstylwr epstyplo
  syn keyword mfConstant epstypmd epstypml epstypro epswlo epswlol esphi
  syn keyword mfConstant fourfour gpx gtfax gtfaxhi gtfaxl gtfaxlo gtfaxlol help
  syn keyword mfConstant hifax highfax hplaser hprugged ibm_a ibmd ibmega
  syn keyword mfConstant ibmegal ibmfzon ibmfztn ibmpp ibmppl ibmsoff ibmteot
  syn keyword mfConstant ibmtetz ibmtont ibmtosn ibmtosnl ibmvga ibx imagen
  syn keyword mfConstant imagewriter itoh itohl itohtoz itohtozl iw jetiiisi
  syn keyword mfConstant kyocera laserjet laserjetfive laserjetfivemp
  syn keyword mfConstant laserjetfour laserjetfourthousand
  syn keyword mfConstant laserjetfourzerozerozero laserjethi laserjetlo
  syn keyword mfConstant laserjettwoonezerozero laserjettwoonezerozerofastres
  syn keyword mfConstant lasermaster laserwriter lasf lexmarkr lexmarks lexmarku
  syn keyword mfConstant linohalf linohi linolo linolttz linoone linosuper
  syn keyword mfConstant linothree linothreelo linotzzh ljfive ljfivemp ljfour
  syn keyword mfConstant ljfzzz ljfzzzfr ljlo ljtozz ljtozzfr lmaster lnotr lnzo
  syn keyword mfConstant lps lpstz lqhires lqlores lqmed lqmedl lqmedres lview
  syn keyword mfConstant lviewl lwpro macmag mactrue modes_mf ncd nec nechi
  syn keyword mfConstant neclm nectzo newdd newddl nexthi nextscreen nextscrn
  syn keyword mfConstant nineone nullmode ocessfz okidata okidatal okifourten
  syn keyword mfConstant okifte okihi onetz onezz pcprevw pcscreen phaser
  syn keyword mfConstant phaserfs phasertf phasertfl phasertl pixpt printware
  syn keyword mfConstant prntware proprinter qms qmsesz qmsostf qmsoszz qmstftf
  syn keyword mfConstant ricoh ricoha ricohlp ricohsp sherpa sparcptr starnlt
  syn keyword mfConstant starnltl styletwo stylewr stylewri stylewriter sun
  syn keyword mfConstant supre swtwo toshiba ultre varityper vs vtftzz vtftzzhi
  syn keyword mfConstant vtftzzlo vtfzszw vtszz xpstzz xpstzzl xrxesnz xrxfzfz
  syn keyword mfConstant xrxnszz xrxtszz
  syn keyword mfDef BCPL_string coding_scheme font_face_byte font_family landscape
  syn keyword mfDef mode_extra_info mode_help mode_param
  syn keyword mfNewInternal blacker_min
endif

" Some other basic macro names, e.g., from cmbase, logo, etc.
if get(g:, "other_mf_macros", v:true) " Set to v:false if your code gets too colourful
  syn keyword mfDef beginlogochar
  syn keyword mfDef font_setup
  syn keyword mfPrimitive generate
endif

" Numeric tokens
syn match mfNumeric     "[-]\=\d\+"
syn match mfNumeric     "[-]\=\.\d\+"
syn match mfNumeric     "[-]\=\d\+\.\d\+"

" Metafont lengths
syn match mfLength      "\<\(bp\|cc\|cm\|dd\|in\|mm\|pc\|pt\)\>"
syn match mfLength      "[-]\=\d\+\(bp\|cc\|cm\|dd\|in\|mm\|pc\|pt\)\#\="
syn match mfLength      "[-]\=\.\d\+\(bp\|cc\|cm\|dd\|in\|mm\|pc\|pt\)\#\="
syn match mfLength      "[-]\=\d\+\.\d\+\(bp\|cc\|cm\|dd\|in\|mm\|pc\|pt\)\#\="

" Metafont coordinates and points
syn match mfCoord       "\<[xy]\d\+\>"
syn match mfPoint       "\<z\d\+\>"

" String constants
syn region mfString	start=+"+ end=+"+

" Comments:
syn match mfComment     "%.*$"

" synchronizing
syn sync maxlines=50

" Define the default highlighting
" Only when an item doesn't have highlighting yet

hi def link mfBoolExp      Statement
hi def link mfNumExp       Statement
hi def link mfPairExp      Statement
hi def link mfPathExp      Statement
hi def link mfPenExp       Statement
hi def link mfPicExp       Statement
hi def link mfStringExp    Statement
hi def link mfInternal     Identifier
hi def link mfCommand      Statement
hi def link mfType         Type
hi def link mfStatement    Statement
hi def link mfDefinition   Statement
hi def link mfCondition    Conditional
hi def link mfPrimitive    Statement
hi def link mfDef          Function
hi def link mfVardef       mfDef
hi def link mfPrimaryDef   mfDef
hi def link mfSecondaryDef mfDef
hi def link mfTertiaryDef  mfDef
hi def link mfCoord        Identifier
hi def link mfPoint        Identifier
hi def link mfNumeric      Number
hi def link mfLength       Number
hi def link mfComment      Comment
hi def link mfString       String
hi def link mfSuffixParam  Label
hi def link mfNewInternal  mfInternal
hi def link mfVariable     Identifier
hi def link mfConstant     Constant


let b:current_syntax = "mf"

" vim: ts=8
