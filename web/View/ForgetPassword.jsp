 <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico"> 
        <title>Forget Password</title>
        <link rel="stylesheet" href="View/CSS/forgetpassword.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    </head>
    <body>
        <div class="login-container">
            <div class="login-box"> 
                <h1>Quên mật khẩu</h1>
                <form action="forgetpassword" method="post">
                    <div class="input-group">
                        <input id="inputEmail" name="input-email" type="text" placeholder="Nhập email..." required />
                    </div>
                    <div style="color: red;"> 
                        <p id="message" >${message}</p>
                    </div>
                    <div class="button-group">
                        <button onclick="location.href='login'" type="button" class="manage-btn">Quay lại</button>
                        <button id="sendEmail" type="submit" class="sell-btn">Gửi email</button>
                    </div>
                </form>
            </div>
        </div> 
        <script>
            document.getElementById('inputEmail').addEventListener('input', function() {  
                var email = document.getElementById('inputEmail').value;
                var message = document.getElementById('message');  
                var sendButton = document.getElementById('sendEmail');
                var valid = email.match(/^[^\s@]+@[^\s@]+\.[^\s@]+$/);   
                if(!valid){ 
                    message.textContent = "Vui lòng nhập Email đúng định dạng!";
                    sendButton.disabled = true;
                }
                else{
                    message.textContent = "";
                    sendButton.disabled = false;
                }
            });
            
        </script>
    </body>
</html>
