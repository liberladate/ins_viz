var holder;

function create_button(label, next_level){
    var button = $('<div class="col-md-3" style="text-align: center; margin-bottom: 10px;"><button class="btn btn-primary btn-block">' + label + '</button></div>');
    button.click(function(){
        if (next_level['description'] == undefined){
            holder.empty();
            render_selectors_for(next_level);
        }else{
            window.location.href = '/graph/' + label
        }
    });
    return  button;
}

function render_selectors_for(hierarchy){
    console.log(hierarchy);

    $.each(hierarchy, function (item, child){
        holder.append(create_button(item, child));
    })
}

holder = $('#selector');
render_selectors_for(category_data);