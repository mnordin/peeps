$(document).ready(function(){
    
    $("select#office").change(function(){
        $(this).parents("form").submit();
    });
    
});
