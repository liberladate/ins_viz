$(function(){
    console.log('in ready');
    $('#query_btn').click(function(){
        console.log('in click');
        var columns = $('#select-area').find('.column_select');
        var query = [];

        columns.each(function(index, column){
            console.log($(column).find('select option:selected').text());
            var column_name = $($(column).find('.column_name')).text();
            var column_value = $(column).find('select option:selected').text();
            query.push(column_name+"="+column_value);
        })


        var query_string = query.join('&');

        console.log(query_string);

        var location = window.location.href;
        var parts = location.split('?');

        if (parts.length>1){
            parts[parts.length-1]=query_string;
        }
        else{
            parts.push(query_string);
        }

        window.location.href = parts.join('?')
    });
})