$(document).ready(function () {
   $(".movie-row").each(function () {
       var title = $(this).data('title');
       var selector = $(this);

       $.ajax({
           url: "/external_api/movies",
           type: "get",
           dataType: "json",
           data: { title: title }
       }).done(function (resp) {
           selector.find("img.poster").attr("src", resp.img_url);
           selector.find(".plot").text(resp.plot);
           selector.find(".rating").text(resp.rating);
       })
   });
});