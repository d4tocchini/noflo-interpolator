noflo = require 'noflo'
e = require '../lib/penner'
b = require '../lib/bound'

class Ease extends noflo.Component
  
  description: 'Arbitrary value interpolation via time-based easing API'
  
  bound: "hold" #...
  #_bounds: ["loop", "mirror", "mirrorOnce", "hold", "extend", "silent"]
  
  startTime: 0
  
  constructor: ->
    @inPorts =
      time        : new noflo.Port 'number'
      startTime   : new noflo.Port 'number'
      start       : new noflo.Port 'number'
      end         : new noflo.Port 'number'
      duration    : new noflo.Port 'number'
      type        : new noflo.Port 'string'
      bound       : new noflo.Port 'string'
      #enable
      
    @outPorts =
      result  : new noflo.ArrayPort 'number'
      #time    : new noflo.Port 'number'
      error   : new noflo.Port()
    
    @setBoundFunc()
    
    @inPorts.time.on "data", (data) =>
      @time = data
      @interpolate()
    
    @inPorts.startTime.on "data", (data) =>
      @startTime = data
      @interpolate()
      
    @inPorts.start.on "data", (data) =>
      @start = data
      @interpolate()
    
    @inPorts.end.on "data", (data) =>
      @end = data
      @interpolate()
    
    @inPorts.duration.on "data", (data) =>
      @duration = data
      @interpolate()
    
    @inPorts.type.on "data", (data) =>
      @type = data
      @easeFunc = e[data]
      return @error "ease type not found: #{data}" unless @easeFunc
      @interpolate()
    
    @inPorts.bound.on "data", (data) =>
      @bound = data
      @setBoundFunc()
      @interpolate()
      
  interpolate: () =>
    required = ['time', 'start', 'end', 'duration', 'type', 'bound']
    for req in required
      return if @[req] is undefined
    result = @boundFunc(@startTime, @startTime + @duration, @time, @start, @end, @easeFunc)
    @outPorts.result.send result
    @outPorts.result.disconnect()
  
  setBoundFunc: () =>
    @boundFunc = b[@bound]
    return @error "bound type not found: #{@bound}" unless @boundFunc
    @boundFunc
  
  error: (message) ->
    unless @outPorts.error.isAttached()
      throw new Error message
    @outPorts.error.send new Error "ease type not found: #{data}"
    
exports.getComponent = -> new Ease
