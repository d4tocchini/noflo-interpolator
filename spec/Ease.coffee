noflo = require 'noflo'
if typeof process is 'object' and process.title is 'node'
  chai = require 'chai' unless chai
  Ease = require '../components/Ease.coffee'
else
  Ease = require 'noflo-interpolator/components/Ease.js'

socket = noflo.internalSocket.createSocket

describe 'Ease component', ->
  c        = null
  time     = null
  type     = null
  start    = null
  end      = null
  duration = null
  bound    = null
  result   = null
  beforeEach ->
    c       = Ease.getComponent()
    time    = socket()
    type    = socket()
    start   = socket()
    end     = socket()
    duration= socket()
    bound   = socket()
    result  = socket()
    c.inPorts.time.attach time
    c.inPorts.type.attach type
    c.inPorts.start.attach start
    c.inPorts.end.attach end
    c.inPorts.duration.attach duration
    c.inPorts.bound.attach bound
    c.outPorts.result.attach result

  describe 'when instantiated', ->
    it 'should have an input port', ->
      chai.expect(c.inPorts.time).to.be.an 'object'
    it 'should have an output port', ->
      chai.expect(c.outPorts.result).to.be.an 'object'
  
  # Bounds

  describe 'Bound Types:', ->
    
    # hold bounds
    
    describe 'hold:', ->
      beforeEach ->
        type.send "linear"
        start.send 0
        end.send 100
        duration.send 100
        bound.send 'hold'
      it 'below 0%', (done) ->
        result.on 'data', (res) ->
          chai.expect(res).to.equal 0
          done()            
        time.send -1000
      it 'at 50%', (done) ->
        result.on 'data', (res) ->
          chai.expect(res).to.equal 50
          done()      
        time.send 50
      it '100%', (done) ->
        result.on 'data', (res) ->
          chai.expect(res).to.equal 100
          done()      
        time.send 10000
    
    # loop bounds
    
    describe 'loop:', ->
      beforeEach ->
        type.send "linear"
        start.send 200
        end.send 300
        duration.send 100
        bound.send 'loop'
      it 'below 0%', (done) ->
        result.on 'data', (res) ->
          chai.expect(res).to.equal 299
          done()            
        time.send -1
      it 'at -150%', (done) ->
        result.on 'data', (res) ->
          chai.expect(res).to.equal 250
          done()      
        time.send 50
      it 'at 50%', (done) ->
        result.on 'data', (res) ->
          chai.expect(res).to.equal 250
          done()      
        time.send 150
      it 'above 100%', (done) ->
        result.on 'data', (res) ->
          chai.expect(res).to.equal 250
          done()      
        time.send 10050
      it 'at 230%', (done) ->
        result.on 'data', (res) ->
          chai.expect(res).to.equal 230
          done()      
        time.send 230
    
    describe 'loop negative:', ->
      beforeEach ->
        type.send "linear"
        start.send -200
        end.send -300
        duration.send 100
        bound.send 'loop'
      it 'below 0%', (done) ->
        result.on 'data', (res) ->
          chai.expect(res).to.equal -299
          done()            
        time.send -1
      it 'at -150%', (done) ->
        result.on 'data', (res) ->
          chai.expect(res).to.equal -250
          done()      
        time.send 50
      it 'at 50%', (done) ->
        result.on 'data', (res) ->
          chai.expect(res).to.equal -250
          done()      
        time.send 150
      it 'above 100%', (done) ->
        result.on 'data', (res) ->
          chai.expect(res).to.equal -250
          done()      
        time.send 10050
      it 'at 230%', (done) ->
        result.on 'data', (res) ->
          chai.expect(res).to.equal -230
          done()      
        time.send 230
    
    # mirroe bounds
    
    describe 'mirror:', ->
      beforeEach ->
        type.send "linear"
        start.send 200
        end.send 300
        duration.send 100
        bound.send 'mirror'
      it 'below 0%', (done) ->
        result.on 'data', (res) ->
          chai.expect(res).to.equal 201
          done()            
        time.send -1
      it 'at -150%', (done) ->
        result.on 'data', (res) ->
          chai.expect(res).to.equal 250
          done()      
        time.send 50
      it 'at 50%', (done) ->
        result.on 'data', (res) ->
          chai.expect(res).to.equal 250
          done()      
        time.send 150
      it 'above 100%', (done) ->
        result.on 'data', (res) ->
          chai.expect(res).to.equal 299
          done()      
        time.send 101
      it 'at 201%', (done) ->
        result.on 'data', (res) ->
          chai.expect(res).to.equal 201
          done()      
        time.send 201
  
  
  # Linear
  
  describe 'linear', ->
    beforeEach ->
      type.send "linear"
      start.send 0
      end.send 100
      duration.send 100
    it 'should intperolate 0%', (done) ->
      result.on 'data', (res) ->
        chai.expect(res).to.equal 0
        done()            
      time.send 0
    it 'should intperolate 50%', (done) ->
      result.on 'data', (res) ->
        chai.expect(res).to.equal 50
        done()      
      time.send 50
    it 'should intperolate 100%', (done) ->
      result.on 'data', (res) ->
        chai.expect(res).to.equal 100
        done()      
      time.send 100
  
  # Sine

  describe 'sineIn', ->
    beforeEach ->
      type.send "sineIn"
      start.send 0
      end.send 100
      duration.send 100
    it 'should intperolate 0%', (done) ->
      result.on 'data', (res) ->
        chai.expect(res).to.equal 0
        done()            
      time.send 0
    it 'should intperolate 50%', (done) ->
      result.on 'data', (res) ->
        chai.expect(res).to.below 50
        done()      
      time.send 50
    it 'should intperolate 100%', (done) ->
      result.on 'data', (res) ->
        chai.expect(res).to.equal 100
        done()      
      time.send 100
  
  describe 'sineOut', ->
    beforeEach ->
      type.send "sineOut"
      start.send 0
      end.send 100
      duration.send 100
    it 'should intperolate 0%', (done) ->
      result.on 'data', (res) ->
        chai.expect(res).to.equal 0
        done()            
      time.send 0
    it 'should intperolate 50%', (done) ->
      result.on 'data', (res) ->
        chai.expect(res).to.above 50
        done()      
      time.send 50
    it 'should intperolate 100%', (done) ->
      result.on 'data', (res) ->
        chai.expect(res).to.equal 100
        done()      
      time.send 100
  
  describe 'sineInOut', ->
    beforeEach ->
      type.send "sineInOut"
      start.send 0
      end.send 100
      duration.send 100
    it 'should intperolate 0%', (done) ->
      result.on 'data', (res) ->
        chai.expect(res).to.equal 0
        done()            
      time.send 0
    it 'should intperolate 50%', (done) ->
      result.on 'data', (res) ->
        chai.expect(Math.round(res)).to.equal 50
        done()      
      time.send 50
    it 'should intperolate 100%', (done) ->
      result.on 'data', (res) ->
        chai.expect(Math.round(res)).to.equal 100
        done()      
      time.send 100
  

