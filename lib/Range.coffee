rand = -> (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1)

fillBits = (bits) ->
  return 255 if bits >= 8
  bitpat = 0xff00
  for bit in bits
    bitpat = bitpat >> 1
  return bitpat & 0xff


class Range
  constructor: (@prefix, @bits) ->
    [@prefix. @bits] = @prefix.split '/' unless @bits
    throw 'Missing parameters' unless @prefix and @bits

    if @prefix.indexOf('::') > -1
      throw 'Bits must be under 128' unless @bits <= 128
      @type = 6
      @parts = (part for part in @prefix.split(':') when part isnt '')
      @total = Math.pow(2, 128 - @bits) - 2
      @range = 8 - @parts.length
    else
      throw 'Bits must be under 32' unless @bits <= 32
      @type = 4
      @parts = @prefix.split '.'
      @total = Math.pow(2, 32 - @bits) - 2
      @min = +@parts[@parts.length-1]

  getTotal: -> @total
  getRandom: ->
    ip = new Array().concat @parts

    if @type is 4
      if @total <= 255
        ip[ip.length-1] = @min + Math.floor Math.random()*@total
        return ip.join '.'
      else
        return # TODO: Bit shifting
    else
      ip.push(rand()) for num in [0...@range]
      return ip.join ':'

module.exports = Range