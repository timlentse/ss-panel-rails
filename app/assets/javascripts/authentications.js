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
  user_name = $("#user_name").val();
  email = $("#email").val();
  password = $("#password").val();
  if ($("#password_comfirm").val()==password){
    $.post("/register", {"user_name":user_name, "email":email, "password":password},function(data){
      if (data["code"]==1){
        window.location.href="/login";
      }
      else {
        insertError("#submit",data["msg"]);
      }
    })
  } else {
    insertError("#submit","两次密码不一致");
  }
}
function resetPassword(){
  $(".error").remove();
  email = $("#email").val();
  $.post("/password/reset", {"email":email},function(data){
    if (data["code"]==1){
      insertSuccess("#submit",data["msg"]);
    } else{
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
