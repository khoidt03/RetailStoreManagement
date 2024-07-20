 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico"> 
        <title>Xác minh Email</title>
        <link rel="stylesheet" href="View/CSS/forgetpassword.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/> 
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head> 
    <body>
        <div class="login-container">
            <div class="login-box"> 
                <h1>Xác minh OTP</h1> 
                <div style="font-size: 20px; color: red">
                    <p>Mã xác thực có hiệu lực trong 1 phút</p>
                </div>
                <form action="authentication" method="post">
                    <div class="input-group"> 
                        <input name="otpInput" type="text" placeholder="Vui lòng nhập mã xác thực từ email..." required />
                    </div>  
                    <c:if test="${message != null}">
                         <div class="alert alert-danger" role="alert">
                             ${message}
                         </div>
                     </c:if>
                    <div class="button-group">
                        <button onclick="location.href='forgetpassword'" type="button" class="manage-btn">Quay lại</button>
                        <button type="submit" class="sell-btn">Xác thực</button>
                    </div>
                </form>
            </div>
        </div>  
        </script>
    </body>
</html>
