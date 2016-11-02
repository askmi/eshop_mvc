<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cart</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" text="text/css" href="<c:url value="/css/styles.css"/>" >
    <script type="text/javascript" src="<c:url value="/js/jquery-3.1.1.min.js"/>"></script>
    <script type="text/javascript" src="<c:url value="/js/main.js"/>"></script>
</head>
<div class="container">
    <div class="row">
        <header>
            <div class="phone"><span class="glyphicon glyphicon-phone"></span> Phonify</div> <%--Gallivant--%>
            <button><u>My cart:</u>
                <span id="cartItems">${empty cart.totalQuantity ? 0 : cart.totalQuantity}</span>
                items <span id="cartPrice">${empty cart.totalPrice ? 0 : cart.totalPrice}</span>$
            </button>
            <div class="clear"></div>
        </header>
    </div>
    <div class="row">
        <h2>Cart</h2>
    </div>
    <div class="row">
        <nav class="cart">
            <a href="<c:url value="productList"/>"><button class="back">Back to product list</button></a>
            <a href="#"><button class="forward">Order</button></a>
        </nav>
    </div>
    <div class="row">
        <table class="cart">
            <tr>
                <th>Model</th>
                <th>Color</th>
                <th>Display Size</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Action</th>
            </tr>
            <c:forEach items="${cart.orderItems}" var="orderItem">
                <c:set value="${orderItem.phone}" var="product" scope="page"/>
                <tr>
                    <td><a href="/productDetails/${product.model}/${product.key}" target="_blank">${product.model}</a></td>
                    <td>${product.color}</td>
                    <td>${product.displaySize}</td>
                    <td>${product.price}</td>
                    <td><input type="text" class="quantityField" key="${product.key}" size="10" value="${orderItem.quantity}"/>
                        <span class="error"></span>
                    </td>
                    <td><button class="deleteFromCartBtn" key="${product.key}">Delete</button></td>
                </tr>
            </c:forEach>
        </table>
        <div class="cartBtns cartForms">
            <form action="">
                <button/>Update</button>
            </form>
            <form action="/">
                <button/>Order</button>
            </form>
        </div>
    </div>
</div>

<script>
    DeleteFromCart();
</script>

</body>
</html>