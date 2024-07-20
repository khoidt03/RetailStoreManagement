
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.time.LocalDate" %>

<!DOCTYPE html>
<html lang="en"> 
    <head>
        <title>Dashboard</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1"> 
        <link rel="stylesheet" type="text/css" href="View/CSS/main.css">
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico">    
        <link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"> 
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css"> 
    </head>
    <% 
        LocalDate today = LocalDate.now();
        int month = today.getMonthValue();
        // Convert to JSTL 
        pageContext.setAttribute("currentMonth", month);
    %>
    <body class="app sidebar-mini rtl">
        <!-- Navbar-->
        <header class="app-header">
            <!-- Sidebar toggle button--><a class="app-sidebar__toggle" href="#" data-toggle="sidebar" aria-label="Hide Sidebar"></a>
            <!-- Navbar Right Menu-->
            <ul class="app-nav"> 
                <!-- User Menu-->
                <li>
                   <a class="app-nav__item" href="logout"><i class='bx bx-log-out bx-rotate-180'></i></a> 
                </li>
            </ul>
        </header>
        <!-- Sidebar menu-->
        <jsp:include page="SidebarMenu.jsp"></jsp:include> 
        <main class="app-content">
            <div class="row">
                <div class="col-md-12">
                    <div class="app-title">
                        <ul class="app-breadcrumb breadcrumb">
                            <li class="breadcrumb-item"><a href="#"><b>Control Panel</b></a></li>
                        </ul> 
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 col-lg-12">
                    <div class="row">
                        <!-- col-6 -->
                        <div class="col-md-3">  
                            <div onclick="location.href='productmanager?type=expired'" class="widget-small warning coloured-icon"><i class='icon bx bxs-alarm-exclamation fa-3x'></i>
                                <div class="info">
                                    <h4>Sản phẩm sắp hết hạn</h4>
                                    <p><b>${expiredProduct} sản phẩm</b></p> 
                                </div>
                            </div>
                        </div> 
                        <div class="col-md-3">
                            <div class="widget-small primary coloured-icon"><i class='icon bx bx-money-withdraw fa-3x'></i>
                                <div class="info">
                                    <h4>Doanh thu hôm nay</h4>
                                    <p><b><fmt:formatNumber value="${dailyRevenue}" /> VNĐ</b></p>
                                </div>
                            </div> 
                        </div>
                        <div class="col-md-3">   
                            <div class="widget-small info coloured-icon"><i class='icon bx bx-money-withdraw fa-3x'></i>
                                <div class="info">
                                    <h4>Doanh thu tháng ${currentMonth}</h4>
                                    <c:forEach var="entry" items="${monthRevenue}">
                                        <c:if test="${entry.key == currentMonth}">
                                            <p><b><fmt:formatNumber value="${entry.value}" /> VNĐ</b></p>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>           
                        <div class="col-md-3">
                            <div class="widget-small info coloured-icon"><i class='icon bx bxs-data fa-3x'></i>
                                <div class="info">
                                    <h4>Tổng doanh thu</h4>
                                    <p><b><fmt:formatNumber value="${revenue}" /> VNĐ</b></p>
                                </div>
                            </div>
                        </div> 
                    </div>
                </div>
                <div style="width: 80%">
                    <canvas id="totalRevenue"></canvas>
                </div>  
            </div>               
        </main>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"> </script> 
        <script type="text/javascript"> 
            function formatInput(value){ 
                value = value.toString().replace(/\D/g, ''); 
                return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, '.');
            }
            document.addEventListener("DOMContentLoaded", function() {
            var chart = document.getElementById("totalRevenue").getContext("2d");
            var myChart = new Chart(chart, {
                type: "line",
                data: {
                labels: ["Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4", "Tháng 5", "Tháng 6", 
                     "Tháng 7", "Tháng 8", "Tháng 9", "Tháng 10", "Tháng 11", "Tháng 12"], 
                datasets: [{
                label: "Doanh thu", 
                borderColor: 'rgba(75, 192, 192, 1)',
                data: [
                    <c:forEach var="entry" items="${monthRevenue}">
                        ${entry.value}<c:if test="${!loop.last}">,</c:if>
                    </c:forEach>
                ]
                   }],
                options: {}
                }   
            });
        });
        </script>
        <script src="admin/js/jquery-3.2.1.min.js"></script> 
        <script src="admin/js/popper.min.js"></script>
        <script src="https://unpkg.com/boxicons@latest/dist/boxicons.js"></script> 
        <script src="admin/js/bootstrap.min.js"></script> 
        <script src="admin/js/main.js"></script> 
        <script src="admin/js/plugins/pace.min.js"></script> 
    </body>

</html>