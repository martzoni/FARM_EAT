if (document.getElementById("map")) {
  document.getElementById("map").onmouseover = function() {mouseOver()};

function mouseOver() {
  document.getElementById("map").style.height = "55vh";
  document.getElementById("farm-list").style.marginTop = "60vh";
}

window.onscroll = function() {scrollFunction()};

function scrollFunction() {
  if (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50) {
    document.getElementById("map").style.height = "30vh";
    document.getElementById("farm-list").style.marginTop = "35vh";
    
  }
}}
    
