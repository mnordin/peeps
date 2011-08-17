var Peeps;
if(!Peeps){
    Peeps = {};
};

Peeps.game = (function(){
    var init = function(){
        $(".ui-draggable").draggable({
            cursor: "move"
        });
        $(".ui-droppable").each(function(){
            var name = $(this).data("name");
            $(this).droppable({
                accept: findMatchingDroppableElement(name),
                drop: function(event, ui){
                    $(this).addClass("correct");
                    console.log("CORRECT!");
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
    var guess = function(draggable, droppable){
        console.log("dropped!");
        if(droppable.data("name") === droppable.html()){
            console.log("correct!");
            return true;
        };
    };
    var quit = function(){
        $("body").removeClass("playing");
    };
    return{
        init: init
    };
})();
$(document).ready(function(){
    Peeps.game.init();
    console.log($("#peeps").find($(".ui-draggable:contains('Markus Nordin')")));
});