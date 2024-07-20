<%-- 
    Document   : ChangePassword
    Created on : May 23, 2024, 8:58:50 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico"> 
        <title>Change Password</title>
        <link rel="stylesheet" href="View/CSS/forgetpassword.css" /> 
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>
    <body>
        <div class="login-container">
            <div class="login-box"> 
                <h1>Đổi mật khẩu</h1> 
                <form action="changepassword" method="post">
                    <div class="input-group"> 
                        <input id="newpass" name="password" type="password" placeholder="Nhập mật khẩu mới" required />
                        <input id="confirm-pass" type="password" placeholder="Xác thực mật khẩu" required />
                    </div> 
                    <div style="font-size: 20px;color: red;"> 
                        <p id="message" ></p>
                    </div>
                    <div class="button-group"> 
                        <button id="confirmButton" type="submit" class="sell-btn">Xác nhận</button>
                    </div> 
                </form>
            </div>
        </div> 
        <script>
            document.getElementById('confirm-pass').addEventListener('input', function() {  
                var newpass = document.getElementById('newpass').value;
                var confirmPass = document.getElementById('confirm-pass').value;   
                var confirmButton = document.getElementById('confirmButton');  
                var message = document.getElementById('message');
                if(confirmPass !== newpass){ 
                    message.textContent = "Mật khẩu xác thực không trùng khớp!";
                    confirmButton.disabled = true;
                }
                else{
                    message.textContent = "";
                    confirmButton.disabled = false;
                }
            });
        </script>
    </body>
</html>
