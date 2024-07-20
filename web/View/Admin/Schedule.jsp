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
        <title>System Log</title>
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
                        <li class="breadcrumb-item"><a href="log">System Log</a></li>

                    </ul> 
                    <button id="clickme">Xóa</button>
                    <button id="deleteChecked">Xóa</button>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="tile"> 
                            <div class="tile-body">
                                <div class="row element-button">
                                    <div class="col-sm-6">  
                                        <strong>Hoạt động gần đây</strong>   
                                    </div>  
                                </div> 
                                <select id="weekSelect">
                                <c:forEach items="${weekList}" var="c">
                                    <option value="${c.getId()}">${c.getStartdate()} to ${c.getEnddate()}</option>
                                </c:forEach>
                            </select> 
                            <table>
                                <thead>
                                    <tr>
                                        <th>Nhân viên</th>
                                        <th>Thứ 2 </th>
                                        <th>Thứ 3</th>
                                        <th>Thứ 4</th>
                                        <th>Thứ 5</th>
                                        <th>Thứ 6</th>
                                        <th>Thứ 7</th>
                                        <th>Chủ nhật</th>
                                    </tr>
                                </thead>
                                <tbody> 
                                    <c:forEach items="${scheduleList}" var="c">
                                        <tr class="item-log" id="${c.getUserID()}">
                                            <td>${c.getInfo().getName()}</td>
                                            <td class="add-schedule" id="1" value="${c.getUserID()}/1"></td>
                                            <td class="add-schedule" id="2" value="${c.getUserID()}/2"></td>
                                            <td class="add-schedule" id="3" value="${c.getUserID()}/3"></td>
                                            <td class="add-schedule" id="4" value="${c.getUserID()}/4"></td>
                                            <td class="add-schedule" id="5" value="${c.getUserID()}/5"></td>
                                            <td class="add-schedule" id="6" value="${c.getUserID()}/6"></td>
                                            <td class="add-schedule" id="7" value="${c.getUserID()}/7"></td>   
                                        </tr>
                                    </c:forEach> 
                                </tbody>

                            </table>  
                            <div id="setWorkingTime">
                                <form method="post" id="setWorkingTimeForm">
                                    <table id="addInTable">
                                        <c:forEach items="${WorkSessionList}" var="c">
                                            <tr>
                                                <td> <input type="checkbox" name="checkboxTime" class="checkboxTime" value="${c.getWorkSessionId()} "></td>
                                                <td>${c.getWorkSessionName()} ${c.getStart_time()}-${c.getEnd_time()}</td>
                                            </tr>                              
                                        </c:forEach>
                                    </table>
                                    <span ><button id="addNewWorkingTime">Thêm mới  làm việc</button></span>
                                    <span ><button id="set">Chọn</button></span>
                                    <span class="closeWorkingTime">&times;</span> 
                                </form>
                            </div>
                            <div id="addWorkingTime">
                                <span class="CloseAddWorkingTime">&times;</span> 
                                <form action="schedule" method="post" class="form-container">
                                    <table>
                                        <tr>  
                                            <td><label>Bắt đầu từ :</label></td>
                                            <td><input type="time" required="" id="starttime" name="start_time"></td>
                                        </tr>
                                        <tr>
                                            <td> <label>Kết thúc vào :</label> </td>
                                            <td> <input type="time" required="" id="endtime" name="end_time"> </td>
                                        </tr>
                                        <tr>   
                                            <td> Tên ca : </td>
                                            <td><input type="text" required="" id="sessionWork"></td>
                                        </tr>
                                        <button id="Add" >Submit</button>

                                    </table>
                                </form>
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
    <script>
        let checkboxTimeArray = [];
        let setBox = "";
        let responseString = "";
        let obj = "";
        let getDateId = "";
        let userid = "";
        let dayofWeek = "";
        let checkedCheckboxes = [];
        const deleteChecked = document.querySelector("#deleteChecked");
        deleteChecked.disabled = true;
        //console.log(getCurrentOption);
//        const clickme = document.querySelector("#clickme");
//        clickme.addEventListener("click", function () {
//            const item = document.querySelectorAll(".add-schedule");
//
//            // Nếu nút "Hủy" đang hiển thị
//            if (clickme.innerHTML === "Hủy") {
//                item.forEach(function (i) {
//                    // Xóa bỏ checkbox trong các ô đã thêm checkbox
//                    const checkbox = i.querySelector("input[type='checkbox']");
//                    if (checkbox) {
//                        checkbox.remove();
//                    }
//                });
//                clickme.innerHTML = "Thêm checkbox";
//            } else {
//                item.forEach(function (i) {
//                    if (!i.innerHTML == "") {
//                        // Thêm checkbox vào ô nếu chưa có
//                        i.innerHTML += "<input type='checkbox'>";
//                    }
//                });
//                clickme.innerHTML = "Hủy";
//            }
//        });

//         userRow.forEach(function(item){
//            const day = Array.from(item.children);
//            console.log(day);
//            day.forEach(function(dayofWeek) {
//                console.log(dayofWeek.getAttribute("id"));
//            });
//        });
        const userRow = document.querySelectorAll(".item-log");
        function  insertIntoCell(dateid, userId, dayOfWeek, info) {
            let dateidValue = document.querySelector("#weekSelect").value;
            userRow.forEach(function (item) {
                if (item.getAttribute("id") === userId) {
                    const  a = Array.from(item.children);
                    a.forEach(function (day) {
                        if (day.getAttribute("id") === dayOfWeek && dateid == dateidValue) {
                            day.innerHTML += info + "</br>";
                        }
                    });
                }
            });
        }
        document.addEventListener("DOMContentLoaded", function () {
            let dateid = document.querySelector("#weekSelect");
            let options = dateid.options;
            let getCurrentOption = "";
            Array.from(options).forEach(function (item) {
                let subString = item.textContent.split("to");
                let dateStart = new Date(subString[0]);
                let dateEnd = new Date(subString[1]);
                let currentDate = new Date();
                if (dateStart <= currentDate && currentDate <= dateEnd) {
                    getCurrentOption = item;
                    return;
                }
            });
            getCurrentOption.selected = true;
            let dateValue = dateid.value;
            getDateId = dateValue;
            dateid.addEventListener("change", function (e) {
                dateValue = dateid.value;
                getDateId = dateValue;
                clearAllRow();
                getAllSchedule(dateValue);
            });
            clearAllRow();
            getAllSchedule(dateValue);
            const clickme = document.querySelector("#clickme");
            clickme.addEventListener("click", function () {

                const item = document.querySelectorAll(".add-schedule");
                if (clickme.innerHTML === "Hủy") {
                    item.forEach(function (i) {
                        const checkbox = i.querySelector("input[type='checkbox']");
                        if (checkbox) {
                            checkbox.remove();
                        }
                    });
                    clickme.innerHTML = "Delete";
                    document.querySelector("#deleteChecked").style.display = "none";

                } else {
                    item.forEach(function (i) {
                        if (!i.innerHTML == "") {

                            i.innerHTML += '<input type="checkbox" name="deleteCheckBox" />';
                        }
                    });
                    const checkBoxChecked = document.querySelectorAll('input[type="checkbox"][name="deleteCheckBox"]');

                    checkBoxChecked.forEach(function (checkbox) {
                        checkbox.addEventListener("change", function () {
                            if (checkbox.checked) {
                                if (!checkedCheckboxes.includes(checkbox)) {
                                    checkedCheckboxes.push(checkbox.parentNode.getAttribute("value"));
                                }
                            } else {
                                const index = checkedCheckboxes.indexOf(checkbox.parentNode.getAttribute("value"));
                                if (index !== -1) {
                                    checkedCheckboxes.splice(index, 1);
                                }
                            }
                            if (checkedCheckboxes.length != 0) {
                                console.log(checkedCheckboxes);
                                deleteChecked.disabled = false;
                            } else {
                                console.log(checkedCheckboxes);
                                deleteChecked.disabled = true;
                            }
                        });
                    });
                    clickme.innerHTML = "Hủy";
                    document.querySelector("#deleteChecked").style.display = "block";
                }
            });
        });
        const deleted = document.querySelector("#deleteChecked");
        deleted.addEventListener("click", function () {


            const http = new XMLHttpRequest();
            http.open("POST", "deleteschedule?dateid=" + getDateId + "&info=" + checkedCheckboxes, true);
            http.send();
            http.onreadystatechange = function () {
                if (this.readyState === 4) {
                    location.reload();
                }
            };

        });


        function clearAllRow() {
            let listRow = document.querySelectorAll(".add-schedule");
            listRow.forEach(function (item) {
                item.innerHTML = "";
            });
        }

        function getAllSchedule(date) {
            const http = new XMLHttpRequest();
            http.open("POST", "schedule?dateid=" + date, true);
            http.send();
            http.onreadystatechange = function () {
                if (this.readyState === 4) {
                    responseString = http.responseText;
                    obj = JSON.parse(responseString);
                    console.log(obj);
                    obj.forEach(function (item) {
                        insertIntoCell(item.dateid, item.userid, item.dayOfWeek, item.Info);
                    });
                }
            };
        }

        document.addEventListener("DOMContentLoaded", function () {
            const addSchedule = document.querySelectorAll(".add-schedule");
            addSchedule.forEach(function (cell) {
                cell.addEventListener("click", function (e) {
                    setBox = cell.getAttribute("value");
                    e.stopPropagation();
                    if (!e.target.matches('input[type="checkbox"]')) {
                        const subString = setBox.split("/");
                        userid = subString[0];
                        dayofWeek = subString[1];
                        const popup = document.querySelector("#setWorkingTime");
                        popup.style.display = "block";
                    }
                });
            });

            const close = document.querySelector(".closeWorkingTime");
            close.addEventListener("click", function () {
                const popup = document.querySelector("#setWorkingTime");
                popup.style.display = "none";
            }); 
            const starttime = document.querySelector("#starttime");
            const endtime = document.querySelector("#endtime");
            const submit = document.querySelector("#Add");
            let sessionWork = document.querySelector("#sessionWork");
            starttime.addEventListener("input", CompareTime);
            endtime.addEventListener("input", CompareTime);
            sessionWork.addEventListener("input", function (e) {
                submit.disabled = sessionWork.value.trim() === "";
            }); 
            function CompareTime() {
                let getStartTime = starttime.value;
                let getEndTime = endtime.value; 
                submit.disabled = (getStartTime >= getEndTime || getStartTime === "" || getEndTime === "" || sessionWork.value.trim() === "");
            } 
            const addNewWorkingTime = document.querySelector("#addNewWorkingTime");
            addNewWorkingTime.addEventListener("click", function (event) {
                event.preventDefault();
                const addWorkingTime = document.querySelector("#addWorkingTime");
                addWorkingTime.style.display = "block";
                const popup = document.querySelector("#setWorkingTime");
                popup.style.display = "none";
            }); 
            const CloseAddWorkingTime = document.querySelector(".CloseAddWorkingTime");
            CloseAddWorkingTime.addEventListener("click", function () {
                const addWorkingTime = document.querySelector("#addWorkingTime");
                addWorkingTime.style.display = "none";
                const popup = document.querySelector("#setWorkingTime");
                popup.style.display = "block";
            });

            const addClick = document.getElementById('Add').addEventListener('click', function (event) {
                event.preventDefault();
                const http = new XMLHttpRequest();
                http.open("POST", "addsessiontime?starttime=" + starttime.value + "&endtime=" + endtime.value + "&name=" + sessionWork.value, true);

                http.send();
                http.onreadystatechange = function () {
                    if (this.readyState == 4) {
                        const calamviec = http.responseText;   //'<tr> <td> <input type="checkbox" name="checkboxTime" > </td> <td>' + http.responseText + " </td><tr>";
                        document.querySelector("#addInTable").innerHTML += calamviec;
                        document.querySelector("#addWorkingTime").style.display = "none";
                        location.reload();
                    }
                };
                const popup = document.querySelector("#setWorkingTime");
                popup.style.display = "block";
            }); 
            submit.disabled = (starttime.value === "" || endtime.value === "" || sessionWork.value.trim() === "");
        }); 
        const setSessionWork = document.querySelector("#set");
        if (checkBoxChecked() == true) {
            setSessionWork.disabled = true;
        }
        setSessionWork.addEventListener("click", function (event) {
            event.preventDefault();
            if (checkBoxChecked === true) {
                setSessionWork.disabled = true;
            }
            const http = new XMLHttpRequest();
            console.log(setBox);
            console.log(checkboxTimeArray);
            http.open("POST", "setworksession?dateid=" + getDateId + "&userid=" + userid + "&dayofWeek=" + dayofWeek + "&setsession=" + checkboxTimeArray, true);
            http.send();
            http.onreadystatechange = function () {
                if (this.readyState === 4) {
//                    const row = document.querySelectorAll(".add-schedule");
//                    row.forEach(function (cell) {
//                        if (cell.getAttribute("value") === setBox) {
//                            cell.innerHTML += http.responseText;
//                            const popup = document.querySelector("#setWorkingTime");
//                            popup.style.display = "none";
//                            const checkboxTime = document.querySelectorAll(".checkboxTime");
//                            checkboxTime.forEach(function (item) {
//                                if (item.checked) {
//                                    item.checked = false;
//                                }
//                            });
//                        }
//
//                    });
                    location.reload();
                }
            };

        });


        const checkboxTime = document.querySelectorAll(".checkboxTime");
        checkboxTime.forEach(function (checkbox) {
            checkbox.addEventListener('click', function () {

                const value = checkbox.getAttribute("value");
                if (checkbox.checked) {
                    if (!checkboxTimeArray.includes(value)) {
                        checkboxTimeArray.push(value);
                    }
                } else {
                    const index = checkboxTimeArray.indexOf(value);
                    if (index !== -1) {
                        checkboxTimeArray.splice(index, 1);
                    }
                }
                if (checkboxTimeArray.length === 0) {
                    setSessionWork.disabled = true;
                } else {
                    setSessionWork.disabled = false;
                }


            });

        });



        function checkBoxChecked() {
            let isTrue = true;
            const checkboxTime = document.querySelectorAll(".checkboxTime");
            checkboxTime.forEach(function (item) {
                if (item.checked) {
                    isTrue = false;
                }
            });
            return isTrue;
        }


    </script>
    <style>
        .add-schedule:hover::after {
            content: "+";
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 18px;
            color: green; /* Màu của dấu cộng */
        }
        table {
            height:400px
        }
        #addWorkingTime {

            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 500px;
            height: 700px;
            padding: 20px;
            background-color: #FFE9D0;
            border: 1px solid #ccc;
            z-index: 2; /* Đảm bảo popup hiển thị trên cùng dấu cộng */
            text-align: center;
        }
        .close {
            position: absolute;
            top: 0;
            right: 0;
            padding: 10px;
            cursor: pointer;
        }
        #deleteChecked{
            display: none;
        }


        #setWorkingTime {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            width: 500px;
            height: 700px;
            padding: 20px;
            background-color: #FFE9D0;
            border: 1px solid #ccc;
            z-index: 2; /* Đảm bảo popup hiển thị trên cùng dấu cộng */
            text-align: center;
        }

    </style>
</html>
