<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.Product" %>
<%@ page import="Model.Customer" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.ico"> 
        <title>Trang bán hàng</title>   
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"> 
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css"> 
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-confirm/3.3.2/jquery-confirm.min.css"> 
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>  
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">   
        <link rel="stylesheet" href="View/CSS/staff.css">
        <style> 
            #customerResult {
                position: absolute;
                top: 19%;
                left: 1430px;
                right: 0;
                width: 199px;
                background-color: #fff;
                z-index: 1000;
                max-height: 400px;
                overflow-y: auto;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }
            #results {
                border: 1px solid #ccc;
                position: absolute;
                top: 100%;
                width: 500px;
                left: 0;
                right: 0;
                background-color: #fff;
                z-index: 1000;
                max-height: 400px;
                overflow-y: auto;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }
            .result-item {
                display: flex;
                padding: 10px;
                border-bottom: 1px solid #ddd;
                cursor: pointer;
            }
            .result-item:last-child {
                border-bottom: none;
            }
            .result-item:hover {
                background-color: #f1f1f1;
            }
            .modal-body .center-bill {
                display: flex;
                justify-content: space-between;
            }

            .modal-body .total-bill {
                margin-top: 5px; 
            }
            .total-bill .span {
                font-size: 17px;
            }
            table, thead, tbody {
                font-family: Arial, sans-serif;
                border-collapse: collapse;
                width: 100%;
            }
            
            td, th {
                border: 1px solid #dddddd;
                text-align: left;
                padding: 8px;
            }
            .header-left .fa-trash {
                position: relative; 
                font-size: 30px; 
                cursor: pointer;
            }
    </style>
    </head>
    
    <body>
        <!-- HEADER -->
        <div class="background-header">
            <div class="header-all">
                <div class="header-left">
                    <input type="search" id="handleTextSearch" placeholder="Tìm hàng hóa">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <a href="#" onclick="handleDelete(0, event)" >
                        <i class="fa-solid fa-trash"></i>
                    </a>
                    <div id="results"></div>  
                </div>  
                <div class="header-right">
                    <span>${account.getUsername()}</span>
                    <a href="logout">
                        <i class="fa-solid fa-right-from-bracket"></i>
                    </a>
                </div>  
            </div>
        </div> 
        <!-- MAIN -->
        <div class="main">
            <div class="main-left">
                <div class="scroll-item"> 
                    <c:forEach items="${productOrder}" varStatus="pIndex" var="p">  
                    <div class="list-item">
                        <div class="item-left"> 
                            <span>${pIndex.index + 1}</span> 
                            <a href="#" onclick="handleDelete('${p.getProductID()}', event)" >
                                <i class="fa-regular fa-trash-can"></i>
                            </a> 
                            <div class="item-content">
                                <div class="item-container">
                                    <div class="item-info">
                                        <div class="item-info-top">
                                            <span>${p.getProductID()}</span>
                                            <span>${p.getProductName()}</span>
                                        </div>
                                        <div class="item-info-botto"> 
                                            <div class="quantity"> 
                                                <button class="quantity-item-minus btn" id="sub" onclick="handleQuantity('sub', '${p.getProductID()}', event)">-</button>
                                                <span></span>
                                                <input type="text" required min="1" id="quantity${p.getProductID()}" value=${p.getQuantity()} onchange="handleChange('${p.getProductID()}')"/>
                                                <button class="quantity-item-plus btn" id="add" onclick="handleQuantity('add', '${p.getProductID()}', event)">+</button> 
                                            </div> 
                                            <div class="item-space"></div>
                                            <div class="item-price">
                                                <div class="sale">
                                                    <span id="price${p.getProductID()}"><fmt:formatNumber>${p.getPrice()}</fmt:formatNumber></span>
                                                    <hr>
                                                </div>
                                                <div class="totalSale">
                                                    <span id="getTotalPrice${p.getProductID()}"><fmt:formatNumber>${p.getPrice() * p.getQuantity() }</fmt:formatNumber></span>
                                                    <hr>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
<!--                        <div class="item-action">
                            <a href>
                                <i class="fa-solid fa-plus"></i>
                            </a>
                            <a href>
                                <i class="fa-solid fa-ellipsis-vertical"></i>
                            </a>
                        </div>-->
                    </div>
                    </c:forEach>
                </div> 
            </div> 
            <div class="main-right">
                <div class="main-right-container">
                    <div class="cart-header-control">
                        <p></p>
                        <div class="getDate">date</div>
                    </div>
                    <hr class="hr">
                    <form>
                        <div class="main-right-body"> 
                            <div class="customer-type">
                                <label>
                                    Thông tin khách hàng
                                </label>
                                <div class="customer-type-info">
                                    <input id="idCustomer" hidden="" /> 
                                    <input id="phoneNumber" name="phone" type="text" placeholder="Nhập số điện thoại khách hàng" /> 
                                    <input id="nameCustomer"name="name" type="text" placeholder="Nhập tên khách hàng" /> 
                                    <div id="customerResult"></div> 
                                </div> 
                            </div> 
                            <div class="total-price-bill">
                                <div class="total-price-bill-detail">
                                    <span>Tổng tiền hàng</span> 
                                </div>
                                <input readonly type="text" id="total-order"/>
                            </div>
                            <div class="sale button">
                                <span>Giảm giá (%)</span>
                                <input id="discount" type="text" value="0"/>
                            </div>
                            <div class="customer-need">
                                <span>Khách cần trả</span>
                                <input readonly type="text" id="total-pay"/>
                            </div>
                            <div class="customer-pay">
                                <span>Khách thanh toán</span>
                                <input type="text" id="payed-money"/> 
                            </div>  
                            <div class="customer-pay">
                                <span>Tiền thừa: </span>
                                <input readonly type="text" value="0" id="refund-money"/> 
                            </div> 
                        </div>

                        <div class="payment-method">
                            <p>
                                <input type="radio" name="payment" value="1"> Tiền mặt
                            </p>
                            <p>
                                <input type="radio" name="payment" value="2"> Chuyển khoản
                            </p>
                        </div> 
                        <div class="hint-price">
                            <div class="hint-price-top horver">
                                <button type="button" onclick="handleHint('10.000')" class="price">10.000</button>
                                <button type="button" onclick="handleHint('20.000')" class="price">20.000</button>
                                <button type="button" onclick="handleHint('30.000')" class="price">30.000</button>
                                <button type="button" onclick="handleHint('50.000')" class="price">50.000</button>
                            </div>
                            <div class="hint-price-bottom horver">
                                <button type="button" onclick="handleHint('100.000')" class="price">100.000</button>
                                <button type="button" onclick="handleHint('200.000')" class="price">200.000</button>
                                <button type="button" onclick="handleHint('300.000')" class="price">300.000</button>
                                <button type="button" onclick="handleHint('500.000')" class="price">500.000</button>
                            </div>
                        </div> 
                        <div class="payment-btn">
                            <button id="payorder" class="btn" data-toggle="modal" data-target="#payOrder" type="button">Thanh toán</button>
                        </div>
                    </form> 
                </div>
            </div>
            <div class="modal fade" id="payOrder">
                <div class="modal-dialog modal-dialog-centered" >
                    <div class="modal-content"> 
                        <div class="modal-header" style="display: flex; justify-content: center">
                            <h4>Thông tin thanh toán</h4>
                        </div>
                        <div class="modal-body">
                            <img id="qrcode" src="" alt="QR Code" style="display:none; margin-top: 20px; width: 100%; max-width: 500px;">
                            <h4 style="font-size: 22px; text-align: center; color: blue; font-style: italic" id="info"></h4>
                            <h4 style="font-size: 22px; text-align: center; color: blue; font-style: italic" id="showtotal"></h4>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-success" data-toggle="modal"
                                  data-target="#modalPay" data-dismiss="modal" data-id="1" type="button">Hoàn tất</button>
                            &nbsp;
                            <button class="btn btn-warning" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div> 
        </div>  
        <div class="modal fade" id="modalPay" tabindex="-1" role="dialog"
            aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="display: flex; justify-content: center;">
                        <h4 class="modal-title" id="exampleModalLongTitle">HÓA ĐƠN BÁN HÀNG</h4>
                    </div>
                    <div class="modal-body">
                        <div class="center-bill total-bill">
                            <p id="dateNow"></p>
                            <p id="idBill"></p>
                        </div>
                        <div class="center-bill total-bill">
                            <p>Thu ngân: ${account.getUsername()}</p>
                            <p id="infoCustomer"></p>
                        </div> 
                        <div class="table-responsive">
                            <table> 
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Mặt Hàng</th>
                                        <th>SL</th>
                                        <th>Đ.Giá</th>
                                        <th>T.Tiền</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${productOrder}" varStatus="pIndex" var="p">  
                                    <tr>
                                        <td>${pIndex.index+1}</td>
                                        <td>${p.getProductName()}</td>
                                        <td>${p.getQuantity()}</td>
                                        <td><span><fmt:formatNumber>${p.getPrice()}</fmt:formatNumber></span></td>
                                        <td><span><fmt:formatNumber>${p.getPrice() * p.getQuantity() }</fmt:formatNumber></span></td>
                                    </tr> 
                                    </c:forEach>
                                </tbody> 
                            </table>
                        </div> 
                        <div class="center-bill total-bill" >
                            <span>Tổng tiền hàng:</span>
                            <span id="totalBill"></span>
                        </div>
                        <div class="center-bill total-bill" >
                            <span>Giảm giá:</span>
                            <span id="discount-bill"></span>
                        </div>   
                        <div class="center-bill total-bill" >
                            <span>Tiền cần thanh toán:</span>
                            <span id="need-pay"></span>
                        </div>
                        <div class="center-bill total-bill" >
                            <span>Khách thanh toán:</span>
                            <span id="billpay"></span>
                        </div> 
                        <div class="center-bill total-bill" >
                            <span>Tiền thừa: </span>
                            <span id="billrefund"></span>
                        </div><br> 
                        <span style="display: flex; justify-content: center;"><i>Cảm ơn đã mua hàng. Hẹn gặp lại !</i></span>
                        </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-warning" data-dismiss="modal"">Cancel</button>
                                <button type="button" class="btn btn-primary" onclick="window.print()">In ra</button>
                                <button type="button" class="btn btn-success" onclick="createOrder('${account.getUserID()}')">Hoàn Tất</button>
                            </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="View/JS/getdate.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script> 
        <script> 
            document.addEventListener('DOMContentLoaded', function (){
                getTotalPay();
            });
            document.getElementById('payorder').addEventListener('click', function(){
                const button = document.getElementById('payorder');
                const typePay = document.getElementsByName('payment'); 
                var payBill = document.getElementById('billpay');
                var refundBill = document.getElementById('billrefund');
                var totalBill = document.getElementById('totalBill');   
                var discountBill = document.getElementById('discount-bill');  
                var idBill = document.getElementById('idBill'); 
                var infoCustomer = document.getElementById('infoCustomer');
                var needpay = document.getElementById('need-pay');
                var cusPay = document.getElementById('payed-money').value;
                var refund = document.getElementById('refund-money').value; 
                var totalPay = document.getElementById('total-pay').value;
                var totalOrder = document.getElementById('total-order').value;  
                if(typePay[0].checked){ 
                    button.setAttribute('data-target', '#modalPay'); 
                } 
                else{  
                    button.setAttribute('data-target', '#payOrder'); 
                    getQrCode();
                }   
                payBill.textContent = cusPay; 
                refundBill.textContent = refund === "" ? 0 : refund; 
                needpay.textContent = formatInput(totalPay);
                totalBill.textContent = formatInput(totalOrder);
                discountBill.textContent = formatInput(formatNumber(totalOrder) - formatNumber(totalPay)); 
                idBill.textContent = "Mã Hóa Đơn: " + generateInvoiceCode(); 
                infoCustomer.textContent = "Khách hàng: " + getInfoCustomer();
                getDateNow();
            }) 
            function getDateNow() { 
                var dateNow = document.getElementById('dateNow');
                var now = new Date(); 
                var date = now.getDate();
                var month = now.getMonth() + 1;  
                var year = now.getFullYear(); 
                var hours = now.getHours();
                var minutes = now.getMinutes();
                var seconds = now.getSeconds(); 
                var formattedDate = date + "/" + month + "/" + year;
                var formattedTime = hours + ":" + minutes + ":" + seconds; 
                dateNow.textContent = "Ngày: " + formattedDate + " " + formattedTime; 
            }
            function getInfoCustomer(){  
                var nameCustomer = document.getElementById('nameCustomer').value;
                return nameCustomer ? nameCustomer : "Khách Lẻ";  
            } 
            function generateInvoiceCode() {
                const characters = '0123456789';
                let invoiceCode = '';
                for (let i = 0; i < 8; i++) {
                    const randomIndex = Math.floor(Math.random() * characters.length);
                    invoiceCode += characters[randomIndex];
                }
                return "HD" + invoiceCode;
            }
            function getQrCode(){ 
                var total_pay = document.getElementById('total-pay'); 
                const Bank_ID = "MB";
                const Account_ID = "0352986307";  
                const amount = formatNumber(total_pay.value);
                const decription = "Thanh toán đơn hàng " + generateInvoiceCode() ;
                const accountName = "Dao Trong Khoi";
                var qr = document.getElementById('qrcode'); 
                var info = document.getElementById('info');
                var total = document.getElementById('showtotal');
                info.textContent = "Scan QR To Pay";  
                total.textContent = "Tổng số tiền cần thanh toán: " + formatInput(amount);
                qr.src = "https://img.vietqr.io/image/" + Bank_ID + "-" + Account_ID + "-compact.png?amount=" + amount + "&addInfo="+decription+ "&accountName=" +accountName;
                qr.style.display = 'block'; 
            }   
            document.getElementById('discount').addEventListener('input', function (){
                var discount = document.getElementById('discount').value;
                var total_pay = document.getElementById('total-pay'); 
                var payed = document.getElementById('payed-money');
                var refundMoney = document.getElementById('refund-money');
                var totalOrder = document.getElementById('total-order'); 
                var totalValue =  formatNumber(totalOrder.value);  
                if(discount > 0){
                    total_pay.value = formatInput((totalValue - (totalValue / 100 * discount))); 
                    payed.value = formatInput((totalValue - (totalValue / 100 * discount))); 
                    refundMoney.value = 0;
                }
                else{
                    total_pay.value = formatInput(totalValue);
                    payed.value = formatInput(totalValue);
                }
            }); 
            document.getElementById('payed-money').addEventListener('input', function(){
                var payedInput = document.getElementById('payed-money');
                var value = payedInput.value.replace(/\D/g, '');
                value = value.replace(/\B(?=(\d{3})+(?!\d))/g, '.'); 
                payedInput.value = value;
                handleRefund();
            });
            function handleRefund(){
                var payed_input = document.getElementById('payed-money'); 
                var payedValue = formatNumber(payed_input.value); 
                var refund_money = document.getElementById('refund-money');
                var total_pay = document.getElementById('total-pay');
                var refundValue = 0;    
                var totalVlue = formatNumber(total_pay.value);  
                if(payedValue - totalVlue >= 0){
                    refundValue = payedValue - totalVlue; 
                }  
                refund_money.value = refundValue == 0 ? 0 : formatInput(refundValue);
            }
            function formatInput(value){ 
                value = value.toString().replace(/\D/g, ''); 
                return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, '.');
            }
            function formatNumber(input){ 
                return input.replace(/\D/g, '');
            }
            function handleHint(price){
                var payed_input = document.getElementById('payed-money'); 
                payed_input.value = price; 
                handleRefund();
            } 
            function getTotalPay(){
                var total = 0;
                var productItems = document.querySelectorAll('.totalSale span'); 
                var totalOrder = document.getElementById('total-order');
                var totalPay = document.getElementById('total-pay');
                var payedmoney = document.getElementById('payed-money');  
                productItems.forEach((productItem) => { 
                    var value = formatNumber(productItem.textContent);
                    total += parseFloat(value); 
                });   
                 
                totalOrder.value = formatInput(total); 
                totalPay.value = formatInput(total); 
                payedmoney.value = formatInput(total); 
            }
            function handleChange(pID){  
                var quantity = document.getElementById('quantity' + pID).value; 
                var formQuantity = document.createElement("form");
                formQuantity.method = "POST";
                formQuantity.action = "salecontroller?type=" + quantity + "&pID=" + pID;  
                document.body.appendChild(formQuantity); 
                formQuantity.submit();   
            }
            function handleQuantity(type, pID, event){  
                event.preventDefault();   
                var formQuantity = document.createElement("form");
                formQuantity.method = "POST";
                formQuantity.action = "salecontroller?type=" + type + "&pID=" + pID;  
                document.body.appendChild(formQuantity); 
                formQuantity.submit();   
            }  
            function getQuantity(pID){
                var quantity = document.getElementById('quantity' + pID);
                return quantity.value;
            }
            function handleDelete(pID, event){ 
                if(event !== null){ 
                    event.preventDefault();  
                } 
                var formDelete = document.createElement('form');
                formDelete.method = 'POST';
                if(pID == 0){
                    formDelete.action = "salecontroller?type=removeAll&pID=0"; 
                } 
                else{
                    formDelete.action = "salecontroller?type=delete&pID=" + pID; 
                } 
                document.body.appendChild(formDelete); 
                formDelete.submit();  
            }
            function handleSubmit(id){    
                var form = document.getElementById('formSubmit'); 
                form.action = "salecontroller?type=order&pID=" + id;
                form.submit();  
            }
            const Toast = Swal.mixin({
                toast: true,
                position: "top-end",
                showConfirmButton: false,
                timer: 1000,
                timerProgressBar: true,
                didOpen: (toast) => {
                    toast.addEventListener('mouseenter', Swal.stopTimer);
                    toast.addEventListener('mouseleave', Swal.resumeTimer);
                },
                willClose: (status) => {
                    const stt = status.getAttribute('data-custom'); 
                    if(stt === "success"){
                        localStorage.setItem("customer", null);
                        handleDelete(0, null);
                    }
                }
            });
            function createOrder(staffId){ 
                const invoiceId = document.getElementById('idBill').textContent.substring(12); 
                const totalPrice = document.getElementById('total-pay').value; 
                var phoneNumber = document.getElementById('phoneNumber').value;  
                var name = document.getElementById('nameCustomer').value; 
                const customer = localStorage.getItem("customer");  
                var phoneValue;
                var nameValue; 
                if(phoneNumber === "" && name === ""){
                    localStorage.setItem("customer", null);
                    phoneValue = "No Data.";
                    nameValue = "Khách lẻ"; 
                } 
                else{
                    localStorage.setItem("customer", null);
                    phoneValue = phoneNumber;
                    nameValue = name; 
                }  
                $.ajax({ 
                    url: 'invoice',
                    type: 'POST',
                    data:{
                        invoiceID: invoiceId,
                        staffID: staffId,
                        customerString: customer,
                        phoneValue: phoneValue,
                        nameValue: nameValue,
                        totalPrice: formatNumber(totalPrice) 
                    } ,
                    success: function (respone) {  
                        Toast.fire({
                            icon: respone,
                            title: respone === "success" ? "Thêm hóa đơn thành công":"Thêm hóa đơn thất bại!",
                             didOpen: (toast) => { 
                                toast.setAttribute('data-custom', respone);
                            }
                        }); 
                    }
                });
            }
            document.getElementById('phoneNumber').addEventListener('input', function(){
                var text = document.getElementById('phoneNumber');  
                var inputName = document.getElementById('nameCustomer'); 
                $.ajax({
                    url: 'CustomerSearch',
                    type: 'GET',
                    data: {
                        textSearch: text.value
                    },   
                    success: function(response) { 
                        $('#customerResult').empty();
                        if (response.length > 0) {
                            response.forEach(function(customer) { 
                                var items =  $(
                                  '<div class="result-item"><form id="formSubmit" method="post"><div class="item-name">' +
                                        customer.name   +
                                   '</div></form></div>'
                                );
                                items.on('click', function (){   
                                    text.value = customer.phoneNumber;
                                    inputName.value = customer.name;  
                                    localStorage.setItem("customer", JSON.stringify(customer));   
                                    $('#customerResult').empty();
                                });
                                $('#customerResult').append(items); 
                            });
                        } else {
                            $('#customerResult').empty(); 
                        }
                    }
                });
            }); 
            document.getElementById('handleTextSearch').addEventListener('input', function(){  
                var text = document.getElementById('handleTextSearch');   
                $.ajax({
                    url: 'salecontroller',
                    type: 'GET',
                    data: {
                        textSearch: text.value
                    },   
                    success: function(response) { 
                        $('#results').empty();
                        if (response.length > 0) {
                            response.forEach(function(product) { 
                               var items =  $(
                                  '<div class="result-item"><form id="formSubmit" method="post"><div class="item-name" id="handleitemselected">' +
                                        product.productName +
                                   '</div></form></div>'
                                );
                                items.on('click', function (){ 
                                    handleSubmit(product.productID);
                                    text.value = "";
                                    $('#results').empty();
                                });
                                $('#results').append(items); 
                            });
                        } else {
                            $('#results').empty();
                            $('#results').append('<div class="result-item">Không tìm thấy sản phẩm.</div>');
                        }
                    }
                });
            }); 
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
