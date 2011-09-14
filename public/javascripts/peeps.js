var Peeps;
if(!Peeps){
    Peeps = {};
};

Peeps.game = (function(){
    var fadeOutTimer = 750;
    var timer;
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

        $("a.show-highscore").click(function(e){
            e.preventDefault();
            showHighscore();
        });
    };
    var reloadMasonry = function(){
        $("#peeps").masonry("reload");
    };
    var init = function(){
        $(".ui-draggable").draggable({
            cursor: "move",
            drag: function(event, ui){
                $(this).clone();
                $(this).css({visibility:"hidden"});
            },
            stop: function(event, ui){
                $(this).css({visibility:"visible"});
            },
            revert: "valid",
            helper: "clone",
            revert: true
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
                        $drag.remove();
                        $(".ui-draggable-dragging:last").remove();
                        $drop.draggable("destroy");
                        $('<div class="correct"></div>').css({
                            top: $drop.position().top + $drop.height() / 2 - 128,
                            left: $drop.position().left + $drop.width() / 2 - 128
                        }).insertAfter(event.target);
                        $(this).parent("li").fadeOut(fadeOutTimer, function(){
                            $(this).remove();
                            reloadMasonry();
                            // submit score if there are no more users left
                            if($(".ui-droppable").length === 0){
                                submitScore();
                                // waits three second to make sure the new score is saved first
                                timer = setTimeout(showHighscore(),3000);
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
    var showHighscore = function(){
        var correct = parseInt($("input#score_correct_peeps").val());
        var incorrect = parseInt($("input#score_incorrect_peeps").val());
        $("#win").fadeIn(fadeOutTimer);
        $("#win .correct_peeps").html(correct);
        $("#win .incorrect_peeps").html(incorrect);
        $("#win .total_score").html(correct - incorrect);
        var office = $("#office-from-param").html();
        updateHighscore(office);
        clearTimeout(timer);
    };

    var updateHighscore = function(office){
        $.getJSON("/score/highscore/" + office, function(data) {
            var items = [];
            for(var i = 0; i < data.length; i++){
                var photo_url = data[i][1].user.photo_url;
                var name = data[i][1].user.first_name + " " + data[i][1].user.last_name;
                var total_score = data[i][0].score.total_score;
                items.push('<tr><td align="left"><div class="avatar-wrapper"><img src="' + photo_url + '" class="avatar" /></div><p>' + name + '</p></td><td align="right"><p>' + total_score + '</p></td></tr>');
            };
            $(items.join('')).appendTo("table.highscore tbody");
        });
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