$(function(){
  $('#search').click(function(){
    document.location.href = "/search/" + $("#name").val();
  });
})
