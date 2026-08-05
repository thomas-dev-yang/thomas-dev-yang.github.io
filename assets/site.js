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

      if (!heading || heading.tagName !== "H2" || content.length === 0) return;

      var button = document.createElement("button");
      var region = document.createElement("div");
      var inner = document.createElement("div");
      var regionId = (section.id || "section-" + index) + "-content";

      button.type = "button";
      button.className = "section-toggle";
      button.setAttribute("aria-controls", regionId);

      while (heading.firstChild) button.appendChild(heading.firstChild);
      heading.appendChild(button);
      heading.classList.add("is-toggle");

      region.id = regionId;
      region.className = "section-content";
      inner.className = "section-content-inner";
      content.forEach(function (element) {
        inner.appendChild(element);
      });
      region.appendChild(inner);
      section.appendChild(region);

      function setCollapsed(collapsed) {
        section.classList.toggle("is-collapsed", collapsed);
        button.setAttribute("aria-expanded", String(!collapsed));
        region.setAttribute("aria-hidden", String(collapsed));
        inner.inert = collapsed;
      }

      button.addEventListener("click", function () {
        setCollapsed(!section.classList.contains("is-collapsed"));
      });

      setCollapsed(false);
    });
  }

  setupTheme();
  setupSections();
})();
