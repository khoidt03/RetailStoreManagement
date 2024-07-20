<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thêm Nhà Cung Cấp</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/View/CSS/main.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/View/CSS/addsupplier.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body class="app sidebar-mini rtl">
        <% 
       String message = (String) request.getAttribute("message");
       if (message != null && !message.isEmpty()) { 
        %>
        <script>
            Swal.fire({
                title: "Thông Báo",
                text: "<%= message %>",
                icon: '<%= message.contains("thành công") ? "success" : "error" %>',
                timer: 1500,
                showConfirmButton: false
            });
        </script> 
        <% 
            } 
        %>
        <header class="app-header">
            <a class="app-sidebar__toggle" data-toggle="sidebar" aria-label="Hide Sidebar">
                <i class="bx bx-menu"></i>
            </a>
            <ul class="app-nav">
                <li><a class="app-nav__item" href="logout"><i class="fas fa-sign-out-alt"></i></a></li>
            </ul>
        </header>
        <%@include file="SidebarMenu.jsp" %>
        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb">
                    <li class="breadcrumb-item">Quản lý nhà cung cấp</li>
                    <li class="breadcrumb-item">Thêm nhà cung cấp</li>
                </ul>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <h3 class="tile-title">Tạo mới nhà cung cấp</h3>
                        <div class="tile-body">
                            <form class="row" action="addsupplier" method="post" name="supplierForm" onsubmit="return validateForm()">
                                <div class="form-group col-md-3">
                                    <label class="control-label required-label">Tên nhà cung cấp</label>
                                    <input class="form-control" type="text" required name="nameSupplier">
                                    <div id="nameSupplierError" class="error-message"></div>
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label required-label">Số điện thoại</label>
                                    <input class="form-control" type="text" required name="phoneSupplier">
                                    <div id="phoneSupplierError" class="error-message"></div>
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label required-label">Địa chỉ</label>
                                    <input class="form-control" type="text" required name="addressSupplier">
                                    <div id="addressSupplierError" class="error-message"></div>
                                </div>
                                <div class="form-group col-md-3">
                                    <label class="control-label">Email</label>
                                    <input class="form-control" type="email" name="emailSupplier">
                                    <div id="emailSupplierError" class="error-message"></div>
                                </div>
                                <div class="btn-action">
                                    <button class="btn btn-save" type="submit">Lưu lại</button>
                                    <button class="btn btn-cancel" type="button" onclick="window.location.href = 'supplier'">Hủy bỏ</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <!-- Essential javascripts for application to work-->
        <script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/jquery-table2excel@1.1.0/dist/jquery.table2excel.min.js"></script>
        <script src="js/main.js"></script>
        <!-- The javascript plugin to display page loading on top-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pace/1.0.2/pace.min.js"></script>
        <!-- Page specific javascripts-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
        <!-- Data table plugin-->
        <script type="text/javascript" src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="https://cdn.datatables.net/1.10.21/js/dataTables.bootstrap4.min.js"></script>
        <script>
                                        function validateForm() {
                                            var name = document.forms["supplierForm"]["nameSupplier"].value.trim();
                                            var phone = document.forms["supplierForm"]["phoneSupplier"].value.trim();
                                            var address = document.forms["supplierForm"]["addressSupplier"].value.trim();
                                            var email = document.forms["supplierForm"]["emailSupplier"].value.trim();
 
                                            var phoneRegex = /^\d{10}$/;
                                            var addressRegex = /.+/;
                                            var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

                                            var isValid = true;

                                            // Reset error messages
                                            document.getElementById("nameSupplierError").textContent = "";
                                            document.getElementById("phoneSupplierError").textContent = "";
                                            document.getElementById("addressSupplierError").textContent = "";
                                            document.getElementById("emailSupplierError").textContent = ""; 
                                            // Validate phone
                                            if (!phoneRegex.test(phone)) {
                                                document.getElementById("phoneSupplierError").textContent = "Số điện thoại không hợp lệ. Vui lòng nhập 10 chữ số.";
                                                document.getElementById("phoneSupplierError").style.color = "red";
                                                isValid = false;
                                            }

                                            // Validate address
                                            if (!addressRegex.test(address)) {
                                                document.getElementById("addressSupplierError").textContent = "Địa chỉ không hợp lệ.";
                                                document.getElementById("addressSupplierError").style.color = "red";
                                                isValid = false;
                                            }

                                            // Validate email
                                            if (email !== "" && !emailRegex.test(email)) {
                                                document.getElementById("emailSupplierError").textContent = "Email không hợp lệ.";
                                                document.getElementById("emailSupplierError").style.color = "red";
                                                isValid = false;
                                            }

                                            return isValid;
                                        }
        </script>
    </body>
</html>
