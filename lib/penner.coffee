module.exports =
  
  # var   penner          i/o               x-y graph
  #
  # t =   time            || input from 0   || x - x1
  # b =   begining        || output start   || y1
  # c =   position change || output span    || y2 - y1
  # d =   duration        || input span     || x2 - x1
  #
  # returns position      || output         || y
  
  
  linear : (t, b, c, d) ->
    c * t / d + b
  
  
  # Sinusoidal: y(x) = sin(X × π/2)
  #
  # Sinusoidal easing is quite gentle, even more so than quadratic easing.  its path doesn’t have a lot of curvature. Much of the curve resembles a straight line angled at 45 degrees, with just a bit of acurve to it.
  #
  # Two of the sinusoidal easing functions use cosine instead, but only to optimize the calculation. Sine and cosine functions can be transformed into each other at will. You just have to shift the curves along the time axis by one-quarter of a cycle (90 degreesor π/2 radians).
  
  sineIn : (t, b, c, d) ->
    c * (1 - Math.cos( t / d * (Math.PI / 2)) ) + b
    
  sineOut : (t, b, c, d) ->
    c * Math.sin( t / d * (Math.PI / 2) ) + b
    
  sineInOut : (t, b, c, d) ->
    c / 2 * (1 - Math.cos( Math.PI*t / d) ) + b
  
  
  # Quadratic: y(x) = x^2, parabola
  #
	# I always wondered why the term quad-ratic (the prefix means “four”) is used to describe equations with a degree of two (x2). I finally looked it up in the dictionary (RTFD, you might say). I discovered that quad originally referred to the four sides of a square. Thus, a squared variable is quadratic.
  
  quadIn : (t, b, c, d) ->
    c*(t/=d)*t + b
  
  quadOut : (t, b, c, d) ->
    -c * (t/=d)*(t-2) + b
    
  quadInOut : (t, b, c, d) ->
    if (( t /= d / 2 ) < 1)
      c / 2 * t * t + b
    -c / 2 * ((--t)*(t-2) - 1) + b
  
  
  # Cubic: y(x) = x^3
  #
  # A cubic ease is a bit more curved than a quadratic one.
  
  cubicIn : (t, b, c, d) ->
    c * Math.pow(t / d, 3) + b
  
  cubicOut : (t, b, c, d) ->
    c * (Math.pow(t / d - 1, 3) + 1) + b
    
  cubicInOut : (t, b, c, d) ->
    if ((t /= d / 2) < 1)
      c / 2 * Math.pow(t, 3) + b
    c / 2 * (Math.pow(t-2, 3) + 2) + b
    
    
  # Quartic: y(x) = x^4
  #
  # Puts just a bit more bend in the curve. A cubic ease, though more pronounced than a quadratic ease, still feels fairly natural. It’s at the quartic level that the motion starts to feel a bit “other-worldly,” as the acceleration becomes more exaggerated.

  quartIn : (t, b, c, d) ->
    c * Math.pow(t / d, 4) + b
    
  quartOut : (t, b, c, d) ->
    -c * (Math.pow(t / d - 1, 4) - 1) + b
    
  quartInOut : (t, b, c, d) ->
    if ((t /= d / 2) < 1)
      c / 2 * Math.pow(t, 4) + b
    -c / 2 * (Math.pow(t-2, 4) - 2) + b
  
  
  # Quintic: y(x) = x^5
  #
  # Quintic is a fairly pronounced curve, as Figure 7-10 shows. The motion starts out quite slow, then becomes quite fast. The curvature of the graph is close to that of exponential easing
  
  quintIn : (t, b, c, d) ->
    c * Math.pow(t / d, 5) + b
    
  quintOut : (t, b, c, d) ->
    c * (Math.pow(t / d-1, 5) + 1) + b
    
  quintInOut : (t, b, c, d) ->
    if ((t /= d / 2) < 1)
      c / 2 * Math.pow(t, 5) + b
    c / 2 * (Math.pow(t-2, 5) + 2) + b
  
  
  # Circular: y(x) = 1 - Math.sqrt(1-x^2)
  #
  # Circular easing is based on the equation for half of a circle, which uses a square root
  #
  # The curve for circular easing is simply an arc - a quarter-circle
  #
  # it adds a unique flavor when put into motion. Like quintic and exponential easing, the acceleration for circular easing is dramatic, but somehow it seems to happen more “suddenly” than the others.
  
  circIn : (t, b, c, d) ->
    c * (1 - Math.sqrt(1 - (t/=d)*t)) + b
    
  circOut : (t, b, c, d) ->
    c * (1 - Math.sqrt(1 - (t/=d)*t)) + b
    
  circInOut : (t, b, c, d) ->
    if ((t /= d / 2) < 1)
      c / 2 * (1 - Math.sqrt(1 - t*t)) + b
    c / 2 * (Math.sqrt(1 - (t-=2)*t) + 1) + b
  

  # Exponential: y(x) = 2^(10(x-1))
  #
  # Exponential easing has a lot of curvature
  #
  # this one took me the longest to find. Part of the challenge is that the slope for an ease-in curve should be zero at t = 0. An exponential curve, however, never has a slope of zero.  I ended up giving the curve a very small slope that was “close enough” to zero. (If you plug t = 0 into the preceding equation, you get 2^(-10), which is0.0009765625.)
  
  expoIn : (t, b, c, d) ->
    c * Math.pow(2, 10 * (t / d - 1)) + b
    
  expoOut : (t, b, c, d) ->
    c * (-Math.pow(2, -10 * t / d) + 1) + b
    
  expoInOut : (t, b, c, d) ->
    if ((t /= d / 2) < 1)
      c / 2 * Math.pow(2, 10 * (t - 1)) + b
    c / 2 * (-Math.pow(2, -10 * --t) + 2) + b
  
    

