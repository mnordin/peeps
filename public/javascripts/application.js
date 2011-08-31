$(document).ready(function(){
    $("#edit-profile").click(function(evt){
        evt.preventDefault();
        $("#edit").fadeIn(500);
        $.get("/users/me/edit/#content", function(data){
            $("#edit").append(data);
        });
    });
});