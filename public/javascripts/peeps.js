var Peeps;
if(!Peeps){
    Peeps = {};
};

Peeps.game = (function(){
    var setup = function(parent){
        parent.imagesLoaded(function(){
            parent.masonry({
                itemSelector : 'li',
                columnWidth : 20
            });
        });
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
                        $drag.addClass("incorrect");
                    }else{
                        $drag.addClass("correct");
                        $(this).after($drag.css({
                            zIndex: 10,
                            top: $(this).position().top + $(this).height()/2 - $drag.height()/2,
                            left: $(this).position().left + $(this).width()/2 - $drag.width()/2
                        }).draggable("destroy"));
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
    Peeps.game.setup($('#peeps'));
    Peeps.game.init();
});