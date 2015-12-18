$(function(){
  $('.collapsable').click(function(event){
    $(event.target).siblings('ul').toggle();
  });
})
