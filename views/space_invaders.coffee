class SpaceInvader
  constructor:(initial_x, initial_y) ->
    @x = initial_x
    @y = initial_y
    @color = "#FFFF66"
    @state = "right"
    @repetition = 0
    @odd = true

  image: ->
    @current_image = @still_state()
    @current_image

  still_state: ->
    image = new Image()
    if @odd == true
      image.src = 'images/invader-3.png'
    else
      image.src = 'images/invader-2.png'
    image

  draw:(context) ->
    context.drawImage(@image(), @x, @y, 35, 20)

  animate:(context) ->
    @timeout = setTimeout (=>
      @transition_state()
      @draw(context)
    ),
    0

  transition_state: ->
    @odd = !@odd
    if @state == "right"
      @vstate = "right"
      @x = @x+10
      if @repetition < 22
        @repetition++
      else
        @state = "down"
        @repetition = 0
    else if @state == "down"
      @y = @y+20
      if @vstate == "right"
        @state = "left"
      else if @vstate == "left"
        @state = "right"
    else if @state == "left"
      @vstate = "left"
      @x = @x-10
      if @repetition < 22
        @repetition++
      else
        @state = "down"
        @repetition = 0

class Painter
  constructor: ->
    @color = '#ffffff'
    @setup_context()
    @setup_invaders()

  clear: ->
    @canvas.width = @canvas.width

  setup_context: ->
    @canvas = document.getElementById "invaders"
    @context = @canvas.getContext "2d"

  setup_invaders: ->
    @invaders = []
    for x in [1...12]
      for y in [0..4]
        invader = new SpaceInvader(x*60, y*40)
        @invaders.push invader

  draw_invaders: ->
    for pos in [0...@invaders.length]
      @invaders[pos].draw(@context)

  animate: ->
    @timeout = setTimeout (=>
      @clear()
      for pos in [0...@invaders.length]
        @invaders[pos].animate(@context)
      @animate()
      ),
      1000

jQuery = $
$(document).ready ->
  painter = new Painter
  painter.draw_invaders()
  painter.animate()
