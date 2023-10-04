var AlertAndMove = function (msg, obj) {
    Swal.fire({
        icon: 'info',
        backdrop: false,
        html: msg,
        heightAuto: false,
    }).then((result) => {
        if (obj) {
          //  var topMenuBarHeight = $('#topMenuBar').height();
           // var bFileInput = obj.is('input[type=file]');
            var scrollTop = obj == null ? 0 : obj.offset().top;
            //bFileInput
            //    ? obj.parent().parent().removeClass('border-0').addClass('border-4 border-danger')
            //    : obj.addClass('border-4 border-danger');

            $('html, body').animate({
                scrollTop: scrollTop 
            }, {
               // duration:1000,
                easing: 'swing',
                complete: function () { 
                    obj.focus();
                    //bFileInput
                    //    ? obj.parent().parent().removeClass('border-4 border-danger').addClass('border-0')
                    //    : obj.removeClass('border-4 border-danger');
                   
                }
            });
        }
    });
};


///////////////////////////////////////////////////// api
var GetInputLabel = function (obj) {
    var sLabel = '';
    var oLabel = obj.prev('label');
    if (oLabel.length > 0) {  ///////// same level architecture
        sLabel = oLabel.text().trim();
    }
    else {
        oLabel = obj.parent().find('label');   /////// label inside parent() node 
        if (oLabel.length > 0) {
            sLabel = oLabel.text().trim();
        }
        else {
            oLabel = obj.parent().prev().find('label');  ///////// label inside prev parent() node 
            if (oLabel.length > 0) {
                sLabel = oLabel.text().trim();
            }
            else {
                oLabel = obj.parent().parent().find('label');
                if (oLabel.length > 0) {
                    sLabel = oLabel.text().trim();
                }
                else {
                    oLabel = obj.parent().parent().parent().find('label');
                    if (oLabel.length > 0) {
                        sLabel = oLabel.text().trim();
                    }
                }
            }
        }
    }
    //  console.log(sLabel);
    if (sLabel == '') sLabel = '必填欄位'; ////////// not found, so set default
    return sLabel;
};

var HasAllRequireValue = function (requiredInputsCollection) {
    var breakOut = false;
    var sLabel = '';
    var msg = '';
    requiredInputsCollection.each(function (index, element) {
        var obj = $(element);
        sLabel = GetInputLabel(obj);

        if (obj.is('input[type=number]')) {
            if (obj.val() <= 0) {
                msg = sLabel + ' 必須大於 0 ';
                AlertAndMove(msg, obj);
                breakOut = true;
                return false;
            }
        }
        else if (obj.is('select')) {
            if (obj.val() == null || obj.val() == "" || obj.val() == "0") {
                msg = '請選擇 ' + sLabel;
                AlertAndMove(msg, obj);
                breakOut = true;
                return false;
            }
        }
        else {  ////////// all input = text, date, file, time...etc
            if (!obj.val().trim()) {
                msg = sLabel + ' 不能空白 ';
                AlertAndMove(msg, obj);
                breakOut = true;
                return false;
            }
        }
    });


    if (breakOut) {
        return false;
    }
    //////////////////// if reach here, has all inputs
    return true;

};





var showModalAjax = function () {
    //console.log('showModalAjax'); 
        jQuery('<div/>', {
            class: 'modalAjax'
        }).append('<i class="fa fa-spinner fa-spin fa-5x fa-fw loading-icon text-primary"></i>')
            .appendTo($('.footer')).show();
    };
    var hideModalAjax = function () {
        console.log('hideModalAjax');
        $('.modalAjax').hide();
    };
    var removeModalAjax = function () {
        console.log('remove');
        $('.modalAjax').remove();
    };
$(function () {
   
    $(document).on({
        ajaxStart: function () {
          showModalAjax();
        }
        ,
        ajaxStop: function () {
             hideModalAjax();
        }
    });

    $(window).bind("pageshow", function (event) {
          console.log('pageshow');
       removeModalAjax();
    });




        $(window).resize(function () {
            $('#backtotop').addClass('d-none');

        });

        $(window).scroll(function () {
            //////////// back to top 
            var scrollVal = $(this).scrollTop();
            if (scrollVal > 250) {
                $('#backtotop').removeClass('d-none');
            }
            else {
                $('#backtotop').addClass('d-none');
            }
        });

        $(document).on('click', '#backtotop', function (e) {
            e.preventDefault(); 
            MoveToTop();
        });




});

 

