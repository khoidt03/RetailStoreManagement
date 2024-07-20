<%-- 
    Document   : Staff
    Created on : May 30, 2024, 11:09:14 AM
    Author     : ADMIN
--%>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Quản Lí Khách Hàng</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1"> 
        <link rel="stylesheet" type="text/css" href="View/CSS/main.css">
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">  
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
                    <li class="breadcrumb-item active"><a href="#"><b>Danh sách khách hàng</b></a></li>
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
<!--                                <div class="col-sm-2">
                                    <a class="btn btn-add btn-sm" href title="In"><i class="fas fa-file-excel"></i> 
                                        Xuất Excel
                                    </a>
                                </div>-->
                            </div>  
                            <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0" border="0"
                                   id="sampleTable">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Tên Khách Hàng</th>
                                        <th>Số Điện Thoại</th>
                                        <th>Điểm Tích Lũy</th> 
                                        <th>Thao tác</th>  
                                    </tr>
                                </thead>
                                <tbody> 
                                    <c:forEach items="${customerList}" var="c">
                                        <tr>
                                            <td>${c.getId()}</td>
                                            <td>${c.getName()}</td>
                                            <td>${c.getPhoneNumber()}</td>
                                            <td>${c.getPoint()}</td> 
                                            <td>
                                                <form id="dialogForm" method="post"> 
                                                <button class="btn btn-primary btn-sm edit" type="button"
                                                        data-toggle="modal" data-target="#Edit${p.getProductID()}"> 
                                                <i class="fa-solid fa-pen-to-square"></i>
                                                </button>   
<!--                                                <button 
                                                    class="btn btn-primary btn-sm trash" onclick="showConfirmDialog('${p.getProductID()}', '${p.getProductName()}')" type="button"> <i class='fas fa-trash'></i>
                                                </button>  -->
                                                </form>
                                            </td>
                                        </tr> 
                                        <!--Modal Edit-->
<!--                                        <div class="modal fade" id="Edit${p.getProductID()}">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">  
                                                    <form method="POST" action="staffmanager?action=edit&uID=${p.getProductID()}">
                                                        <div class="modal-body">
                                                            <h3 style="margin: 15px 0 15px 0; text-align: center" class="tile-title">Chỉnh Sửa Sản Phẩm</h3> 
                                                            <div class="form-group col-md-12"> 
                                                                <label class="control-label">Tên sản phẩm</label>
                                                                <input class="form-control" name="firstname" type="text" value="${p.getProductName()}">  
                                                            </div>  
                                                            <div class="form-group  col-md-6">
                                                                <label class="control-label">Giá gốc</label>
                                                                <input class="form-control" name="email" type="text" value="${p.getPrice()}">
                                                            </div>
                                                            <div class="form-group  col-md-6">
                                                                <label class="control-label">Giá bán</label>
                                                                <input class="form-control" name="email" type="text" value="${p.getSale_price()}">
                                                            </div>
                                                            <div class="form-group  col-md-6">
                                                                <label class="control-label">Danh mục</label>
                                                                <select class="form-control" name="status">
                                                                    <c:forEach items="${listCategory}" var="c">
                                                                        <option value="${c.getCategoryID()}">${c.getCategoryName()}</option>
                                                                    </c:forEach> 
                                                                </select>
                                                            </div> 
                                                            <div class="form-group  col-md-6" >
                                                                <button class="btn btn-save" type="submit">Update</button>
                                                                <a class="btn btn-cancel"  href="productmanager">Hủy bỏ</a> 
                                                            </div>
                                                        </div>
                                                    </form>  
                                                </div>
                                            </div>
                                        </div>-->
                                        <!--/Modal Edit-->
                                    </c:forEach>
                                </tbody>
                            </table> 
                        </div>
                    </div>
                </div>
            </div> 
        </main> 
        <script>
                function showConfirmDialog(uID, uName) {
                var form = document.getElementById("dialogForm");
                var message = "Bạn có chắc chắn muốn xóa " + uName + " khỏi hệ thống ?"; 
                form.action = "staffmanager?action=delete"+ "&uID=" + uID;   
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
