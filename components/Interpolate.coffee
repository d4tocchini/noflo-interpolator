noflo = require 'noflo'
e = require '../lib/penner'

class Interpolate extends noflo.Component
  
  description: 'Arbitrary value interpolation via bounded I/O API'
  
  constructor: ->
    @repeatMode = "none" #...
    @inPorts =
      in          : new noflo.Port 'number'
      inStart     : new noflo.Port 'number'
      inEnd       : new noflo.Port 'number'
      outStart    : new noflo.Port 'number'
      outEnd      : new noflo.Port 'number'
      type        : new noflo.Port 'string'
      repeatMode  : new noflo.Port 'string'
      #enable
  
  # TODO
    
exports.getComponent = -> new Interpolate
