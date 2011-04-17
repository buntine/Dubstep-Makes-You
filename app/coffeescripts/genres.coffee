get_largest_genre = () ->
  largest = 0
  $('.genre .programming_skill').each ->
    skill =  parseInt $(this).text()
    largest = skill if skill > largest
  return largest
  

draw_genres = (p) ->
  p.setup = () ->
    p.size($(window).width(),$(window).height())
    p.background(0)
    p.noLoop()
    p.smooth()
    window.genres = []
    
  p.draw = () ->
    $('.genre').each ->
      genre = new Genre(p, {
        name: $(this).find('.name').text()
        programming_skill: $(this).find('.programming_skill').text()
      })
      window.genres.push(genre)    
    genre.draw() for genre in window.genres
    
class Genre
  constructor: (@p,opts) ->
    @p.smooth()
    @p.textFont(@p.createFont("SansSerif",14))
    @p.textAlign(@p.CENTER)
    @name = opts.name
    @programming_skill = opts.programming_skill
    @x = Math.random() * @p.width
    @y = Math.random() * @p.height
    @width = @getSizeFromSkill()
    @height = @getSizeFromSkill()
    
  draw: () ->
    return if @programming_skill = 0
    @p.fill(0,121,184,98)
    @p.noStroke()
    @p.ellipse(@x,@y,@width,@height)
    @p.fill(255,255,255)
    @p.text(@name,@x,@y)
    
  
  getSizeFromSkill: () ->
    percentage = (@programming_skill/window.largest)*100
    size = ((percentage/80)*200)+40
    return size

$(document).ready ->
  window.largest = get_largest_genre()
  canvas = document.getElementById 'processing'
  processing = new Processing(canvas, draw_genres)