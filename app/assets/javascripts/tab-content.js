function tabSwitch(tabID) {
  var highlight = document.getElementById("tab-highlight").firstElementChild;

  var tabContent = document.getElementById(tabID.substr(0,4));
  document.getElementsByClassName("tab-content-container")[0].getElementsByClassName('active')[0].classList.remove('active');
  tabContent.classList.add('active');


  if(tabID == "tab1-tab"){
    highlight.style.left = "0px";
  } else if (tabID == "tab2-tab") {
    highlight.style.left = "33.33%";
  } else {
    highlight.style.left = "66.9%";
  }
}
