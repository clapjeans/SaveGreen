<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.MapDTO" %>
<%
    List<MapDTO> rList = (List<MapDTO>) request.getAttribute("getInfoList");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>SeoGram - SEO Agency Template</title>
    <link rel="stylesheet" href="./assets/css/maicons.css">
    <link rel="stylesheet" href="./assets/css/bootstrap.css">
    <link rel="stylesheet" href="./assets/vendor/animate/animate.css">
    <link rel="stylesheet" href="./assets/css/theme.css">
    <style>
        .box{
            position: relative;
            margin: 10px 0;
            padding: 35px;
            border: solid 1px #979fa8;

        }
        .box .box_title {
            margin-bottom: 10px;
            font-size: 25px;
            font-weight: 500;
            color: #1d1d1d;
            word-break: keep-all;
            text-align: center;
        }

        .box.icon .box_wrap:before {
            display: block;
            position: absolute;
            top: 0;
            left: 0;
            width: 100px;
            height: 100px;

            position: static;
            margin: 0 auto 30px;
            background: no-repeat url("../assets/img/trash_icon.png");
        }
        .box.icon .box_wrap:before {
            position: static;
            margin: 0 auto 30px;
        }
        :after, :before {
            display: none;
            content: '';
        }

        .table tr th{
            background-color: #E9E5D6;
            border: #a6a6a6 solid 1px;
        }
        .table td{
            border: #a6a6a6 solid 1px;
        }
        h3, body{
            font-size: 17px;
        }
        .title-section{
            font-size: 25px;
        }
        p{
            text-align: center;
            margin-bottom: 0px;
        }
        .btn{
            margin-bottom: 30px;

        }

        /* DivTable.com */
        .divTable{
            display: table;
            width: 100%;
        }
        .divTableRow {
            display: table-row;
        }
        .divTableHeading {
            background-color: #EEE;
            display: table-header-group;
        }
        .divTableCell, .divTableHead {
            border: 0.5px solid #a6a6a6;
            display: table-cell;
            padding: 15px;
        }
        .divTableHeading {
            background-color: #EEE;
            display: table-header-group;

        }
        .divTableFoot {
            background-color: #EEE;
            display: table-footer-group;
            font-weight: bold;
        }
        .divTableBody {
            display: table-row-group;
        }
        .divTableHead{
            background-color: #E9E5D6;
          font-weight: bold;
            width: 30%;
        }

    </style>
    <script>
        //???????????????
        function back() {
            history.go(-1);
        }

    </script>
</head>
<body>

<!-- Back to top button -->
<div class="back-to-top"></div>

<header>


    <%@include file="../../views/inc/navbar.jsp"%>

    <div class="container">
        <div class="page-banner">
            <div class="row justify-content-center align-items-center h-100">
                <div class="col-md-6">
                    <nav aria-label="Breadcrumb">
                        <ul class="breadcrumb justify-content-center py-0 bg-transparent">
                            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                            <li class="breadcrumb-item active">location</li>
                        </ul>
                    </nav>
                    <h1 class="text-center">?????? ????????????</h1>

                </div>
            </div>
        </div>
    </div>
</header>

<!---????????? ??????-->


    <div class="page-section">

        <div class="container">

            <div class="box icon">
                <div class="box_wrap">
                    <%for (MapDTO mDTO: rList) { %>
                    <div class="box_title">????????? <%=CmmUtil.nvl(mDTO.getGu_name())%>&nbsp;<%=CmmUtil.nvl(mDTO.getGu_num())%>????????? ????????????</div>
                    <p style="text-align: center;">????????????????????? <%=mDTO.getGu_place()%></p>
                    <p style="text-align: center;">??????????????? ????????????????????? ???????????????????????????.</p>
                </div>
            </div>

            <h2 class="title-section" style="margin-top: 50px;">????????????</h2>
            <div class="divider"></div>
            <ul>
                <li><h3 class=""><%=mDTO.getPlace()%> ?????? ??????????????????.</h3></li>
                <li><h3>??????????????? <%=mDTO.getDayoff()%> ?????????.</h3></li>
                <li> <h3>??????????????? ?????????????????? <%=mDTO.getPhone()%>????????????????????????.</h3></li>

            </ul>



            <h2 class="title-section" style="margin-top: 50px;">???????????????</h2>
            <div class="divider"></div>
            <div class="divTable">
                <div class="divTableBody">
                    <div class="divTableRow">
                        <div class="divTableHead">????????????</div>
                        <div class="divTableCell"><%=mDTO.getLife_way()%></div>
                    </div>
                    <div class="divTableRow">
                        <div class="divTableHead">????????????</div>
                        <div class="divTableCell"><%=mDTO.getLife_dy()%></div>
                    </div>
                    <div class="divTableRow">
                        <div class="divTableHead">????????????</div>
                        <div class="divTableCell"><%=mDTO.getLife_tm1()%>&nbsp;~&nbsp;<%=mDTO.getLife_tm2()%></div>
                    </div>
                </div>
            </div>


            <h2 class="title-section" style="margin-top: 50px;">?????????</h2>
            <div class="divider"></div>
            <div class="divTable">
                <div class="divTableBody">
                    <div class="divTableRow">
                        <div class="divTableHead">????????????</div>
                        <div class="divTableCell"><%=mDTO.getRec_way()%></div>
                    </div>
                    <div class="divTableRow">
                        <div class="divTableHead">????????????</div>
                        <div class="divTableCell"><%=mDTO.getRec_dy()%></div>
                    </div>
                    <div class="divTableRow">
                        <div class="divTableHead">????????????</div>
                        <div class="divTableCell"><%=mDTO.getRec_tm1()%>&nbsp;~&nbsp;<%=mDTO.getRec_tm2()%></div>
                    </div>
                </div>
            </div>

            <h2 class="title-section" style="margin-top: 50px;">??????????????????</h2>
            <div class="divider"></div>
            <div class="divTable">
                <div class="divTableBody">
                    <div class="divTableRow">
                        <div class="divTableHead">????????????</div>
                        <div class="divTableCell"><%=mDTO.getFood_way()%></div>
                    </div>
                    <div class="divTableRow">
                        <div class="divTableHead">????????????</div>
                        <div class="divTableCell"><%=mDTO.getFood_dy()%></div>
                    </div>
                    <div class="divTableRow">
                        <div class="divTableHead">????????????</div>
                        <div class="divTableCell"><%=mDTO.getFood_tm1()%>&nbsp;~&nbsp;<%=mDTO.getFood_tm2()%></div>
                    </div>
                </div>
            </div>

            <% } %>
            <button type="submit" class="btn btn-secondary" onclick="back()" style="margin-top: 20px" >???????????? <span class="mai-filter"></span></button>
        </div> <!-- .container -->



<%@include file="../../views/inc/footbar.jsp"%>

<script src="./assets/js/jquery-3.5.1.min.js"></script>

<script src="./assets/js/bootstrap.bundle.min.js"></script>

<script src="./assets/vendor/wow/wow.min.js"></script>

<script src="./assets/js/theme.js"></script>


</body>
</html>