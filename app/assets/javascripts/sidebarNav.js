function toggleNav() {
    var sidenav = document.getElementById("sidenav");
    var toggleBtn = document.getElementById("toggleBtn");
    if (sidenav.style.width == '0px') {
        openNav(sidenav, toggleBtn);
    } else {
        closeNav(sidenav, toggleBtn);
    }
}

function closeNav(sidenav, toggleBtn) {
  sidenav.style.width = '0px';
  toggleBtn.innerHTML = "☰";
}

function openNav(sidenav, toggleBtn) {
  sidenav.style.width = '250px';
  toggleBtn.innerHTML = '<i class="fas fa-arrow-left"></i>';
}

function bodyNavClose() {
  var sidenav = document.getElementById("sidenav");
  var toggleBtn = document.getElementById("toggleBtn");
  closeNav(sidenav, toggleBtn);
}
