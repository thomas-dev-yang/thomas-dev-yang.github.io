(function () {
  "use strict";

  var root = document.documentElement;

  function setupTheme() {
    var key = "blog-theme";
    var button = document.querySelector(".theme-toggle");
    var favicon = document.querySelector(".site-favicon");
    var systemTheme = window.matchMedia("(prefers-color-scheme: dark)");

    if (!button) return;

    function currentTheme() {
      return root.dataset.theme || (systemTheme.matches ? "dark" : "light");
    }

    function renderTheme() {
      var theme = currentTheme();
      var nextTheme = theme === "dark" ? "light" : "dark";
      button.setAttribute("aria-label", "Use " + nextTheme + " theme");

      if (favicon) {
        var faviconHref = favicon.dataset[theme + "Href"];
        if (faviconHref && favicon.getAttribute("href") !== faviconHref) {
          favicon.setAttribute("href", faviconHref);
        }
      }
    }

    button.hidden = false;
    button.addEventListener("click", function () {
      var nextTheme = currentTheme() === "dark" ? "light" : "dark";
      root.dataset.theme = nextTheme;

      try {
        localStorage.setItem(key, nextTheme);
      } catch (error) {}

      renderTheme();
    });

    systemTheme.addEventListener("change", function () {
      if (!root.dataset.theme) renderTheme();
    });

    renderTheme();
  }

  function setupSections() {
    var sections = document.querySelectorAll(".home section.level2");

    sections.forEach(function (section, index) {
      var heading = section.firstElementChild;
      var content = Array.from(section.children).slice(1);

      if (!heading || heading.tagName !== "H2") return;
      if (content.length === 0) {
        section.hidden = true;
        return;
      }

      var list = content[0];
      if (list.tagName !== "UL" || list.children.length === 0) return;

      var items = Array.from(list.children);
      var title = heading.textContent;
      var button = document.createElement("button");
      var region = document.createElement("div");
      var preview = document.createElement("div");
      var states = items.length > 1 ? ["preview", "expanded", "collapsed"] : ["expanded", "collapsed"];
      var stateIndex = 0;

      button.type = "button";
      button.className = "section-toggle";
      button.textContent = title;
      heading.replaceChildren(button);
      heading.classList.add("is-toggle");

      region.id = (section.id || "section-" + index) + "-content";
      region.className = "section-content";
      button.setAttribute("aria-controls", region.id);
      content.forEach(function (element) { region.appendChild(element); });
      section.appendChild(region);

      // A decorative glimpse of the next title fades into the page background.
      // It contains no links, so only visible posts enter the keyboard order.
      preview.className = "section-preview";
      preview.setAttribute("aria-hidden", "true");
      if (items.length > 1) {
        items[1].querySelectorAll(".post-title, .post-date").forEach(function (part) {
          preview.appendChild(part.cloneNode(true));
        });
      }
      region.appendChild(preview);

      function renderState() {
        var state = states[stateIndex];
        var next = states[(stateIndex + 1) % states.length];
        var actions = { preview: "Show newest post", expanded: "Show all posts", collapsed: "Collapse section" };
        var descriptions = { preview: "Showing newest post", expanded: "Showing all posts", collapsed: "Collapsed" };
        section.dataset.sectionState = state;
        button.setAttribute("aria-expanded", String(state !== "collapsed"));
        button.setAttribute("aria-label", title + ": " + descriptions[state] + ". " + actions[next]);
        region.hidden = state === "collapsed";
        items.forEach(function (item, itemIndex) {
          item.hidden = state === "preview" && itemIndex > 0;
        });
        preview.hidden = state !== "preview";
      }

      button.addEventListener("click", function () {
        stateIndex = (stateIndex + 1) % states.length;
        renderState();
      });
      renderState();
    });
  }

  setupTheme();
  setupSections();
})();
