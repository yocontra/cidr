{Range} = require '../index'
range = new Range '192.168.1.0', 24
console.log 'ipv4 random:', range.getRandom()
console.log 'ipv4 total:', range.getTotal()

range2 = new Range '620:0:2d0:200::', 24
console.log 'ipv6 random:', range2.getRandom()
console.log 'ipv6 total:', range2.getTotal()