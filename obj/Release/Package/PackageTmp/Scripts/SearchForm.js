
   
    $(document).on('click', '.btn_DeleteActivity, #btn_DeleteActivity', function (e) {
        e.preventDefault();
     
        var btn = $(this);
        var guid = btn.attr('guid');
        var target = btn.attr('data-target'); 
        var activity = btn.closest('tr').find('.activity').text();
       
        Swal.fire({
            title: 'Are you sure?',
            text: "確定要刪除 " + activity,
        //    type: 'warning',
            icon: 'question',
            showCancelButton: true,
            //confirmButtonColor: '#3085d6',
            //cancelButtonColor: '#d33',
            confirmButtonText: 'Yes'
        }).then((result) => {
            if (result.isConfirmed) { 
             
                $.ajax({
                    url: target,
                    data: {
                        guid: guid
                    },
                    type: 'post',
                    success: function (response, textStatus, jqXHR) { 
                        //console.log('deleted');
                        ShowToast(activity + ' 刪除成功!');
                       // btn.closest('tr').remove(); 
                        btn.removeClass('btn_DeleteActivity').attr('disabled', 'disabled');
                    }
                });
            } 
        }); 
    }); 
 

var HeaderSort = function (oTable, oForm) {
    oTable.on('click', 'th a', function (e) {
        e.preventDefault();
        var nthTh = $(this).parent().index() + 1;
        var oOrderIndex = $(oForm).find('#OrderIndex').first();
        var OrderIndex = oOrderIndex.val();

        if (Math.abs(OrderIndex) == Math.abs(nthTh))  //// same col
        {
            oOrderIndex.val(OrderIndex * (-1));
        }
        else {
            oOrderIndex.val(nthTh);
        }
        oForm.submit();
    });
};

var OrderArrow = function (oTable, oForm) {
    var oOrderIndex = $(oForm).find('#OrderIndex');
    var OrderIndex = oOrderIndex.val();
    var nthCol = Math.abs(OrderIndex) - 1;
    ///////// if nthCol <0, aTag will be the last a tag
    var aTag = oTable.find('th').eq(nthCol).find('a').first();
    console.log(nthCol);
    console.log(aTag);
    if (aTag.length > 0) {
        OrderIndex > 0
            ? aTag.parent().append('<i class="fas fa-long-arrow-alt-up mx-1"  style="color: #197584"></i>')
            : aTag.parent().append('<i class="fas fa-long-arrow-alt-down mx-1"  style="color: #197584"></i>')
            ;
    }
};
var MoveToTop = function (callback) {
    //let url = window.location.href;
    //console.log(url);
    //let isri0005 = false;
    //let target = 0;
    //if (url.toLowerCase().indexOf('isri0005')>0) {
    //  //  target = $('#divTool').offset().top;
    //    isri0005 = true;
    //}

   // console.log(target);
    $('html, body').animate({
        scrollTop: 0
    }, {
        duration: 500,
        complete: function () {
            $('#backtotop').addClass('d-none');
            //if (isri0005) {
            //    $('html, body').animate({
            //        scrollTop: $('#divTool').offset().top
            //    }, 0);
            //}
            if (callback) {
                callback();
            }
        }
    });
};

var MoveTo = function (target, adjustment, callback) {
     
    var scrollTop = target == null ? 0 : target.offset().top;
   
    if (adjustment != null) scrollTop += adjustment;
    target.addClass('searched');
    $('html, body').animate({ 
        scrollTop: scrollTop   
    }, { 
        easing: 'swing', 
        complete: function () {
            if (callback) {
                callback();
            }  
            target.delay(5000).queue(function () {
                target.removeClass('searched').dequeue();
            });
        } 
    }); 
};

var ShowToast = function (msg) {
    $(".toast-body").empty().append(msg);
    $(".toast").toast({ delay: 2000 }).toast('show');
}

 



