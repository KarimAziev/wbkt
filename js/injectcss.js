(function (css, timeout) {
  if (!document || !document.getElementsByTagName || !document.createElement) {
    return;
  }
  let head = document.head || document.getElementsByTagName('head')[0];
  if (head) {
    let style = document.createElement('style');
    if (head && head.appendChild && style) {
      head.appendChild(style);

      if (style.styleSheet) {
        style.styleSheet.cssText = css;
      } else {
        style.appendChild(document.createTextNode(css));
      }
      if (timeout) {
        setTimeout(() => {
          if (style) {
            style.remove();
          }
        }, timeout);
      }
    }
  }
})();
