$(function() {
   $('#flash').delay(500).fadeIn('normal', function() {
      $(this).delay(2000).fadeOut();
   });
});

$(document).ready(function(){
	var clip = new ZeroClipboard($(".clip_button"));
	$(".clip_button").click(function() {
		clip = new ZeroClipboard($(".clip_button"));
  	});
});
