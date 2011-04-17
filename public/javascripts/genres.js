/* DO NOT MODIFY. This file was compiled from
 *   /Users/karl/Projects/karlbright-dubstepmakesyou/app/coffeescripts/genres.coffee
 */

(function() {
  var Genre, draw_genres, get_largest_genre;
  get_largest_genre = function() {
    var largest;
    largest = 0;
    $('.genre .programming_skill').each(function() {
      var skill;
      skill = parseInt($(this).text());
      if (skill > largest) {
        return (largest = skill);
      }
    });
    return largest;
  };
  draw_genres = function(p) {
    p.setup = function() {
      p.size($(window).width(), $(window).height());
      p.background(0);
      p.noLoop();
      p.smooth();
      return (window.genres = []);
    };
    return (p.draw = function() {
      var _i, _len, _ref, _result, genre;
      $('.genre').each(function() {
        var genre;
        genre = new Genre(p, {
          name: $(this).find('.name').text(),
          programming_skill: $(this).find('.programming_skill').text()
        });
        return window.genres.push(genre);
      });
      _result = []; _ref = window.genres;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        genre = _ref[_i];
        _result.push(genre.draw());
      }
      return _result;
    });
  };
  Genre = function(_arg, opts) {
    this.p = _arg;
    this.p.smooth();
    this.p.textFont(this.p.createFont("SansSerif", 14));
    this.p.textAlign(this.p.CENTER);
    this.name = opts.name;
    this.programming_skill = opts.programming_skill;
    this.x = Math.random() * this.p.width;
    this.y = Math.random() * this.p.height;
    this.width = this.getSizeFromSkill();
    this.height = this.getSizeFromSkill();
    return this;
  };
  Genre.prototype.draw = function() {
    if (this.programming_skill = 0) {
      return null;
    }
    this.p.fill(0, 121, 184, 98);
    this.p.noStroke();
    this.p.ellipse(this.x, this.y, this.width, this.height);
    this.p.fill(255, 255, 255);
    return this.p.text(this.name, this.x, this.y);
  };
  Genre.prototype.getSizeFromSkill = function() {
    var percentage, size;
    percentage = (this.programming_skill / window.largest) * 100;
    size = ((percentage / 80) * 200) + 40;
    return size;
  };
  $(document).ready(function() {
    var canvas, processing;
    window.largest = get_largest_genre();
    canvas = document.getElementById('processing');
    return (processing = new Processing(canvas, draw_genres));
  });
}).call(this);
