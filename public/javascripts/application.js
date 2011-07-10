var currentFirstName;
var currentPeepImage;
var peeps = [];

function play(){
    $("body").addClass("playing");
    $("#guess").focus();

    shuffle();
    changePeep(); // sets up the first peep as well as changes it later on
};

function shuffle(){
    $("ul#peeps li img").each(function(){
       peeps.push([$(this).data("first-name"), $(this).attr("src")]);
    });
    // randomize the array
    //return peeps.sort(Math.round(Math.random())-0.5);    FF5 SAYS THIS IS INVALID
};

function changePeep(){
    currentFirstName = peeps[0][0].toLowerCase();
    currentPeepImage = peeps[0][1];
    $("#currentPeepImage").attr("src", peeps[0][1]);
}

function guess(){
    guessed_name = $("#guess").val();
    if(guessed_name.toLowerCase().match(currentFirstName)){
        success();
    };
}

function success(){
    //removes the first element in the array
    peeps.splice(0,1);
    //console.log("SUCCESS! " + guessed_name + " WAS CORRECT!");
    $("#guess").val("");
    changePeep();
}

function quit(){
    $("body").removeClass("playing");
}

$(document).ready(function(){
    $("#play").click(function(ev){
        play();
        ev.preventDefault();
    });
    $("#quit-playing").click(function(ev){
        quit();
        ev.preventDefault();
    });
    $("#guess-form").submit(function(ev){
        guess();
        ev.preventDefault();
    });
});