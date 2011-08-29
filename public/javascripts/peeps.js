var Peeps;
if(!Peeps){
    Peeps = {};
};

Peeps.game = (function(){
    var fadeOutTimer = 1000;
    var setup = function(){
        $("#peeps").imagesLoaded(function(){
            $("#peeps").masonry({
                itemSelector : 'li',
                columnWidth : 20
            });
        });
    };
    var reloadMasonry = function(){
        $("#peeps").masonry("reload");
    };
    var init = function(){
        $(".ui-draggable").draggable({
            cursor: "move"
        });
        $(".ui-droppable").each(function(){
            var name = $(this).data("name");
            $(this).droppable({
                drop: function(event, ui){
                    var $drag = $(ui.draggable),
                        $drop = $(this);
                    if($drop.data("name") !== $drag.html()){
                        $('<div class="incorrect"></div>').css({
                            top: $drop.position().top + $drop.height() / 2 - 128,
                            left: $drop.position().left + $drop.width() / 2 - 128
                        }).insertAfter(event.target).fadeOut(fadeOutTimer, function(){
                            $(this).remove();
                        });
                    }else{
                        $drop.draggable("destroy");
                        $('<div class="correct"></div>').css({
                            top: $drop.position().top + $drop.height() / 2 - 128,
                            left: $drop.position().left + $drop.width() / 2 - 128
                        }).insertAfter(event.target);
                        $drag.fadeOut(fadeOutTimer, function(){
                            $(this).remove();
                        });
                        $(this).parent("li").fadeOut(fadeOutTimer, function(){
                            $(this).remove();
                            reloadMasonry();
                        });
                    }
                }
            });
        });
    };
    var findMatchingDroppableElement = function(name){
        $(".ui-draggable").data("name") === name;
    };
    var play = function(){
        $("body").addClass("playing");
    };
    var quit = function(){
        $("body").removeClass("playing");
    };
    return{
        setup: setup,
        init: init
    };
})();
$(document).ready(function(){
    Peeps.game.setup();
    Peeps.game.init();
});