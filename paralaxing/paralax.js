// Generated by CoffeeScript 1.4.0
(function() {
  var advance;

  $(function() {
    return $(window).on('scroll', advance);
  });

  advance = function() {
    var artHeight, elementHeight, finishedAt, scrollBy;
    artHeight = 500;
    elementHeight = 216;
    finishedAt = artHeight + elementHeight;
    this.container = this.container || $('#paralax-container div').first();
    scrollBy = window.scrollY * (216 / 580);
    return this.container.css('transform', "translateY(" + (-scrollBy) + "px)");
  };

}).call(this);
