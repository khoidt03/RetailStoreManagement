<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico"> 
        <title>Login</title>
        <link rel="stylesheet" href="View/CSS/login.css"> 
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>
    <body>
        <div class="login-container">
            <div class="login-box"> 
                <h2 onclick="location.href='login'">Đăng nhập</h2>
                <form action="login" method="post"> 
                    <div class="input-group">
                        <input value="${cookie.username.value}" type="text" name="input-user" placeholder="Tên đăng nhập" required />
                    </div>
                    <div class="input-group">
                        <input value="${cookie.password.value}" id="passwordField" type="password" name="input-pass" placeholder="Mật khẩu" required />
                        <div class="input-group-append">
                            <a class="btn-icon" id="togglePassword">
                                <i class="far fs14 fa-eye-slash" id="passwordIcon"></i>
                            </a>
                        </div>
                    </div>
                     <c:if test="${message != null}">
                         <div class="alert alert-danger" role="alert">
                             ${message}
                         </div>
                     </c:if>
                    <div class="remember-me">
                        <input type="checkbox" name="rememberMe" ${cookie.rememberMe.value == "checked" ? "checked":""} value="checked" />
                        <label for="rememberMe">Duy trì đăng nhập</label>
                        <a href="forgetpassword">Quên mật khẩu?</a>
                    </div>
                    <div class="button-group">
                        <button type="submit" class="login-btn">Login</button>
                    </div> 
                </form> 
            </div>
        </div>
        <script>
            document.getElementById("togglePassword").addEventListener("click", function () {
                const passwordField = document.getElementById("passwordField");
                const passwordIcon = document.getElementById("passwordIcon");
                if (passwordField.type === "password") { 
                    passwordField.type = "text";
                    passwordIcon.classList.remove("fa-eye-slash");
                    passwordIcon.classList.add("fa-eye");
                } else {
                    passwordField.type = "password";
                    passwordIcon.classList.remove("fa-eye");
                    passwordIcon.classList.add("fa-eye-slash");
                }
            });   
        </script>
    </body>
</html>
