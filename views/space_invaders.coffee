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
    context.drawImage(@image(), @x, @y, 50, 30)

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
      if @repetition < 6
        @repetition++
      else
        @state = "down"
        @repetition = 0
    else if @state == "down"
      @y = @y+10
      if @vstate == "right"
        @state = "left"
      else if @vstate == "left"
        @state = "right"
    else if @state == "left"
      @vstate = "left"
      @x = @x-10
      if @repetition < 6
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
    for x in [1...7]
      for y in [0..5]
        invader = new SpaceInvader(x*100, y*50)
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
