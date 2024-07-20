<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Tính lương nhân viên</title>
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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css">
    </head>  
    <body class="app sidebar-mini rtl">
        <header class="app-header">
            <!-- Sidebar toggle button-->
            <a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
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
                        <li class="breadcrumb-item"><a href="#">Tính lương nhân viên</a></li>
                    </ul> 
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="tile"> 
                            <div class="tile-body">
                                <div class="row element-button">
                                    <div class="col-sm-6"> 
                                        <strong>Tính lương nhân viên</strong>    
                                    </div> 
                                </div>
                                <form action="salary" method="post">
                                    <div class="form-group">
                                        <label for="monthYearPicker">Chọn tháng và năm:</label>
                                        <div class="input-group date" id="monthYearPicker">
                                            <input type="text" class="form-control" name="monthYear" required>
                                            <div class="input-group-append">
                                                <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                                            </div>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary">Tính lương</button>
                                </form>
                                <table class="table table-hover table-bordered js-copytextarea" cellpadding="0" cellspacing="0" border="0"
                                   id="sampleTable">
                                    <thead>
                                        <tr>
                                            <th>Tên nhân viên</th>
                                            <th>Số giờ làm việc</th>
                                            <th>Lương (VNĐ)</th>                                           
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${salaryList}" var="s">
                                        <tr class="item-salary">
                                            <td>${s.employeeName}</td>
                                            <td><fmt:formatNumber value="${s.workingHours}" type="number" groupingUsed="true"/></td>
                                            <td><fmt:formatNumber value="${s.salary}" type="number" maxFractionDigits="0" groupingUsed="true"/>₫</td>
                                        </tr>
                                    </c:forEach> 
                                </tbody>
                            </table>
                            <ul class="listPage"> </ul>
                        </div> 
                    </div>
                </div>
            </div>
        </main> 
    </body>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#monthYearPicker').datepicker({
                format: "mm-yyyy",
                startView: "months",
                minViewMode: "months",
                autoclose: true
            });
        });
    </script>
    <script>
        // Phân trang
        let limit = 8;
        let list = document.querySelectorAll(".item-salary");
        let thisPage = 1;
        function loadItem() {
            let beginGet = limit * (thisPage - 1);
            let endGet = limit * thisPage - 1;
            list.forEach(function (value, item) {
                if (item >= beginGet && item <= endGet) {
                    value.style.display = "table-row";
                } else {
                    value.style.display = "none";
                }
            });
            listPage();
        }
        function listPage() {
            let count = Math.ceil(list.length / limit);
            document.querySelector(".listPage").innerHTML = "";
            for (let i = 1; i <= count; i++) {
                let newPage = document.createElement("button");
                newPage.innerHTML = i;
                newPage.setAttribute("onclick", "changePage(" + i + ")");
                document.querySelector(".listPage").appendChild(newPage);
            }
        }
        function changePage(i) {
            thisPage = i;
            loadItem();
        }
        loadItem();
    </script>
</html>