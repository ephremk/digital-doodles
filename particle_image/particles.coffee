window.requestAnimationFrame ||=
  window.webkitRequestAnimationFrame ||
  window.mozRequestAnimationFrame    ||
  window.oRequestAnimationFrame      ||
  window.msRequestAnimationFrame     ||
  (callback, element) ->
    window.setTimeout( ->
      callback(+new Date())
    , 1000 / 60)


window.flockingDots = []

generateFlockingDots  = ->
  canvas = document.createElement 'canvas'
  canvas.setAttribute 'width', mask.width
  canvas.setAttribute 'height', mask.height
  canvas.style.position = "absolute"
  canvas.style['z-index'] = "-1"

  ctx = canvas.getContext '2d'
  ctx.drawImage mask, 0, 0
  data = ctx.getImageData 0, 0, mask.width, mask.height
  for y in [0 ... mask.height]
    for x in [0 ... mask.width]
      index = (y * mask.width + x) * 4
      if data.data[index + 3]
        flockingDots.push
          x: x
          y: y

  run()

mask = new Image

mask.onload = generateFlockingDots



run = () ->
  width             = window.innerWidth
  height            = window.innerHeight
  elm               = document.createElement 'canvas'
  pixelDensity      = window.devicePixelRatio || 1
  particles         = []
  elm.style.width   = width + "px"
  elm.style.height  = height + "px"

  elm.setAttribute 'width', width * pixelDensity
  elm.setAttribute 'height', height * pixelDensity

  ctx     = elm.getContext '2d'
  document.body.appendChild elm

  for i in [0 ... flockingDots.length] by 80
    particles.push new Particle ctx, width, height, pixelDensity, i, 'rgba(254, 252, 0, 0.5)'
    particles.push new Particle ctx, width, height, pixelDensity, i, 'rgba(0, 143, 164, 0.5)'

  tick = ->
    requestAnimationFrame(tick)
    ctx.clearRect 0, 0, width * pixelDensity, height * pixelDensity
    for p in particles
      p.tick()

  tick()


class Particle
  constructor: (ctx, width, height, pixelDensity, i, color, velocity) ->
    @ctx      = ctx
    @x        = ~~(Math.random() * 100 * pixelDensity)
    @y        = ~~(Math.random() * 100 * pixelDensity)
    @idealSpot =
      x: flockingDots[i].x
      y: flockingDots[i].y
    @velocity =
      x: ((Math.random() * 10)+0.5) * @plusMinus @x, @idealSpot.x
      y: ((Math.random() * 10)+0.5) * @plusMinus @y, @idealSpot.y
    @color         = color
    @

  plusMinus: (from, to) ->
    if from > to then -1 else 1

  draw: ->
    @ctx.beginPath()
    @ctx.fillStyle = @color
    @ctx.arc @x, @y, 5, 0, 2 * Math.PI
    @ctx.fill()
    @ctx.closePath()
    @

  tick: ->
    if Math.abs(@x - @idealSpot.x) <= 0.5
      @velocity.x = 0
    if Math.abs(@y - @idealSpot.y) <= 0.5
      @velocity.y = 0

    if @x < 0 || @x > 500 then (@velocity.x = @velocity.x * -1 - 0.5)
    if @y < 0 || @y > 500 then (@velocity.y = @velocity.y * -1 - 0.5)

    @x += @velocity.x
    @y += @velocity.y

    @draw()
    @

mask.src = "hex.png"