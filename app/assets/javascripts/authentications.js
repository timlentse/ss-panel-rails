function login(){
  $(".error").remove();
  email = $("#email").val();
  password = $("#password").val();
  $.post("/login", {"email":email, "password":password},function(data){
    if (data["code"]==1){
      window.location.href="/user";
    }
    else {
      insertError("#submit",data["msg"]);
    }
  })
}
function register(){
  $(".error").remove();
  $("#submit").html("正在发送注册邮件...");
  user_name = $("#user_name").val();
  email = $("#email").val();
  password = $("#password").val();
  if ($("#password_comfirm").val()==password){
    $.post("/register", {"user_name":user_name, "email":email, "password":password},function(data){
      if (data["code"]==1){
        $("#submit").html("注册");
        window.location.href="/login";
      }
      else {
        $("#submit").html("注册");
        insertError("#submit",data["msg"]);
      }
    })
  } else {
    $("#submit").html("注册");
    insertError("#submit","两次密码不一致");
  }
}
function resetPassword(){
  $(".error").remove();
  $("#submit").html("正在发送重置邮件...");
  email = $("#email").val();
  $.post("/password/reset", {"email":email},function(data){
    if (data["code"]==1){
      $("#submit").html("重置密码");
      insertSuccess("#submit",data["msg"]);
    } else{
      $("#submit").html("重置密码");
      insertError("#submit",data["msg"]);
    }
  })
}
function submitReset(){
  $(".error").remove();
  password = $("#password").val();
  current_url = window.location.href;
  $.post(current_url,{"password": password},function(data){
    if (data["code"]==1){
      insertSuccess("#submit", data["msg"]+" 即将跳转...");
      setTimeout(function() {
        window.location.href = "/login";
      }, 2000);
    } else {
      insertError("#submit", data["msg"]);
    }
  })
}
