<%-- 
    Document   : AuthenticationEmail
    Created on : May 26, 2024, 10:50:06 PM
    Author     : nguye
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AuthenticationEmail</title>
        <link rel="stylesheet" href="CSS/authenticationemail.css"/>
    </head>
    <body>
        <div class="login-container">
            <div class="login-box">
                <div class="logo">
                    <img
                        src=""
                        alt="KiotViet" />
                </div>
                <h1>Quên mật khẩu</h1>
                <span>Vui lòng nhập mã xác thực từ email</span>
                <form>
                    <div class="input-group">
                        <input type="text" placeholder="Nhập mã xác thực..." required />
                    </div>
                    <div class="button-group">
                        <button type="button" class="manage-btn">Quay lại</button>
                        <button type="submit" class="sell-btn">Xác thực</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="support">
            <p>Hỗ trợ: 190006522</p>
        </div>
    </body>
</html>
