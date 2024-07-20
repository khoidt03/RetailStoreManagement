<%-- 
    Document   : Staff
    Created on : May 30, 2024, 11:09:14 AM
    Author     : ADMIN
--%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Quản Lí Hoá Đơn</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1"> 
        <link rel="stylesheet" type="text/css" href="View/CSS/main.css">
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">  
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>  
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css">  
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"> 
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"> 
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css"> 
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script> 
    </head>  
    <body class="app sidebar-mini rtl">
        <!-- Navbar-->
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
                    <ul class="app-breadcrumb breadcrumb side">
                        <li class="breadcrumb-item active"><a href="#"><b>Danh sách hóa đơn</b></a></li>
                    </ul> 
                </div>  
                <div class="row">
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
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">
                            <div class="row element-button"> 
                                <div class="col-sm-2">
                                    <a class="btn btn-add btn-sm" onclick="handleExport()" title="Export"><i class="fas fa-file-excel"></i> 
                                        Xuất Excel
                                    </a>
                                </div>
                            </div>  
                            <table class="table table-hover table-bordered js-copytextarea" id="sampleTable">
                                <thead>
                                    <tr>
                                        <th>Mã Hóa Đơn</th>
                                        <th>Nhân viên</th>
                                        <th>Khách hàng</th>
                                        <th>Tổng Đơn</th>
                                        <th>Thời gian</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${invoiceList}" var="i">
                                        <tr>
                                            <td>${i.getInvoiceID()}</td>
                                            <td>${i.getUser().username}</td>
                                            <td>${i.getCustomer().name}</td>
                                            <td><fmt:formatNumber value="${i.getTotalPrice()}"/></td>
                                            <td>${i.getDate()}</td>
                                            <td>
                                                <button class="btn btn-primary btn-sm eye toggle-detail" type="button" title="View">
                                                    <i class="fa fa-eye"></i>
                                                </button>
                                            </td>
                                        </tr> 
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div> 
                </div>
            </div> 
        </main>  
        <script> 
            function handleExport(){ 
                const invoiceList = [
                    <c:forEach items="${invoiceList}" var="invoice" varStatus="loop">
                        {
                            "id": "${invoice.getInvoiceID()}",
                            "staff": "${invoice.getUser().getUsername()}",
                            "customer": "${invoice.getCustomer().getName()}",
                            "total": "${invoice.getTotalPrice()}",
                            "date": "${invoice.getDate()}"
                        }<c:if test="${!loop.last}">,</c:if>
                    </c:forEach>
                ];  
                const data = [
                    ["Mã Hóa Đơn", "Nhân Viên", "Khách Hàng", "Tổng Đơn", "Ngày"],
                    ...invoiceList.map(invoice => [
                        invoice["id"],
                        invoice["staff"],
                        invoice["customer"],
                        invoice["total"],
                        invoice["date"]
                    ])
                ]; 
                // Tạo một workbook mới
                const wb = XLSX.utils.book_new(); 
                // Tạo một worksheet mới từ dữ liệu
                const ws = XLSX.utils.aoa_to_sheet(data); 
                // Thêm worksheet vào workbook
                XLSX.utils.book_append_sheet(wb, ws, "Sheet1"); 
                // Xuất workbook thành file Excel
                XLSX.writeFile(wb, "invoice.xlsx");
            }
            function showConfirmDialog(uID, uName) {
                var form = document.getElementById("dialogForm");
                var message = "Bạn có chắc chắn muốn xóa " + uName + " khỏi hệ thống ?";
                form.action = "staffmanager?action=delete" + "&uID=" + uID;
                Swal.fire({
                    title: "Thông Báo",
                    text: message,
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#3085d6",
                    cancelButtonColor: "#d33",
                    confirmButtonText: "OK"
                }).then((result) => {
                    if (result.isConfirmed) {
                        form.submit();
                    }
                });
            }
        </script>    
        <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.16.9/xlsx.full.min.js"></script> 
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="admin/js/jquery-3.2.1.min.js"></script>
        <script src="admin/js/popper.min.js"></script>
        <script src="admin/js/bootstrap.min.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="admin/js/main.js"></script>
        <!-- The javascript plugin to display page loading on top-->
        <script src="admin/js/plugins/pace.min.js"></script>
        <!-- Page specific javascripts-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
        <!-- Data table plugin-->
        <script type="text/javascript" src="View/Admin/js/plugins/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="View/Admin/js/plugins/dataTables.bootstrap.min.js"></script>
        <script type="text/javascript">$('#sampleTable').DataTable();</script> 
    </body>

</html>
