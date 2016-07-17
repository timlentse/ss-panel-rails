function login(){
  $(".error").remove();
  var email = $("#email").val();
  var password = $("#password").val();
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
  var user_name = $("#user_name").val();
  var email = $("#email").val();
  var password = $("#password").val();
  var invited_code = $("#invited_code").val();
  if (password.length==0){
    insertError("#submit","密码不能为空");
  } else if ($("#password_comfirm").val()==password){
    $("#submit").html("正在发送注册邮件...");
    $.post("/register", {"user_name":user_name, "email":email, "password":password, "invited_code": invited_code},function(data){
      if (data["code"]==1){
        window.location.href="/login";
      } else {
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
  var email = $("#email").val();
  $("#submit").html("正在发送重置邮件...");
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
  var password = $("#password").val();
  var current_url = window.location.href;
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
