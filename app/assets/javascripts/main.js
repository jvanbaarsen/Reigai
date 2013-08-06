/*
 *  Document   : main.js
 *  Author     : pixelcave
 *  Description: Custom scripts and plugin initializations
 */

var webApp = function() {

    /* Initialization UI Code */
    var uiInit = function () {

        // Add the  correct copyright year at the footer
        var yearCopy = $('#year-copy'),
            d = new Date();

        if (d.getFullYear() === 2013) {
            yearCopy.html('2013');
        } else {
            yearCopy.html('2013-' + d.getFullYear());
        }

        // Set min-height to #page-content, so that footer is visible at the bottom if there is not enough content
        var pageContent = $('#page-content');

        pageContent.css('min-height', $(window).height() -
            ($('header').height() + parseInt(pageContent.css('padding-top'))*2 + $('footer').outerHeight()) + 'px');

        $(window).resize(function() {
            pageContent.css('min-height', $(window).height() -
                ($('header').height() + parseInt(pageContent.css('padding-top'))*2 + $('footer').outerHeight()) + 'px');
        });

        // If .navbar-fixed class added to <header>, add padding to the page-container
        if ($('header').hasClass('navbar-fixed-top')) {
            $('#page-container').css('padding', '40px 0 0');
        } else if ($('header').hasClass('navbar-fixed-bottom')) {
            $('#page-container').css('padding', '0 0 40px');
        }

        // Select all checkboxes in tables
        $('thead input:checkbox').click(function(e) {
            var table = $(e.target).closest('table');
            $('tbody input:checkbox', table).attr('checked', e.target.checked);
        });

        // Initialize tabs
        $('[data-toggle="tabs"] a').click(function (e) {
            e.preventDefault();
            $(this).tab('show');
        });

        // Gallery hover options functionality
        $('[data-toggle="gallery-options"] > li')
           .mouseover(function(){
                $(this).find('.thumbnails-options').show();
            }).mouseout(function(){
                $(this).find('.thumbnails-options').hide();
        });

        // Initialize Slimscroll
        $('.scrollable').slimScroll({ height: '100px' });
        $('.scrollable-tile').slimScroll({ height: '130px' });
        $('.scrollable-tile-2x').slimScroll({ height: '330px' });

        // Initialize Tooltips
        $('[data-toggle="tooltip"]').tooltip({ container: 'body', animation: false });

        // Initialize Popovers
        $('[data-toggle="popover"]').popover({ container: 'body', animation: false });

        // Initialize Chosen
        $(".select-chosen").chosen();

        // Initialize Bootstrap switch
        $('.input-switch').bootstrapSwitch();

        // Initialize elastic
        $('textarea.textarea-elastic').elastic();

        // Initialize wysihtml5
        $('textarea.textarea-editor').wysihtml5();

        // Initialize Colorpicker
        $('.input-colorpicker').colorpicker();

        // Initialize TimePicker
        $('.input-timepicker').timepicker();

        // Initialize DatePicker
        $('.input-datepicker').datepicker();

        // Initialize DateRangePicker
        $('.input-daterangepicker').daterangepicker();
    };

    /* Primary navigation functionality */
    var primaryNav = function () {

        // Get all primary navigation top links
        var menuLinks = $('#primary-nav > ul > li > a');

        // Initialize submenu number idicators
        menuLinks.filter(function(){ return $(this).next().is('ul'); }).each(function(n, e){
            $(e).append('<span>' + $(e).next('ul').children().length + '</span>');
        });

        // Accordion functionality
        menuLinks.click(function(){

            var link = $(this);

            if (link.next('ul').length > 0) {
                if (link.parent().hasClass('active') !== true) {
                    if (link.hasClass('open')) {
                        link.removeClass('open').next().slideUp(250);
                    }
                    else {
                        $('#primary-nav li > a.open').removeClass('open').next().slideUp(250);
                        link.addClass('open').next().slideDown(250);
                    }
                }

                return false;
            }

            return true;
        });
    };

    /* Scroll to top link */
    var scrollToTop = function() {

        // Get link
        var link = $('#to-top');

        $(window).scroll(function(){

            // If the user scrolled a bit (150 pixels) show the link
            if ($(this).scrollTop() > 150) {
                link.fadeIn(150);
            } else {
                link.fadeOut(150);
            }
        });

        // On click get to top
        link.click(function(){
            $("html, body").animate({ scrollTop: 0 }, 300);
            return false;
        });
    };

    /* Datatables Bootstrap integration, http://datatables.net/blog/Twitter_Bootstrap_2 */
    var dtIntegration = function() {

        // Set the defaults for DataTables initialization
        $.extend( true, $.fn.dataTable.defaults, {
            "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span5'i><'span7'p>>",
            "sPaginationType": "bootstrap",
            "oLanguage": {
                "sLengthMenu": "_MENU_",
                "sSearch": "<div class=\"input-prepend\"><span class=\"add-on\"><i class=\"icon-search\"></i></span>_INPUT_</div>",
                "sInfo": "<strong>_START_</strong>-<strong>_END_</strong> of <strong>_TOTAL_</strong>",
                "oPaginate": {
                    "sPrevious": "",
                    "sNext": ""
                }
            }
        } );

        // Default class modification
        $.extend( $.fn.dataTableExt.oStdClasses, {
            "sWrapper": "dataTables_wrapper form-inline"
        });

        // API method to get paging information
        $.fn.dataTableExt.oApi.fnPagingInfo = function ( oSettings )
        {
            return {
                "iStart":         oSettings._iDisplayStart,
                "iEnd":           oSettings.fnDisplayEnd(),
                "iLength":        oSettings._iDisplayLength,
                "iTotal":         oSettings.fnRecordsTotal(),
                "iFilteredTotal": oSettings.fnRecordsDisplay(),
                "iPage":          Math.ceil( oSettings._iDisplayStart / oSettings._iDisplayLength ),
                "iTotalPages":    Math.ceil( oSettings.fnRecordsDisplay() / oSettings._iDisplayLength )
            };
        };

        // Bootstrap style pagination control
        $.extend( $.fn.dataTableExt.oPagination, {
            "bootstrap": {
                "fnInit": function( oSettings, nPaging, fnDraw ) {
                    var oLang = oSettings.oLanguage.oPaginate;
                    var fnClickHandler = function ( e ) {
                        e.preventDefault();
                        if ( oSettings.oApi._fnPageChange(oSettings, e.data.action) ) {
                            fnDraw( oSettings );
                        }
                    };

                    $(nPaging).addClass('pagination').append(
                        '<ul>'+
                            '<li class="prev disabled"><a href="javascript:void(0)"><i class="icon-chevron-left"></i> '+oLang.sPrevious+'</a></li>'+
                            '<li class="next disabled"><a href="javascript:void(0)">'+oLang.sNext+' <i class="icon-chevron-right"></i></a></li>'+
                        '</ul>'
                    );
                    var els = $('a', nPaging);
                    $(els[0]).bind( 'click.DT', { action: "previous" }, fnClickHandler );
                    $(els[1]).bind( 'click.DT', { action: "next" }, fnClickHandler );
                },

                "fnUpdate": function ( oSettings, fnDraw ) {
                    var iListLength = 5;
                    var oPaging = oSettings.oInstance.fnPagingInfo();
                    var an = oSettings.aanFeatures.p;
                    var i, j, sClass, iStart, iEnd, iHalf=Math.floor(iListLength/2);

                    if ( oPaging.iTotalPages < iListLength) {
                        iStart = 1;
                        iEnd = oPaging.iTotalPages;
                    }
                    else if ( oPaging.iPage <= iHalf ) {
                        iStart = 1;
                        iEnd = iListLength;
                    } else if ( oPaging.iPage >= (oPaging.iTotalPages-iHalf) ) {
                        iStart = oPaging.iTotalPages - iListLength + 1;
                        iEnd = oPaging.iTotalPages;
                    } else {
                        iStart = oPaging.iPage - iHalf + 1;
                        iEnd = iStart + iListLength - 1;
                    }

                    for ( i=0, iLen=an.length ; i<iLen ; i++ ) {
                        // Remove the middle elements
                        $('li:gt(0)', an[i]).filter(':not(:last)').remove();

                        // Add the new list items and their event handlers
                        for ( j=iStart ; j<=iEnd ; j++ ) {
                            sClass = (j===oPaging.iPage+1) ? 'class="active"' : '';
                            $('<li '+sClass+'><a href="javascript:void(0)">'+j+'</a></li>')
                                .insertBefore( $('li:last', an[i])[0] )
                                .bind('click', function (e) {
                                    e.preventDefault();
                                    oSettings._iDisplayStart = (parseInt($('a', this).text(),10)-1) * oPaging.iLength;
                                    fnDraw( oSettings );
                                } );
                        }

                        // Add / remove disabled classes from the static elements
                        if ( oPaging.iPage === 0 ) {
                            $('li:first', an[i]).addClass('disabled');
                        } else {
                            $('li:first', an[i]).removeClass('disabled');
                        }

                        if ( oPaging.iPage === oPaging.iTotalPages-1 || oPaging.iTotalPages === 0 ) {
                            $('li:last', an[i]).addClass('disabled');
                        } else {
                            $('li:last', an[i]).removeClass('disabled');
                        }
                    }
                }
            }
        });
    };

    return {

        init: function () {
            uiInit(); // Initialize UI Code
            primaryNav(); // Primary Navigation functionality
            scrollToTop(); // Scroll to top functionality
            dtIntegration(); // Datatables Bootstrap integration
        }
    };
}();

/* Initialize WebApp when page loads */
$(function(){ webApp.init(); });
