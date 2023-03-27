(function (config) {
  const allElemsExists = (selectors) =>
    !selectors.some((s) => !document.querySelector(s));

  const typeInputValue = function (el, value) {
    el.value = value;
    el.scrollIntoViewIfNeeded();
    el.focus();
    const event = new Event('input', {
      bubbles: true,
      cancelable: true,
    });
    el.dispatchEvent(event);
  };

  function handleElement(selector, action) {
    const elem = document.querySelector(selector);
    if (elem && action.innerHTML && elem.innerHTML !== action.innerHTML) {
      return false;
    }
    const handlers = {
      fill: typeInputValue,
      click(el) {
        el.focus();
        el.click();
      },
    };

    const handler = action && elem && handlers[action.type];

    if (handler) {
      handler(elem, action.payload);
      return true;
    }
  }

  function runEvents(eventsMap) {
    eventsMap.forEach((obj) => {
      const selectors = Object.keys(obj);
      if (allElemsExists(selectors)) {
        selectors.forEach((s) => {
          handleElement(s, obj[s]);
        });
      }
    });
  }
  function initAutoFillEvents(data) {
    data = typeof data === 'string' ? JSON.parse(data) : data;
    if (document && document.readyState === 'complete') {
      runEvents(data);
    } else {
      document.addEventListener('DOMContentLoaded', function () {
        runEvents(data);
      });
    }
  }
  initAutoFillEvents(config);
})();
