function insertSuccess(btn,msg){
  $(".error").remove();
  if ($(".success").length==0){
    var content = '<p class="success"><i class="fa fa-check"></i>'+msg+'</p>';
    $(content).insertBefore(btn);
  }else{
    var html_content = '<i class="fa fa-check"></i>'+msg;
    $(".success").html(html_content);
  }
  $(".success").fadeOut(5000,function() { $(this).remove(); });
}

function insertError(btn,msg){
  $(".success").remove();
  if ($(".error").length==0){
    var content = '<p class="error"><i class="fa fa-close"></i>'+msg+'</p>';
    $(content).insertBefore(btn);
  }else{
    var html_content = '<i class="fa fa-close"></i>'+msg;
    $(".error").html(html_content);
  }
}

function changePassword(){
  $(".error").remove();
  var original_password = $("#original_password").val();
  var password = $("#password").val();
  if ($("#password_comfirm").val()==password){
    $.post("/user/password", {"original":original_password, "password":password},function(data){
      if (data["code"]==1){
        insertSuccess('#change-pass',data["msg"]);
      }
      else {
        insertError('#change-pass',data["msg"]);
      }
    })
  } else {
    insertError('#change-pass',"两次密码不一致");
  }
}

function changeConnectPassword(){
  $(".error").remove();
  var password = $("#connect_password").val();
  $.post("/user/connectPassword", {"password":password},function(data){
    if (data["code"]==1){
      insertSuccess("#change-connect",data["msg"]);
    }
    else {
      insertError("#change-connect",data["msg"]);
    }
  })
}

function changeUserName(){
  $(".error").remove();
  var username = $("#name").val();
  $.post("/user/change_username", {"user_name":username},function(data){
    if (data["code"]==1){
      $("#username").html(username);
      insertSuccess("#change-username",data["msg"]);
    }
    else {
      insertError("#change-username",data["msg"]);
    }
  })
}

function generateInvite(){
  var num = $("#num").val();
  $("#generate").html('<i class="fa fa-spinner fa-spin"></i> 正在生成');
  $.post("/admin/invite",{"num": num}, function(data){
    $("#generate").html('生成');
  })
}
