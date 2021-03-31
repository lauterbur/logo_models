breed [rabbits rabbit]
rabbits-own [speed
							angle
  						bridge-angle]
breed [bugs bug]
bugs-own [speed
					angle
  				bridge-angle]
breed [butterflies butterfly]
butterflies-own [speed
								 angle]
globals [bridge?]


to setup
  clear-all
  __change-topology FALSE FALSE
  ask patches [
  	set pcolor grey
    if (pxcor = 1 or pxcor = -1) [set pcolor yellow]
  	if (pxcor > 8 or pxcor < -8) [set pcolor green]
  if bridge 
  [
    if (pycor < 2 and pycor > -2 and pxcor > -10 and pxcor < 10) [set pcolor brown]
  ]
  ]
  ask n-of ( (51 * bridge_cover) / 100 ) patches with [pcolor = brown] [ set pcolor green ]
  
  ifelse Critter = "rabbit" 
  [ setupRabbits ]
  [ ifelse Critter = "bug"
    [ setupBugs ]
  	[ setupButterflies ]
  ]
  reset-ticks
end

to setupRabbits
  set-default-shape rabbits "rabbit"
  ask n-of 50 patches with [pxcor < -8] [
    sprout-rabbits 1 [
      set color orange
      set speed 1
      set angle 360
      set bridge-angle 10
      ]
  ]
    ask n-of 50 patches with [pxcor > 8] [
    sprout-rabbits 1 [
      set color violet 
      set speed 1
      set angle 360
      set bridge-angle 10
      ]
  ]
end

to setupBugs
  set-default-shape bugs "bug"
  ask n-of 50 patches with [pxcor < -8] [
    sprout-bugs 1 [
      set color orange
      set speed .5
      set angle 360
      set bridge-angle 10
    ]
  ]
    ask n-of 50 patches with [pxcor > 8] [
    sprout-bugs 1 [
      set color violet 
      set speed .5
      set angle 360
      set bridge-angle 10
		]
  ]
end
  
to setupButterflies
  set-default-shape butterflies "butterfly"
  ask n-of 50 patches with [pxcor < -8 and pxcor > -19] [
    sprout-butterflies 1 [
      set color orange
      set speed 1
      set angle 360
    ]
  ]
  ask n-of 50 patches with [pxcor > 8 and pxcor < 19] [
    sprout-butterflies 1 [
      set color violet 
      set speed 1
      set angle 360
		]
  ]
end

to go
  ask rabbits
  [ move ]
  ask bugs
  [ move ]
  ask butterflies
  [ move ]
  tick
end

to move  ;; rabbit procedure

  if not can-move? 1 [ rt angle / 2 ]

	ifelse Critter = "butterfly"
    [ rt random-float angle
      lt random-float angle
      fd speed
    ]
    [ ifelse [pcolor] of patch-ahead 1 = grey
 			[ lt random-float angle ]
      [ ifelse [pycor] of patch-ahead 1 < 2 and [pycor] of patch-ahead 1 > -2 and [pxcor] of patch-ahead 1 > -9 and [pxcor] of patch-ahead 1 < 9 
         [
           rt random bridge-angle
  	       lt random bridge-angle
    	     fd speed * (bridge_cover / 100)
   			 ]
      	 [ 
           rt random 10
  				 lt random 10
      		 fd speed
         ]
       ]
 		 ]

end

to sample-left
  ask n-of 5 turtles with [pxcor < -8]  [ set color orange ]
  let x_list (list 1 2 3 4 5)
  foreach x_list [
    [x] ->
    output-print "left side"
    ;;[x] ->
    sample-sats-left x
  ]
end

to sample-sats-left [x]
  let Hsat1 one-of ["H243" "H236"]
  let Xsat1 one-of ["X122" "X130"]
  let Ksat1 one-of ["K85" "K94"]
  let Ysat1 one-of ["Y401" "Y392"]
  let Asat1 one-of ["A324" "A319"]
  let Hsat2 one-of ["H243" "H236"]
  let Xsat2 one-of ["X122" "X130"]
  let Ksat2 one-of ["K85" "K94"]
  let Ysat2 one-of ["Y401" "Y392"]
  let Asat2 one-of ["A324" "A319"]
  output-type x output-type ": " 
  output-type Hsat1 output-type "/" output-type Hsat2 output-type " " 
  output-type Xsat1 output-type "/" output-type Xsat2 output-type " " 
  output-type Ksat1 output-type "/" output-type Ksat2 output-type " " 
  output-type Ysat1 output-type "/" output-type Ysat2 output-type " " 
  output-type Asat1 output-type "/" output-type Asat2
end

to sample-right
  ask n-of 5 turtles with [pxcor < -8]  [ set color violet ]
  let x_list (list 1 2 3 4 5)
  foreach x_list [
    [x] ->
    output-print "right side"
    ;;[x] ->
    sample-sats-right x
  ]
end

to sample-sats-right [x]
  let Hsat1 one-of ["H251" "H236"]
  let Xsat1 one-of ["X122" "X133"]
  let Ksat1 one-of ["K85" "K94"]
  let Ysat1 one-of ["Y408" "Y392"]
  let Asat1 one-of ["A324" "A319"]
  let Hsat2 one-of ["H251" "H236"]
  let Xsat2 one-of ["X122" "X133"]
  let Ksat2 one-of ["K85" "K94"]
  let Ysat2 one-of ["Y408" "Y392"]
  let Asat2 one-of ["A324" "A319"]
  output-type x output-type ": " 
  output-type Hsat1 output-type "/" output-type Hsat2 output-type " " 
  output-type Xsat1 output-type "/" output-type Xsat2 output-type " " 
  output-type Ksat1 output-type "/" output-type Ksat2 output-type " " 
  output-type Ysat1 output-type "/" output-type Ysat2 output-type " " 
  output-type Asat1 output-type "/" output-type Asat2
end
  