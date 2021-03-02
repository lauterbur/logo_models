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
  if bridge
    [
      ask n-of ( (51 * bridge_cover) / 100 ) patches with [pcolor = brown] [ set pcolor green ]
  	]
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
  ask n-of 50 patches with [pxcor < -8 and pxcor > -19] [
    sprout-rabbits 1 [
      set color orange
      set speed 1
      set angle 360
      set bridge-angle 10
      ]
  ]
    ask n-of 50 patches with [pxcor > 8 and pxcor < 19] [
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
  output-print "left side"
  foreach x_list [
    [x] ->
    output-print ""
    ;;[x] ->
    sample-sats-left x
  ]
  output-print ""
  output-print ""
end

to sample-sats-left [x]
  let Hsat1 one-of ["H243" "H236"]
  let Xsat1 one-of ["X122" "X130"]
  let Ksat1 one-of ["K85" "K94"]
  let Ysat1 one-of ["Y401" "Y399"]
  let Asat1 one-of ["A324" "A319"]
  let Hsat2 one-of ["H243" "H236"]
  let Xsat2 one-of ["X122" "X130"]
  let Ksat2 one-of ["K85" "K94"]
  let Ysat2 one-of ["Y401" "Y399"]
  let Asat2 one-of ["A324" "A319"]
  output-type x output-type ": " 
  output-type Hsat1 output-type "/" output-type Hsat2 output-type " " 
  output-type Xsat1 output-type "/" output-type Xsat2 output-type " " 
  output-type Ksat1 output-type "/" output-type Ksat2 output-type " " 
  output-type Ysat1 output-type "/" output-type Ysat2 output-type " " 
  output-type Asat1 output-type "/" output-type Asat2
end

to sample-right
  ask n-of 5 turtles with [pxcor > 8]  [ set color violet ]
  let x_list (list 1 2 3 4 5)
  output-print "right side"
  foreach x_list [
    [x] ->
    output-print ""
    ;;[x] ->
    sample-sats-right x
  ]
  output-print ""
  output-print ""
end

to sample-sats-right [x]
  let Hsat1 one-of ["H251" "H236"]
  let Xsat1 one-of ["X125" "X133"]
  let Ksat1 one-of ["K85" "K94"]
  let Ysat1 one-of ["Y408" "Y392"]
  let Asat1 one-of ["A326" "A315"]
  let Hsat2 one-of ["H251" "H236"]
  let Xsat2 one-of ["X125" "X133"]
  let Ksat2 one-of ["K85" "K94"]
  let Ysat2 one-of ["Y408" "Y392"]
  let Asat2 one-of ["A326" "A315"]
  output-type x output-type ": " 
  output-type Hsat1 output-type "/" output-type Hsat2 output-type " " 
  output-type Xsat1 output-type "/" output-type Xsat2 output-type " " 
  output-type Ksat1 output-type "/" output-type Ksat2 output-type " " 
  output-type Ysat1 output-type "/" output-type Ysat2 output-type " " 
  output-type Asat1 output-type "/" output-type Asat2
end

@#$#@#$#@
GRAPHICS-WINDOW
296
13
788
505
-1
-1
12
1
10
1
1
1
0
0
0
1
-20
20
-20
20
1
1
1
ticks
30

BUTTON
25
102
140
165
setup
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
150
102
265
165
go
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

CHOOSER
76
10
216
55
Critter
critter
"rabbit" "bug" "butterfly"
1

BUTTON
90
174
200
227
hide home side
set color 1
NIL
1
T
TURTLE
NIL
NIL
NIL
NIL
0

SLIDER
107
62
287
95
bridge_cover
bridge_cover
0
100
50
10
1
% cover
HORIZONTAL

SWITCH
8
62
93
95
bridge
bridge
0
1
-1000

BUTTON
10
234
130
294
sample left side
sample-left
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

BUTTON
160
235
290
295
sample right side
sample-right
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
0

OUTPUT
10
303
290
503
12
@#$#@#$#@
## WHAT IS IT?

This project explores a simple system with a population that has been split into two by a road. The critters (rabbits, bugs, or butterflies) wander around aimlessly, but cannot cross the road. A conservation organization wants to understand if building a wildlife overpass will help these critters to become a single population again.

The amount of cover on the bridge (trees, shrubs, and grasses) can be adjusted from zero (open to the sky so hawks and other predators can easily see and catch the critters) to 100% (critters are completely hidden while crossing the overpass. This affects their speed and likelihood of crossing.

Rabbits move the fastest, bugs move the slowest. Butterflies move quickly but frequently change direction.

## HOW TO USE IT

Choose a CRITTER from the dropdown box at the top, and toggle the "BRIDGE" box to choose whether a wildlife overpass has been installed. If it has been, use the BRIDGE_COVER slider to determine how much greenery is present on the overpass.

Click the SETUP button to setup the CRITTERS on each side. Those that start on the left are orange, those that start on the right are purple. 

When you are done watching the CRITTERS traveling, click the HIDE HOME SIDE button to see that we can't tell the two populations apart when we don't have information about the side each CRITTER started on.

We will use microsatellites, quick and relatively simple genetic markers, to figure out how mixed the populations become with and without a bridge. When you are ready, click "SAMPLE LEFT SIDE" and "SAMPLE RIGHT SIDE" to get microsatellite data from 5 CRITTERS from each side of the road.

We sample five microsatellites, called H, X, K, Y, and A. Each CRITTER has two versions of each microsatellite, separated by a slash, for example H234/H246. Two CRITTERS that started out on the same side of the road will be more genetically similar to each other than they are to critters that started on the other side of the road.

Can you tell how well mixed the two populations are after installing the overpass?

## THINGS TO NOTICE

Watch the ticks at the top (these represent time) and see how long it takes for the first critters to get from one side to the other. At first, the populations on the two sides are very distinct, but as time goes on, you may see orange among the purple and vice versa.

How does the amount of cover on the overpass affect this?

<!-- 2001 -->
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

rabbit
false
0
Circle -7500403 true true 76 150 148
Polygon -7500403 true true 176 164 222 113 238 56 230 0 193 38 176 91
Polygon -7500403 true true 124 164 78 113 62 56 70 0 107 38 124 91

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

squirrel
false
0
Polygon -7500403 true true 87 267 106 290 145 292 157 288 175 292 209 292 207 281 190 276 174 277 156 271 154 261 157 245 151 230 156 221 171 209 214 165 231 171 239 171 263 154 281 137 294 136 297 126 295 119 279 117 241 145 242 128 262 132 282 124 288 108 269 88 247 73 226 72 213 76 208 88 190 112 151 107 119 117 84 139 61 175 57 210 65 231 79 253 65 243 46 187 49 157 82 109 115 93 146 83 202 49 231 13 181 12 142 6 95 30 50 39 12 96 0 162 23 250 68 275
Polygon -16777216 true false 237 85 249 84 255 92 246 95
Line -16777216 false 221 82 213 93
Line -16777216 false 253 119 266 124
Line -16777216 false 278 110 278 116
Line -16777216 false 149 229 135 211
Line -16777216 false 134 211 115 207
Line -16777216 false 117 207 106 211
Line -16777216 false 91 268 131 290
Line -16777216 false 220 82 213 79
Line -16777216 false 286 126 294 128
Line -16777216 false 193 284 206 285

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.0
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0
-0.2 0 0 1
0 1 1 0
0.2 0 0 1
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@

@#$#@#$#@
