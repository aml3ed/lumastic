$(document).on('ready turbolinks:load', function() {
    $(".dropdown-trigger").dropdown();
    $('.tabs').tabs();
    $('.tooltipped').tooltip();
    $('select').formSelect();
    M.Modal._count = 0;
    $('.modal').modal();
    $('.collapsible').collapsible();

    $("[data-behavior='sortable']").sortable({
       items: '> a:not(.not-sortable)',
       update:function(e, ui) {
           Rails.ajax({
               url: $(this).data("url"),
               type: "PATCH",
               data: $(this).sortable('serialize')
           });

       }
    });

    elem = document.querySelector('#slide-out');
    instance = new M.Sidenav(elem, {});

});
$(document).on('ready turbolinks:before-cache', function() {
    $(".dropdown-trigger").dropdown();
    $('.tabs').tabs();
    $('.tooltipped').tooltip();
    M.Modal._count = 0;
    $('.modal').modal();
    $('.collapsible').collapsible();


    $('select').formSelect('destroy');


    elem = document.querySelector('#slide-out');
    instance = new M.Sidenav(elem, {});
    instance.destroy();
});

//Load YouTube API
