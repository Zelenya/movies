const canvas = document.getElementById('myCanvas');
canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

export function addImage(x) {
  return function (y) {
    return function (imgPath) {
      return function () {
        const context = canvas.getContext('2d');

        const image = new Image(300, 450);
        image.src = imgPath;

        const x0 = x - image.width / 2;
        const y0 = y - image.height / 2

        image.onload = function () {
          context.drawImage(image, x0, y0);
        };
      };
    };
  };
};
