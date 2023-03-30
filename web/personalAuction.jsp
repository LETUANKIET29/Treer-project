<%-- 
    Document   : personalAuction
    Created on : Mar 23, 2023, 12:00:36 AM
    Author     : tuank
--%>

<%@page import="Treer.dao.AuctionDAO"%>
<%@page import="Treer.dto.Auction"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Personal Auction Manager Page</title>
        <link rel="stylesheet" href="css/bootstrap4.min.css" type="text/css">
        <link rel="stylesheet" href="css/font-awesome.min.css" type="text/css">
        <link rel="stylesheet" href="css/jquery-ui.min.css>" type="text/css">
        <link rel="stylesheet" href="css/styleAdmin.css" type="text/css"/>
    </head>
    <body>
        <div id="page-container" class="main-admin">
            <nav class="navbar navbar-expand-lg navbar-light bg-light position-fixed w-100">
                <a class="navbar-brand" href="#"></a>
                <div id="open-menu" class="menu-bar">
                    <div class="bars"></div>
                </div>
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item dropdown ets-right-0">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <img src="img/Logo.jpg" class="img-fluid rounded-circle border user-profile">
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Profile</a>
                            <a class="dropdown-item" href="#">Change Password</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="mainController?action=logout">Logout</a>
                        </div>
                    </li>
                </ul>
            </nav>
            <div class="side-bar">
                <div class="side-bar-links">
                    <div class="side-bar-logo text-center py-3">
                        <a href="AdminIndex.jsp" >
                            <img src="img/Logo.jpg" class="img-fluid rounded-circle border bg-secoundry mb-3">
                            <h5>Treer</h5>
                        </a>
                    </div>
                    <ul class="navbar-nav">                   
                        <li class="nav-item">
                            <a href="mainController?action=Profile" class="nav-links d-block"><i class="fa fa-user pr-2"></i> THÔNG TIN TÀI KHOẢN</a>
                        </li>
                        <li class="nav-item">
                            <a href="mainController?action=personalPage" class="nav-links d-block"><i class="fa fa-list pr-2"></i> DANH SÁCH ĐƠN HÀNG</a>
                        </li>                  
                        <li class="nav-item">
                            <a href="mainController?action=personalWishList" class="nav-links d-block"><i class="fa fa-list pr-2"></i> SẢN PHẨM YÊU THÍCH</a>
                        </li>
                        <li class="nav-item">
                            <a href="mainController?action=allAuctionShow" class="nav-links d-block"><i class="fa fa-balance-scale pr-2"></i> ĐẤU GIÁ</a>
                        </li>
                        <li class="nav-item">
                            <a href="Feedback.jsp" class="nav-links d-block"><i class="fa fa-comment pr-2"></i> FEEDBACK</a>
                        </li>
                        <li class="nav-item">
                            <a href="index.jsp" class="nav-links d-block"><i class="fa fa-home pr-2"></i> VỀ TRANG CHỦ</a>
                        </li>
                        <li class="nav-item">
                            <a href="mainController?action=logout" class="nav-links d-block"><i class="fa fa-arrow-left"></i> ĐĂNG XUẤT</a>
                        </li>
                    </ul>
                </div>
                <div class="side-bar-icons">
                    <div class="side-bar-logo text-center py-3">
                        <a href="AdminIndex.jsp" >
                            <img src="img/Logo.jpg" class="img-fluid rounded-circle border bg-secoundry mb-3">
                            <h5>Treer</h5>
                        </a>
                    </div> 
                    <div class="icons d-flex flex-column align-items-center">
                        <a href="mainController?action=backToAdminIndex" class="set-width text-center display-inline-block my-1"><i class="fa fa-home"></i></a>
                        <a href="mainController?action=manageAccounts" class="set-width text-center display-inline-block my-1"><i class="fa fa-users"></i></a>
                        <a href="mainController?action=plantsManager" class="set-width text-center display-inline-block my-1"><i class="fa fa-list"></i></a>
                    </div>
                </div>
            </div>
            <div class="main-body-content w-100 ets-pt">
                <h1 style="margin-left: 20px">Danh sách đấu giá</h1>
                <%
                    String name = (String) session.getAttribute("name");
                    int id = (int) session.getAttribute("id");
                    if (name == null) {
                %>
                <h2 style="color: red">You are not login yet!</h2>
                <%
                } else {
                    ArrayList<Auction> list = (ArrayList<Auction>) request.getAttribute("auctionList");
                    if (list != null) {
                %>
                
                <div class="table-responsive bg-light">
                    <br>
                    <!--Bộ lọc cho bảng auction-->
                    <%
                        int accid = (int) session.getAttribute("accid");
                        String button = (String) session.getAttribute("selectedOption");
                        String from = request.getParameter("from");
                        String to = request.getParameter("to");

                        String[] status = {"Đang diễn ra", "Đã kết thúc", "Tất cả"};
                    %>

                    <form action="mainController?action=filterAuctionPersonal" method="post" style="margin-left: 30px">
                        <select name="button">                           
                            <option  value="active" <%= (button == null || button.equals("active")) ? "selected" : ""%>>Đang diễn ra</option>
                            <option  value="inactive" <%= (button == null || button.equals("inactive")) ? "selected" : ""%>>Đã Kết thúc</option>
                            <option  value="all" <%= (button == null || button.equals("all")) ? "selected" : ""%>>Tất cả</option>
                        </select> 

                        <label>từ ngày</label>  
                        <input type="date" name="from" value="<%= from%>">
                        <label>đến ngày</label>
                        <input type="date" name="to" value="<%= to%>">
                        <button type="submit" name="action" id="myButton">Tìm kiếm</button> 
                    </form>
                    <!--Bộ lọc cho bảng auction-END-->

                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">ID</th>
                                <th scope="col">Thời Gian Bắt Đầu</th>
                                <th scope="col">Thời Gian Kết Thúc</th>
                                <th scope="col">Tên Cây Cảnh</th>
                                <th scope="col">Giá Khởi Điểm</th>
                                <th scope="col">Giá Kết Thúc</th>
                                <th scope="col">Bước Nhảy Tối Thiểu</th>
                                <th scope="col">Tình Trạng</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Auction auc : list) {
                            %>
                            <tr>
                                <th scope="row"><%= auc.getAuctionId()%></th>
                                <th><%= auc.getStartTime()%></th>
                                <th><%= auc.getEndTime()%></th>
                                <th><a href="plantsAuctionManagerServlet?keyword=<%= auc.getPlantId()%>&&searchOption=id"><%= AuctionDAO.getNamePlantWithID(auc.getPlantId())%></a></th>
                                <th><%= auc.getStatingPrice()%></th>
                                <th><%= auc.getEndPrice()%></th>
                                <th><%= auc.getBid()%></th>
                                <th>
                                    <% if (auc.getStatus() == 1) {
                                    %>
                                    Đang diễn ra 
                                    <a href="mainController?action=changeAuctionStatus&auctionID=<%= auc.getAuctionId()%>">
                                        <i class="fa fa-exchange"></i>
                                    </a>
                                    <%
                                    } else if (auc.getStatus() == 0) {
                                    %>
                                    Kết Thúc
                                    <a href="mainController?action=changeAuctionStatus&auctionID=<%= auc.getAuctionId()%>">
                                        <i class="fa fa-exchange"></i>
                                    </a>
                                    <% }%>
                                </th>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
                <%
                    }
                %>
            </div>
            <% }%>
            <!-- Js Plugins -->
            <script src="js/jquery-3.2.1.slim.min.js"></script>
            <script src="js/jquery-3.3.1.min.js"></script>
            <script src="js/jquery-ui.min.js"></script>
            <script src="js/jquery.nice-select.min.js"></script>
            <script src="js/jquery.slicknav.js"></script>
            <script src="js/popper.min.js"></script>
            <script src="js/bootstrap4.min.js"></script>
            <script src="js/mainAdmin.js"></script>
            <!--code js cho menu-->   
    </body>
</html>
