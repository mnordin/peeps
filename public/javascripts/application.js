$(document).ready(function(){

    // removes utf-8 input
    $("form#change-office input[type=hidden]").remove();

    $("select#office").change(function(){
        $(this).parents("form").submit();
    });
    
});
