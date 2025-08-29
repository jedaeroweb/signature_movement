var ready=function(){
    $('.btn-modal').click(btn_modal_click);

    function btn_modal_click(event) {
        event.preventDefault();

        var url = $(this).attr('href');
        url += (url.indexOf('?') === -1 ? '?popup=true' : '&popup=true');

        $('#myModal').load(url, function () {
            let myModal = new bootstrap.Modal(document.getElementById('myModal'));
            myModal.show();
        });

        return false;
    }

    // 페이지 로드 시 체크박스 해제
    $("#user_remember_me").prop("checked", false);

    $("#user_remember_me").change(function(){
        if ($(this).is(':checked')) {
            const confirmed = confirm("1달간 로그인이 유지 됩니다. 공공장소 PC에서 사용 주의\n  로그인 정보 기억하시겠습니까?");
            if (!confirmed) {
                $(this).prop('checked', false); // 취소 시 체크 해제
            }
        }
    });

    var mobile_menu=1;
    var csrf_token=$('meta[name="csrf-token"]').attr('content');

    $('.custom-file-input').on('change', function() {
        let fileName = $(this).val().split('\\').pop();
        $(this).next('.custom-file-label').addClass("selected").html(fileName);
    });

    $('#no-sns-id').click(function(){
        $("#no-sns-login").show();
        $("#sns-login,#no-sns-id").hide();
        $("#no-sns-id").parent().hide();
    });

    function vote_click(){
        if($(this).find('span.already-vote').length) {
            alert('이미 투표하셨습니다.');
            return false;
        }

        var vote_link=$(this);
        // alert(vote_link.attr('href')+'.json')

        $.post(vote_link.attr('href')+'.json',{'_method':'put','authenticity_token':csrf_token},function(data){
            if(data.vote_up) {
                vote_link.find('span:first').addClass('already-vote');
                vote_link.find('span.text').text(' '+data.vote_up);
            } else {

            }
        },'json');
        return false;
    }

    function confirm_login_click(){
        if(confirm("로그인후에 사용가능합니다.\n지금 로그인 하시겠습니까?")) {
            location.href='/users/login';
        } else {
            return false;
        }
        return false;
    }

    // $('#sign_now').popover();

    $('#main_main nav li a').click(function(){
        var param='no_layout=true&no_nav=true';
        var tab=$.uri.setUri($(this).attr('href')).param("tab");

        if(tab) {
            param+='&tab='+tab;
        }

        var this_link=$(this);
        $('#main_layer').load('/home?'+param,function(){
            $('#main_main nav li a').removeClass('active');
            this_link.addClass('active');
            $('.vote a:not(".confirm_login")').click(vote_click);
            $('.confirm_login').click(confirm_login_click);
        });

        if (history && history.pushState) {
            history.pushState('','tab_'+tab,'/?tab='+tab);
        }

        return false;
    });

    $('.vote a:not(".confirm_login")').click(vote_click);
    $('.confirm_login').click(confirm_login_click);



    $(".comment_form_only").click(function(){
        if($(this).parent().find('.comment_layer').length) {
            var comment_layer=$(this).parent().find('.comment_layer');
            if(comment_layer.is(':visible')) {
                comment_layer.slideUp();
            } else {
                comment_layer.slideDown();
            }
        } else {
            var mb=$(this).parent();
            var uid=$(this).parent().find('a:first').attr('href').split('/').pop();

            mb.append($('<div class="comment_layer"><div class="comment_form"></div><div class="comment_list"></div></div>'));
            mb.find('.comment_form').load($(this).attr('href')+'?no_layout=true',function(){
                $(this).find('form').submit(comment_form_submit);
            });
        }
        return false;
    });

    $(".comment_form_with_list").click(function(){
        if($(this).parent().find('.comment_layer').length) {
            var comment_layer=$(this).parent().find('.comment_layer');
            if(comment_layer.is(':visible')) {
                comment_layer.slideUp();
            } else {
                comment_layer.slideDown();
            }
        } else {
            var mb=$(this).parent();
            var uid=$(this).parent().find('a:first').attr('href').split('/').pop();

            mb.append($('<div class="comment_layer"><div class="comment_form"></div><div class="comment_list"></div></div>'));

            mb.find('.comment_form').load($(this).attr('href')+'?no_layout=true',function(){
                mb.find('.login_confirm').focus(function(){
                    $(this).blur();
                    if(confirm("로그인후에 사용가능합니다.\n지금 로그인 하시겠습니까?")) {
                        window.open($("#user_login_path").val()+'?popup=true',"","width=450, height=420, resizable=no, scrollbars=no, status=no;");
                    } else {
                        return false;
                    }
                });

                $(this).find('form').submit(comment_form_submit);
            });

            $.getJSON($(this).parent().find('a:first').attr('href')+'.json',function(data){
                if(data.length) {
                    $.each(data,function(index,value) {
                        mb.find('.comment_list').append($('<h5>'+value.username+'</h5><div class="comment">'+nl2br(value.comment)+'</div>'));
                    });
                }
            });
        }
        return false;
    });

    function comment_form_submit(e){
        e.preventDefault();

        var comment=$(this).find('textarea').val();

        if($.trim(comment) == '') {
            alert('댓글을 써주세요');
            $(this).find('textarea').focus();
            return false;
        }

        var mb=$(this).parent().parent().parent();

        $.post($(this).attr('action')+'.json',{'id':$(this).find('input[name="id"]').val(),'authenticity_token':csrf_token,'comment[comment]':comment},function(data){
            mb.find('textarea').val('');
            var new_comment=$('<h5>'+$("#username").text()+'</h5><div class="comment">'+nl2br(comment)+'</div>');
            mb.find('.comment_list').append(new_comment);
            new_comment.highlight();
        });
    }

    $("#new_user").submit(function(){
        var imgSize=$('#user_photo')[0].files[0].size;

        if(imgSize > (1 * 1024 * 1024)) {
            alert("첨부 이미지 파일은 1MB 이하여야 합니다.");
            return false;
        }

        if($.trim($("#user_url").val())=='https://' || $.trim($("#user_url").val())=='http://') {
            $("#user_url").val('');
        }

        return true;
    });

    $("#user_url").focus(function(){
        if($.trim($(this).val())=='') {
            $(this).val('https://');
        }
    });

    $("#mobile_menu").click(function(){
        if(mobile_menu) {
            $('.side_nav').animate({'left':'0'}, 400, 'easeOutCubic');
            mobile_menu=0;
        } else {
            $('.side_nav').animate({'left':'-500px'}, 400, 'easeInOutCubic');
            mobile_menu=1;
        }
    });
};

function nl2br (str, is_xhtml) {
    var breakTag = (is_xhtml || typeof is_xhtml === 'undefined') ? '<br ' + '/>' : '<br>';
    return (str + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1' + breakTag + '$2');
}

document.addEventListener("turbo:load", ready);
