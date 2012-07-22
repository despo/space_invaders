class SpaceInvader
  constructor:(initial_x, initial_y) ->
    @x = initial_x
    @y = initial_y
    @color = "#00FFFF"

  draw:(context) ->
    context.fillStyle = @color
    context.fillRect @x, @y, 50, 30

class Painter
  constructor: ->
    @setup_context()
    @color = '#ffffff'
    @invaders = []
    @setup_invaders()

  setup_context: ->
    canvas = document.getElementById "invaders"
    @context = canvas.getContext "2d"

  draw_invaders: ->
    for pos in [0...@invaders.length]
      @invaders[pos].draw(@context)

  setup_invaders: ->
    for x in [1...6]
      for y in [0..5]
        invader = new SpaceInvader(x*100, y*50)
        @invaders.push invader

jQuery = $
$(document).ready ->
  painter = new Painter
  painter.draw_invaders()
