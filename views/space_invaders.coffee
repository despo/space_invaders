class SpaceInvader
  constructor:(initial_x, initial_y) ->
    @x = initial_x
    @y = initial_y
    @color = "#FFFF66"

  draw:(context) ->
    context.fillStyle = @color
    context.fillRect @x, @y, 50, 30

  animate:(context) ->
    @timeout = setTimeout (=>
      @x = @x+10
      @draw(context)
    ),
    0

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
    for x in [1...6]
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
      2000

jQuery = $
$(document).ready ->
  painter = new Painter
  painter.draw_invaders()
  painter.animate()
