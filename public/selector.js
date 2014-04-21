var holder;

function create_button(label, next_level){
    var button_holder = $('<div class="col-md-3" style="text-align: center; margin-bottom: 10px;"></div>');
    var button = $('<button class="btn btn-primary btn-block">' + label + '</button>');
    button_holder.append(button);

    if (next_level['description']){
        button.attr('data-toggle','tooltip')
        button.attr('data-placement','bottom')
        button.attr('title',next_level['description'])
        button.tooltip();
    }

    button_holder.click(function(){
        if (next_level['description'] == undefined){
            holder.empty();
            render_selectors_for(next_level);
        }else{
            window.location.href = '/graph/' + label
        }
    });
    return  button_holder;
}

function render_selectors_for(hierarchy){
    console.log(hierarchy);

    $.each(hierarchy, function (item, child){
        holder.append(create_button(item, child));
    })
}

$(function(){
    holder = $('#selector');
    holder.tooltip();
    render_selectors_for(category_data);
})
