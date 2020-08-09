"use strict";

var canvas = document.getElementById('myCanvas');
canvas.width  = window.innerWidth;
canvas.height = window.innerHeight;

exports.addImage = function(x) {
  return function(y) {
    return function(imgPath) {
      return function() {
        var context = canvas.getContext('2d');

        var image = new Image(300, 450);
        image.src = imgPath;

        var x0 = x - image.width / 2;
        var y0 = y - image.height / 2

        image.onload = function(){
          context.drawImage(image, x0, y0);
        };
      };
    };
  };
};
