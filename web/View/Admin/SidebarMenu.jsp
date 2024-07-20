<%-- 
    Document   : SidebarMenu
    Created on : Jun 1, 2024, 10:23:35 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">  
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'> 
    </head>
    <body>
        <div class="app-sidebar__overlay" data-toggle="sidebar"></div>
        <aside class="app-sidebar">
            <div class="app-sidebar__user">
                <img class="app-sidebar__user-avatar" src="View/Image/logoAdmin.png" width="50px" alt="">
                <div>
                    <p class="app-sidebar__user-name"><b>Xin chào, ${account.getUsername()}</b></p> 
                </div>
            </div>
            <hr>
            <ul class="app-menu">
                <li>  
                    <a class="app-menu__item" href="dashboard" data-menu="dashboard"><i class="app-menu__icon bx bxs-dashboard"></i></i>
                        <span class="app-menu__label">
                            Bảng điều khiển
                        </span>
                    </a>
                </li>
                <li>
                    <a class="app-menu__item" href="productmanager" data-menu="product"><i class="app-menu__icon bx bxs-purchase-tag"></i>
                        <span class="app-menu__label">
                            Quản lý sản phẩm</span>
                    </a>
                </li>
                <li>
                    <a class="app-menu__item" href="staffmanager" data-menu="staff"><i class='app-menu__icon bx bx-male-female'></i>
                        <span class="app-menu__label">
                            Quản lý nhân viên
                        </span>
                    </a>
                </li>  
                <li>
                    <a class="app-menu__item" href="customermanager" data-menu="customer"><i class='app-menu__icon bx bxs-user-detail'></i>
                        <span class="app-menu__label">
                            Quản lý khách hàng
                        </span>
                    </a>
                </li>  
                <li>
                    <a class="app-menu__item" href="ordermanager" data-menu="invoice"><i class='app-menu__icon bx bx-credit-card-front'></i>
                        <span class="app-menu__label">
                            Quản lý hoá đơn  
                        </span>
                    </a>
                </li> 
                <li>
                    <a class="app-menu__item" href="inventory" data-menu="inventory"><i class='app-menu__icon bx bxs-home-circle'></i>
                        <span class="app-menu__label">
                            Quản lý kho hàng  
                        </span>
                    </a> 
                </li> 
                <li>
                    <a class="app-menu__item" href="supplier" data-menu="supplier"><i class='app-menu__icon bx bx-sushi'></i>
                        <span class="app-menu__label">
                            Quản lý nhà cung cấp 
                        </span>
                    </a>
                </li> 
                <li>
                    <a class="app-menu__item" href="salary" data-menu="salary"><i class='app-menu__icon bx bx-money-withdraw'></i>
                        <span class="app-menu__label">
                            Thống kê lương  
                        </span>
                    </a>
                </li> 
                <li>
                    <a class="app-menu__item" href="log" data-menu="log"><i class='app-menu__icon bx bxs-notepad'></i>
                        <span class="app-menu__label">
                            Hoạt động gần đây  
                        </span>
                    </a>
                </li> 
                 <li>
                    <a class="app-menu__item" href="schedule" data-menu="schedule"><i class='app-menu__icon bx bxs-notepad'></i>
                        <span class="app-menu__label">
                          Sắp xếp lịch làm việc
                        </span>
                    </a>
                </li> 
            </ul>
        </aside>
        <script> 
        document.addEventListener('DOMContentLoaded', () => {   
            const menuItems = document.querySelectorAll('.app-menu__item'); 
            const activeMenu = localStorage.getItem('activeMenu');    
            if (activeMenu) {   
                const activeElement = document.querySelector("[data-menu=" + activeMenu + "]");  
                if (activeElement) { 
                    activeElement.classList.add('active');
                }
            }  
            menuItems.forEach(item => { 
                item.addEventListener('click', () => {  
                    menuItems.forEach(i => i.classList.remove('active'));  
                    item.classList.add('active');
                    localStorage.setItem('activeMenu', item.getAttribute('data-menu'));
                    });
                }); 
            });
        </script>
    </body> 
</html>
