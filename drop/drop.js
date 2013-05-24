// Generated by CoffeeScript 1.6.2
(function() {
  window.requestAnimationFrame || (window.requestAnimationFrame = window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function(callback, element) {
    return window.setTimeout(function() {
      return callback(+new Date());
    }, 1000 / 60);
  });

  window.onload = function() {
    var clock, color, ctx, cursor, direction, elm, pixelDensity, run, tick;

    ctx = void 0;
    elm = void 0;
    pixelDensity = void 0;
    clock = 0;
    direction = 1;
    color = "#EA80B0";
    this.points = [0, 0];
    cursor = [];
    window.addEventListener("mousemove", function(e) {
      return this.points = [e.layerX, e.layerY];
    }, false);
    run = function() {
      var height, width, xOffset;

      width = window.innerWidth;
      height = window.innerHeight;
      elm = document.createElement('canvas');
      pixelDensity = window.devicePixelRatio || 1;
      elm.style.width = width + "px";
      elm.style.height = height + "px";
      xOffset = width * pixelDensity / 2;
      document.body.appendChild(elm);
      elm.setAttribute('width', width * pixelDensity);
      elm.setAttribute('height', height * pixelDensity);
      ctx = elm.getContext('2d');
      ctx.fillStyle = color;
      return tick();
    };
    window.onresize = function() {
      var height, width, xOffset;

      width = window.innerWidth;
      height = window.innerHeight;
      elm = document.getElementsByTagName('canvas')[0];
      pixelDensity = window.devicePixelRatio || 1;
      elm.style.width = width + "px";
      elm.style.height = height + "px";
      xOffset = width * pixelDensity / 2;
      elm.setAttribute('width', width * pixelDensity);
      return elm.setAttribute('height', height * pixelDensity);
    };
    tick = function() {
      var c, h, s, w, x, y, _i, _j;

      w = window.innerWidth;
      h = window.innerHeight;
      s = Math.sin(clock);
      c = Math.cos(clock);
      ctx.clearRect(0, 0, w, h);
      ctx.beginPath();
      for (x = _i = 0; _i <= w; x = _i += 10) {
        for (y = _j = 0; _j <= h; y = _j += 10) {
          ctx.arc(x, y, x + 10 > points[0] && x - 10 < points[0] && y + 10 > points[1] && y - 10 < points[1] ? Math.abs(x - points[0]) + 1 : 2, 0, 2 * Math.PI, 0);
        }
      }
      ctx.fill();
      ctx.closePath();
      clock += 0.1;
      return requestAnimationFrame(tick);
    };
    return run();
  };

}).call(this);