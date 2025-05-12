// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  longPollFallbackMs: 2500,
  params: {_csrf_token: csrfToken}
})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

document.addEventListener("DOMContentLoaded", function () {
  // Hamburger menu toggle
  const toggleBtn = document.getElementById('navbar-toggle');
  const menu = document.getElementById('navbar-menu');

  toggleBtn.addEventListener('click', function () {
    menu.classList.toggle('hidden');
  });

  const categoriesMenu = document.getElementById('categories-menu');
  const dropdown = categoriesMenu.querySelector('.dropdown-menu');

  categoriesMenu.addEventListener('click', function (e) {
    if (window.innerWidth < 768) {
      e.preventDefault();
      dropdown.classList.toggle('hidden');
    }
  });

  document.addEventListener('click', function (e) {
    if (!categoriesMenu.contains(e.target) && window.innerWidth < 768) {
      dropdown.classList.add('hidden');
    }
  });
});


document.addEventListener("DOMContentLoaded", () => {
  function setupDropdown(toggleId, dropdownId, selectedId) {
    const toggle = document.getElementById(toggleId);
    const dropdown = document.getElementById(dropdownId);
    const selected = document.getElementById(selectedId);

    toggle?.addEventListener("click", () => {
      dropdown.classList.toggle("hidden");
    });

    dropdown?.querySelectorAll(".dropdown-item").forEach((item) => {
      item.addEventListener("click", (e) => {
        selected.textContent = `${selected.textContent.split(":")[0]}: ${e.target.textContent}`;
        dropdown.classList.add("hidden");
      });
    });

    document.addEventListener("click", (e) => {
      if (!toggle.contains(e.target) && !dropdown.contains(e.target)) {
        dropdown.classList.add("hidden");
      }
    });
  }

  setupDropdown("category-toggle", "category-dropdown", "selected-category");
  setupDropdown("price-toggle", "price-dropdown", "selected-price");
  setupDropdown("sort-toggle", "sort-dropdown", "selected-sort");
});

document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".fa-ellipsis-v").forEach((btn) => {
    btn.addEventListener("click", (e) => {
      e.stopPropagation();

      document.querySelectorAll(".fa-ellipsis-v")
        .forEach(otherBtn => {
          if (otherBtn !== btn) {
            const otherDropdown = otherBtn.closest(".relative").querySelector("div:not(.fa-ellipsis-v)");
            if (otherDropdown) {
              otherDropdown.classList.add("hidden");
            }
          }
        });

      const dropdown = btn.closest(".relative").querySelector("div:not(.fa-ellipsis-v)");
      if (dropdown) {
        dropdown.classList.toggle("hidden");
      }
    });
  });

  document.addEventListener("click", () => {
    document.querySelectorAll(".fa-ellipsis-v").forEach((btn) => {
      const dropdown = btn.closest(".relative").querySelector("div:not(.fa-ellipsis-v)");
      if (dropdown && !dropdown.classList.contains("hidden")) {
        dropdown.classList.add("hidden");
      }
    });
  });
});


document.addEventListener("DOMContentLoaded", () => {
  const menuToggle = document.getElementById("menuToggle");
  const mobileNav = document.getElementById("mobileNav");
  const menuOverlay = document.getElementById("menuOverlay");
  const closeMenu = document.getElementById("closeMenu");

  function openMenu() {
    mobileNav.classList.remove("-translate-x-full");
    menuOverlay.classList.remove("hidden");
  }

  function closeNav() {
    mobileNav.classList.add("-translate-x-full");
    menuOverlay.classList.add("hidden");
  }

  menuToggle.addEventListener("click", openMenu);
  closeMenu.addEventListener("click", closeNav);
  menuOverlay.addEventListener("click", closeNav);
});
