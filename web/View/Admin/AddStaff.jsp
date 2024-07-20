<%-- 
    Document   : AddStaff
    Created on : Jun 2, 2024, 3:13:09 AM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Thêm Nhân Viên</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1"> 
        <link rel="stylesheet" type="text/css" href="View/CSS/main.css">
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">  
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css"> 
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
    </head>  
    <body class="app sidebar-mini rtl">
        <header class="app-header">
            <!-- Sidebar toggle button-->
            <a class="app-sidebar__toggle" href="#" data-toggle="sidebar"
               aria-label="Hide Sidebar"></a>
            <!-- Navbar Right Menu-->
            <ul class="app-nav"> 
                <!-- User Menu-->
                <li><a class="app-nav__item" href="login"><i class="fa-solid fa-arrow-right-from-bracket"></i></a> 
                </li>
            </ul>
        </header>
        <!-- Sidebar menu-->
        <jsp:include page="SidebarMenu.jsp"></jsp:include>
        <main class="app-content"> 
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item"><a href="staffmanager">Danh sách nhân viên</a></li>
                    <li class="breadcrumb-item"><a href="#">Thêm nhân viên</a></li>
                </ul> 
            <c:if test="${message != null}">
                <script>
                    Swal.fire({  
                        title: "Thông Báo",
                        text: "${message}", 
                        icon: 'success',
                        timer: 1500
                });
                </script> 
            </c:if> 
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile"> 
                        <div class="tile-body">  
                            <form class="row" action="addstaff" method="POST"  >
                                
                                <div class="form-group col-md-3">
                                    <label class="control-label">Username</label>
                                    <input class="form-control" name="username" type="text" placeholder="Nhập username" required>
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Họ</label>
                                    <input class="form-control" name="firstname" type="text" placeholder="Nhập họ" required>
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Tên</label>
                                    <input class="form-control" name="lastname" type="text" placeholder="Nhập tên" required>
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Ngày Sinh</label>
                                    <input class="form-control" name="date" type="date" required>
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Password</label>
                                    <input class="form-control" name="password" type="password" placeholder="Nhập password" required>
                                </div> 
                                <div class="form-group col-md-3">
                                    <label class="control-label">Giới tính</label>
                                    <select class="form-control" name="gender">
                                        <option value="1">Nam</option>
                                        <option value="0">Nữ</option>
                                    </select> 
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Số điện thoại</label>
                                    <input class="form-control" name="phone" type="text" placeholder="Nhập số điện thoại" required>
                                </div> 
                                <div class="form-group col-md-3">
                                    <label class="control-label">Địa chỉ</label>
                                    <input class="form-control" name="address" type="text" placeholder="Nhập địa chỉ" required>
                                </div> 
                                <div class="form-group col-md-3">
                                    <label class="control-label">Email</label>
                                    <input class="form-control" name="email" type="text" placeholder="Nhập email" required>
                                </div> 
                                <div class="form-group col-md-3">
                                    <label class="control-label">Trạng thái</label>
                                    <select class="form-control" name="status">
                                        <option value="1">Activated</option>
                                        <option value="2" selected >UnActivated</   option>
                                    </select> 
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Role</label> 
                                    <select class="form-control" name="role">
                                        <c:if test="${account.getRole().getRoleID() == 2}"> 
                                            <option selected value="3">Staff</option>
                                        </c:if>
                                        <c:if test="${account.getRole().getRoleID() == 1}"> 
                                            <option selected value="3">Staff</option>
                                            <option value="2">Manager</option>
                                        </c:if>
                                    </select>
                                </div>
                                <div class="form-group col-md-12">
                                    <button id="submitForm" class="btn btn-save" type="submit">Lưu</button>
                                    &nbsp;
                                    <a class="btn btn-cancel" href="staffmanager">Quay lại</a>
                                </div>
                            </form> 
                        </div> 
                    </div>
                </div>
            </div>
        </main> 
    </body> 
</html>
