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
        <title>Quản Lí Sản Phẩm</title>
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
        <style>
            .radio-buttons {
            flex-direction: column;
            gap: 10px; /* Adjust spacing between radio buttons */
            } 
            .radio-buttons input[type="radio"] {
            margin-right: 5px;  
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            width: 16px;
            height: 16px;
            border: 1px solid #ccc;
            border-radius: 50%;
            outline: none;
            cursor: pointer;
            } 
            .radio-buttons input[type="radio"]:checked {
                background-color: #007bff; /* Change background color when checked */
            } 
            .radio-buttons label {
                margin-right: 15px;
                cursor: pointer;
            }
        </style> 
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
                    <li class="breadcrumb-item active"><a href="#"><b>Danh sách sản phẩm</b></a></li>
                </ul> 
            </div>  
            <div class="row">
                <c:if test="${message != null}">
                <script>
                    Swal.fire({
                        title: "Thông Báo",
                        text: "${message}", 
                        icon: '${type}',
                        timer: 1500
                });
                </script> 
            </c:if>
                <div class="col-md-12">
                    <div class="tile">
                        <div class="tile-body">
                            <div class="row element-button">
                                <div class="radio-buttons">
                                    <input type="radio" id="allProducts" checked onclick="location.href='productmanager?type=all'" name="product" >
                                    <label style="margin-right: 15px" for="allProducts">Tất Cả Sản Phẩm</label>

                                    <input type="radio" id="expiredProduct" onclick="location.href='productmanager?type=expired'" name="product">
                                    <label for="productsExpiring">Sản Phẩm Sắp Hết Hạn</label>
                                    
                                    <input type="radio" id="saleProduct" onclick="location.href='productmanager?type=sale'" name="product">
                                    <label for="productsExpiring">Sản Phẩm Đang Giảm Giá</label>
                                </div>
<!--                                <div class="col-sm-2"> 
                                    <a class="btn btn-add btn-sm" href="addproduct" title="Thêm"><i class="fas fa-plus"></i>
                                        Sản Phẩm Giảm Giá
                                    </a>
                                </div>
                                <div class="col-sm-2"> 
                                    <input type="checkbox" >Tất Cả Sản Phẩm
                                    <a class="btn btn-add btn-sm" title="View"><i class="fa-solid fa-layer-group"></i>
                                        Tất Cả Sản Phẩm
                                    </a>
                                </div>

                                <div class="col-sm-2"> 
                                    <a class="btn btn-add btn-sm" title="View"><i class="fa-solid fa-stopwatch"></i>
                                        Sản Phẩm Sắp Hết Hạn
                                    </a>
                                </div>-->
                            </div>
                        <c:if test="${discount == 1}"> 
                            <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0" border="0"
                                   id="sampleTable">
                                <thead>
                                    <tr> 
                                        <th>Mã Sản Phẩm</th>
                                        <th>Tên Sản Phẩm</th> 
                                        <th>Giá Đã Giảm</th>
                                        <th>% Giảm Giá</th>  
                                        <th>Thao tác</th>   
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${listDiscount}" var="d">
                                        <tr>
                                            <td>${d.getProduct().getProductID()}</td>
                                            <td>${d.getProduct().getProductName()}</td>
                                            <td><fmt:formatNumber>${d.getProduct().getSale_price()}</fmt:formatNumber></td> 
                                            <td>${d.getSalePercent()}%</td> 
                                            <td>
                                                <form id="dialogForm" method="post"> 
                                                <button class="btn btn-primary btn-sm edit" type="button"
                                                        data-toggle="modal" data-target="#changeDiscount${d.getProduct().getProductID()}"> 
                                                <i class="fa-solid fa-pen-to-square"></i>
                                                </button>   
                                                <button 
                                                    class="btn btn-primary btn-sm trash" onclick="showConfirmDialog('${d.getProduct().getProductID()}', '${d.getProduct().getProductName()}', 1)" type="button"> <i class='fas fa-trash'></i>
                                                </button> 
                                                </form>
                                            </td> 
                                        </tr>
                                        <div class="modal fade" id="changeDiscount${d.getProduct().getProductID()}">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">  
                                                    <form method="POST" action="productmanager?action=changeDiscount&pID=${d.getProduct().getProductID()}">
                                                        <div class="modal-body">
                                                            <h3 style="margin: 15px 0 15px 0; text-align: center" class="tile-title">Giảm Giá Sản Phẩm</h3> 
                                                            <div class="form-group col-md-12"> 
                                                                <label class="control-label">Tên sản phẩm</label>
                                                                <input class="form-control" name="name" type="text" value="${d.getProduct().getProductName()}">  
                                                            </div>  
                                                            <input hidden class="form-control" name="salePrice" value="${d.getProduct().getSale_price()}" type="text">
                                                            <div class="form-group  col-md-6">
                                                                <label class="control-label">Nhập % giảm giá</label>
                                                                <input class="form-control" name="percent" value="${d.getSalePercent()}" placeholder="%">
                                                            </div> 
                                                            <div class="form-group  col-md-6" >
                                                                <button class="btn btn-save" type="submit">Cập nhật</button>
                                                                <a class="btn btn-cancel" data-dismiss="modal">Hủy bỏ</a> 
                                                            </div>
                                                        </div>
                                                    </form>  
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                        <c:if test="${discount == 0}"> 
                            <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0" border="0"
                                   id="sampleTable">
                                <thead>
                                    <tr> 
                                        <th>Mã Sản Phẩm</th>
                                        <th>Tên Sản Phẩm</th>
                                        <th>Giá Gốc</th>
                                        <th>Giá Bán</th>
                                        <th>Hạn Sử Dụng</th>
                                        <th>Danh Mục</th> 
                                        <th>Thao tác</th>   
                                    </tr>
                                </thead>
                                <tbody> 
                                    <c:forEach items="${listProduct}" var="p">
                                        <tr>
                                            <td>${p.getProductID()}</td>
                                            <td>${p.getProductName()}</td>
                                            <td><fmt:formatNumber>${p.getPrice()}</fmt:formatNumber></td>
                                            <td><fmt:formatNumber>${p.getSale_price()}</fmt:formatNumber></td>
                                            <td>${p.getExpiredDate()}</td>
                                            <td>${p.getCategory().getCategoryName()}</td> 
                                            <td>
                                                <form id="dialogForm" method="post"> 
                                                <button class="btn btn-primary btn-sm edit" type="button"
                                                        data-toggle="modal" data-target="#Edit${p.getProductID()}"> 
                                                <i class="fa-solid fa-pen-to-square"></i>
                                                </button>   
                                                <button 
                                                    class="btn btn-primary btn-sm trash" onclick="showConfirmDialog('${p.getProductID()}', '${p.getProductName()}', 2)" type="button"> <i class='fas fa-trash'></i>
                                                </button>
                                                <button class="btn btn-primary btn-sm edit" type="button"
                                                        data-toggle="modal" data-target="#discount${p.getProductID()}"> 
                                                <i class="fa-solid fa-percent"></i>
                                                </button>  
                                                </form>
                                            </td> 
                                        </tr> 
                                        <!--Modal Edit-->
                                        <div class="modal fade" id="Edit${p.getProductID()}">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">  
                                                    <form method="POST" action="productmanager?action=edit&pID=${p.getProductID()}">
                                                        <div class="modal-body">
                                                            <h3 style="margin: 15px 0 15px 0; text-align: center" class="tile-title">Chỉnh Sửa Sản Phẩm</h3> 
                                                            <div class="form-group col-md-12"> 
                                                                <label class="control-label">Tên sản phẩm</label>
                                                                <input class="form-control" name="name" type="text" value="${p.getProductName()}">  
                                                            </div>  
                                                            <div class="form-group  col-md-6">
                                                                <label class="control-label">Giá gốc</label>
                                                                <input class="form-control" name="price" type="text" value="${p.getPrice()}">
                                                            </div>
                                                            <div class="form-group  col-md-6">
                                                                <label class="control-label">Giá bán</label>
                                                                <input class="form-control" name="salePrice" type="text" value="${p.getSale_price()}">
                                                            </div>
                                                            <div class="form-group  col-md-6">
                                                                <label class="control-label">Danh mục</label>
                                                                <select class="form-control" name="category">
                                                                    <c:forEach items="${listCategory}" var="c"> 
                                                                        <option ${c.getCategoryID() == p.getCategory().getCategoryID() ? "selected":""} value="${c.getCategoryID()}">${c.getCategoryName()}</option>
                                                                    </c:forEach> 
                                                                </select>
                                                            </div> 
                                                            <div class="form-group  col-md-6" >
                                                                <button class="btn btn-save" type="submit">Update</button>
                                                                <a class="btn btn-cancel" data-dismiss="modal">Hủy bỏ</a> 
                                                            </div>
                                                        </div>
                                                    </form>  
                                                </div>
                                            </div>
                                        </div> 
                                        <!-- Discount -->
                                        <div class="modal fade" id="discount${p.getProductID()}">
                                            <div class="modal-dialog modal-dialog-centered" role="document">
                                                <div class="modal-content">  
                                                    <form method="POST" action="productmanager?action=discount&pID=${p.getProductID()}">
                                                        <div class="modal-body">
                                                            <h3 style="margin: 15px 0 15px 0; text-align: center" class="tile-title">Giảm Giá Sản Phẩm</h3> 
                                                            <div class="form-group col-md-12"> 
                                                                <label class="control-label">Tên sản phẩm</label>
                                                                <input class="form-control" name="name" type="text" value="${p.getProductName()}">  
                                                            </div>
                                                            <input hidden class="form-control" name="salePrice" value="${p.getSale_price()}" type="text">
                                                            <div class="form-group  col-md-6">
                                                                <label class="control-label">Nhập % giảm giá</label>
                                                                <input class="form-control" name="percent" type="text" placeholder="%">
                                                            </div> 
                                                            <div class="form-group  col-md-6" >
                                                                <button class="btn btn-save" type="submit">Thêm</button>
                                                                <a class="btn btn-cancel" data-dismiss="modal">Hủy bỏ</a> 
                                                            </div>
                                                        </div>
                                                    </form>  
                                                </div>
                                            </div>
                                        </div>
                                        <!-- /Discount -->
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                        </div>
                    </div>
                </div>
            </div> 
        </main> 
        <script>
            document.addEventListener('DOMContentLoaded', function() { 
                function getUrlParameter(name) {
                    const urlParams = new URLSearchParams(window.location.search);
                    return urlParams.get(name);
                } 
                const type = getUrlParameter('type'); 
                const allProduct = document.getElementById('allProducts');
                const discountProduct = document.getElementById('saleProduct');
                const expiredProduct = document.getElementById('expiredProduct');
                switch (type) {
                    case "all":
                        allProduct.checked = true;
                        discountProduct.checked = false; 
                        expiredProduct.checked = false;
                        break;
                    case "expired":
                        allProduct.checked = false;
                        discountProduct.checked = false; 
                        expiredProduct.checked = true;
                        break; 
                    case "sale":
                        allProduct.checked = false; 
                        expiredProduct.checked = false; 
                        discountProduct.checked = true; 
                        break; 
                    default:
                        allProduct.checked = true;
                        discountProduct.checked = false; 
                        expiredProduct.checked = false;
                        break;
                }
                if(type === null || type === 'all'){
                    expiredProduct.checked = false;
                    discountProduct.checked = false;
                    allProduct.checked = true;
                } 
                else if(type === "expired") {
                    allProduct.checked = false;
                    discountProduct.checked = false;
                    expiredProduct.checked = true; 
                }
                else if(type === "sale"){
                    allProduct.checked = false; 
                    expiredProduct.checked = false;  
                    discountProduct.checked = true;
                }
            });
            function showConfirmDialog(pID, pName, type) {
                var form = document.getElementById("dialogForm");
                var message1 = "Bạn có chắc chắn muốn dừng giảm giá sản phẩm " + pName + " không ?";
                var action1 = "productmanager?action=removeDiscount"+ "&pID=" + pID;   
                var message2 = "Bạn có chắc chắn muốn xóa " + pName + " khỏi hệ thống ?";  
                var action2 = "productmanager?action=delete"+ "&pID=" + pID;  
                var message = type == 1 ? message1 : message2;
                form.action = type == 1 ? action1 : action2;
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
        <script src="View/Admin/js/jquery-3.2.1.min.js"></script>
        <script src="View/Admin/js/popper.min.js"></script>
        <script src="View/Admin/js/bootstrap.min.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="View/Admin/js/main.js"></script>
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
