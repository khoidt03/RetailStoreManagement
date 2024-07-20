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
        <title>Thêm Sản Phẩm</title>
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
                    <li class="breadcrumb-item"><a href="staffmanager">Danh sách sản phẩm</a></li>
                    <li class="breadcrumb-item"><a href="#">Thêm sản phẩm</a></li>
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
                            <div class="row element-button">
                                <div class="col-sm-2"> 
                                    <a class="btn btn-add btn-sm" data-toggle="modal" data-target="#adddanhmuc" title="Thêm"><i class="fas fa-plus"></i>
                                        Thêm Danh Mục
                                    </a>  
                                </div> 
                                <div class="col-sm-2"> 
                                    <a class="btn btn-add btn-sm" data-toggle="modal" data-target="#addKe" title="Thêm"><i class="fas fa-plus"></i>
                                        Thêm Vị Trí Kệ
                                    </a>  
                                </div> 
                            </div>
                            <form class="row" action="addproduct?type=product" method="POST"> 
                                <div class="form-group col-md-3">
                                    <label class="control-label required-label">Tên sản phẩm</label>
                                    <input class="form-control" name="name" type="text" placeholder="Nhập tên sản phẩm" required> 
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label required-label">Số lượng</label>
                                    <input class="form-control" name="quantity" type="number" placeholder="Nhập số lượng" required>
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label required-label">Ngày Nhập</label>
                                    <input class="form-control" name="receiveDate" type="date" placeholder="Ngày nhập hàng" required>
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label required-label">Hạn sử dụng</label>
                                    <input class="form-control" name="expriedDate" type="date" placeholder="Nhập hạn sử dụng" required>
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label required-label">Giá gốc</label>
                                    <input class="form-control" name="price" type="number" placeholder="Nhập giá gốc" required>
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label required-label">Giá bán</label>
                                    <input class="form-control" name="salePrice" type="number" placeholder="Nhập giá bán" required>
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Danh mục</label>
                                    <select class="form-control" name="category"> 
                                    <c:forEach items="${listCategory}" var="c">
                                        <option value="${c.getCategoryID()}">${c.getCategoryName()}</option>
                                    </c:forEach> 
                                    </select> 
                                </div> 
                                <div class="form-group col-md-3">
                                    <label class="control-label">Nhà cung cấp</label>
                                    <select class="form-control" name="supplierID"> 
                                    <c:forEach items="${listSupplier}" var="s">
                                        <option value="${s.getId()}">${s.getName()}</option>
                                    </c:forEach> 
                                    </select> 
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Vị Trí Kệ</label>
                                    <select class="form-control" name="location"> 
                                    <c:forEach items="${listLocation}" var="l">
                                        <option value="${l.getLocationId()}">${l.getLocationName()}</option>
                                    </c:forEach> 
                                    </select> 
                                </div> 
                                <div class="form-group col-md-12">
                                    <button id="submitForm" class="btn btn-save" type="submit">Thêm</button>
                                    &nbsp;
                                    <a class="btn btn-cancel" href="inventory">Quay lại</a>
                                </div>
                            </form> 
                        </div> 
                    </div>
                </div>
                 <div class="modal fade" id="addKe">
                <div class="modal-dialog modal-dialog-centered" >
                    <div class="modal-content"> 
                        <div class="modal-body">
                            <div class="row"> 
                                <div class="form-group col-md-12" > 
                                    <h2 style="color: red; padding-left: 10px">
                                    ${error}</h2>
                                <label class="control-label">Nhập vị trí kệ mới</label>
                                <form action="addproduct?type=location" method="post"> 
                                    <input class="form-control" type="text" name="location" required>
                                    <br>
                                    <button class="btn btn-save" type="submit">Thêm</button>
                                    <a class="btn btn-cancel" data-dismiss="modal" href="#">Hủy bỏ</a>
                                </form>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label">Vị trí các kệ hiện đang có</label>
                                <ul style="padding-left: 20px;">
                                    <c:forEach items="${listLocation}" var="l">
                                        <li>${l.getLocationName()}</li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            </div>
            <div class="modal fade" id="adddanhmuc">
                <div class="modal-dialog modal-dialog-centered" >
                    <div class="modal-content"> 
                        <div class="modal-body">
                            <div class="row"> 
                                <div class="form-group col-md-12" > 
                                    <h2 style="color: red; padding-left: 10px">
                                    ${error}</h2>
                                <label class="control-label">Nhập tên danh mục mới</label>
                                <form action="addproduct?type=category" method="post"> 
                                    <input class="form-control" type="text" name="categoryName" required>
                                    <br>
                                    <button class="btn btn-save" type="submit">Thêm</button>
                                    <a class="btn btn-cancel" data-dismiss="modal" href="#">Hủy bỏ</a>
                                </form>
                            </div>
                            <div class="form-group col-md-12">
                                <label class="control-label">Danh mục sản phẩm hiện đang có</label>
                                <ul style="padding-left: 20px;">
                                    <c:forEach items="${listCategory}" var="c">
                                        <li>${c .getCategoryName()}</li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
             
        </div>
        </main> 
    </body>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
</html>
