$(document).ready(function() {
              $('.main a').hover(function() {
                $(this).stop().animate({
                   opacity: 0.5
                 }, 200);
                    }, function() {
               $(this).stop().animate({
                opacity: 1
                 }, 200);
              });
            });