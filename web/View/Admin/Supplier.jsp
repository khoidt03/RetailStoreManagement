<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List" %>
<%@page import="Model.Supplier" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Quản Lí Nhà Cung Cấp</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/View/CSS/main.css">
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/View/CSS/supplier.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css">
        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
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
                <i class="bi bi-list"></i>
            </a>
            <ul class="app-nav">
                <li><a class="app-nav__item" href="logout"><i class="fas fa-sign-out-alt"></i></a></li>
            </ul>
        </header>
        <%@include file="SidebarMenu.jsp" %>
        <main class="app-content">
            <div class="app-title">
                <ul class="app-breadcrumb breadcrumb side">
                    <li class="breadcrumb-item active"><a><b>Danh sách nhà cung cấp</b></a></li>
                </ul>
                <div id="clock"></div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">
                            <div class="row element-button mb-4">
                                <div class="col-sm-2">
                                    <a class="btn btn-success btn-block" href="addsupplier" title="Thêm"><i class="fas fa-plus"></i> Thêm nhà cung cấp</a>
                                </div>
                            </div>
                            <table class="table table-hover table-bordered" id="sampleTable">
                                <thead>
                                    <tr>
                                        <th>Mã nhà cung cấp</th>
                                        <th>Tên nhà cung cấp</th>
                                        <th>Số điện thoại</th>
                                        <th>Địa Chỉ</th>
                                        <th>Email</th>
                                        <th>Chức năng</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%  
                                        List<Supplier> suppliers = (List<Supplier>) request.getAttribute("listSuppliers");
                                        if (suppliers != null && !suppliers.isEmpty()) {
                                            for (Supplier s : suppliers) { 
                                    %>
                                    <tr>
                                        <td><%= s.getId() %></td>
                                        <td><%= s.getName() %></td>
                                        <td><%= s.getPhone() %></td>
                                        <td><%= s.getAddress() %></td>
                                        <td><%= (s.getEmail() != null && !s.getEmail().isEmpty() ? s.getEmail() : "Không có Email") %></td>
                                        <td>
                                            <button class="btn btn-primary btn-sm eye" type="button" title="Chi tiết" onclick="location.href = 'suppliermanager?type=detail&viewsupplier=<%= s.getId() %>'">
                                                <i class="fa fa-eye"></i>
                                            </button>
                                            <button class="btn btn-warning btn-sm edit" type="button" title="Sửa" data-toggle="modal" data-target="#editModal<%= s.getId() %>">
                                                <i class="fa fa-edit"></i>
                                            </button>
                                            <button class="btn btn-danger btn-sm trash" type="button" title="Xóa" onclick="confirmDelete('<%= s.getId() %>', '<%= s.getName() %>');">
                                                <i class="fas fa-trash-alt"></i>
                                            </button>
                                        </td>
                                    </tr>
                                    <!-- Modal for Editing Supplier -->
                                <div class="modal fade" id="editModal<%= s.getId() %>" tabindex="-1" role="dialog" aria-labelledby="editModalCenterTitle" aria-hidden="true">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="editModalLongTitle" style="color: black">Chỉnh sửa nhà cung cấp</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="suppliermanager?type=edit" method="post">
                                                    <input type="hidden" name="idEdit" value="<%= s.getId() %>">
                                                    <div class="form-group">
                                                        <label for="name">Tên nhà cung cấp</label>
                                                        <input type="text" class="form-control" id="name" name="nameEdit" value="<%= s.getName() %>" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="phone">Số điện thoại</label>
                                                        <input type="text" class="form-control" id="phone" name="phoneEdit" value="<%= s.getPhone() %>" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="address">Địa Chỉ</label>
                                                        <input type="text" class="form-control" id="address" name="addressEdit" value="<%= s.getAddress() %>" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="email">Email</label>
                                                        <input type="email" class="form-control" id="email" name="emailEdit" value="<%= s.getEmail() %>">
                                                    </div>
                                                    <div class="btn-action">
                                                        <button class="btn btn-warning" type="submit">Lưu thay đổi</button>
                                                        <button class="btn btn-secondary" type="button" data-dismiss="modal">Hủy bỏ</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <% 
                                        }
                                    } 
                                %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <script src="https://cdn.jsdelivr.net/npm/jquery-table2excel@1.1.0/dist/jquery.table2excel.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.10.21/js/dataTables.bootstrap4.min.js"></script>
        <script src="${pageContext.request.contextPath}/View/Admin/js/main.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pace/1.0.2/pace.min.js"></script>
        <script type="text/javascript">$('#sampleTable').DataTable();</script>
        <script>
            function confirmDelete(supplierId, supplierName) {
                Swal.fire({
                    title: 'Bạn chắc chắn muốn xóa?',
                    text: 'Xóa nhà cung cấp ' + supplierName + ' này vĩnh viễn!',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Xóa',
                    cancelButtonText: 'Hủy bỏ'
                }).then((result) => {
                    if (result.isConfirmed) {
                        window.location.href = 'suppliermanager?type=delete&deleteSupplier=' + supplierId;
                    }
                });
            }
        </script>
    </body>
</html>
