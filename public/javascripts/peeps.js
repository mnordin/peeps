var Peeps;
if(!Peeps){
    Peeps = {};
};

Peeps.game = (function(){
    var fadeOutTimer = 750;
    var setup = function(){
        $("#peeps").imagesLoaded(function(){
            $("#peeps").masonry({
                itemSelector : 'li',
                columnWidth : 20
            });
        });

        $("form#submit-score").submit(function(evt){
            evt.preventDefault();
            var form = $(this);
            $.ajax({
                type: 'POST',
                data: form.serialize(),
                url: form.attr("action"),
                dataType: "json"
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
                        incorrectGuess();
                        $('<div class="incorrect"></div>').css({
                            top: $drop.position().top + $drop.height() / 2 - 128,
                            left: $drop.position().left + $drop.width() / 2 - 128
                        }).insertAfter(event.target).fadeOut(fadeOutTimer, function(){
                            $(this).remove();
                        });
                    }else{
                        correctGuess();
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
                            // submit score if there are no more users left
                            if($(".ui-droppable").length === 0){
                                submitScore();
                                showWinning();
                            }
                        });
                    }
                }
            });
        });
    };
    var incorrectGuess = function(){
        score = parseInt($("input#score_incorrect_peeps").val());
        $("input#score_incorrect_peeps").val(score + 1);
    };
    var correctGuess = function(){
        score = parseInt($("input#score_correct_peeps").val());
        $("input#score_correct_peeps").val(score + 1);
    };
    var findMatchingDroppableElement = function(name){
        $(".ui-draggable").data("name") === name;
    };
    var play = function(){
        $("body").addClass("playing");
    };
    var submitScore = function(){
        var correct = parseInt($("input#score_correct_peeps").val());
        var incorrect = parseInt($("input#score_incorrect_peeps").val());
        $("input#score_total_score").val(correct - incorrect);
        $("form#submit-score input[type=submit]").click();
    };
    var quit = function(){
        $("body").removeClass("playing");
    };
    var showWinning = function(){
        var correct = parseInt($("input#score_correct_peeps").val());
        var incorrect = parseInt($("input#score_incorrect_peeps").val());
        $("#win").fadeIn(fadeOutTimer);
        $("#win .correct_peeps").html(correct);
        $("#win .incorrect_peeps").html(incorrect);
        $("#win .total_score").html(correct - incorrect);
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