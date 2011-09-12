$(document).ready(function(){

    // removes utf-8 input
    $("form#change-office input[type=hidden]").remove();

    $("select#office").change(function(){
        $(this).parents("form").submit();
    });

    var namesWrapperOffsetTop = $("#names-wrapper").offset().top;
    $("#names-wrapper").height($(window).height() - namesWrapperOffsetTop - 40);
    $(window).resize(function(){
       $("#names-wrapper").height($(window).height() - namesWrapperOffsetTop - 40);
    });

});
