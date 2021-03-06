<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.BoardDTO" %>
<%@ page import="kopo.poly.dto.ImgDTO" %>
<%
    BoardDTO rDTO = (BoardDTO) request.getAttribute("rDTO");
    ImgDTO pDTO = (ImgDTO) request.getAttribute("IDTO");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>SeoGram - SEO Agency Template</title>
    <link rel="stylesheet" href="../assets/css/maicons.css">
    <link rel="stylesheet" href="../assets/css/bootstrap.css">
    <link rel="stylesheet" href="../assets/vendor/animate/animate.css">
    <link rel="stylesheet" href="../assets/css/theme.css">
    <link rel="stylesheet" href="../assets/css/inputImg.css">


</head>

<style>

    hr{
        border: none;
        height: 3px;
        /* Set the hr color */
        color: #798777; /* old IE */
        background-color: #798777; /* Modern Browsers */

    }
    .content{
        margin-top: 5%;
        border: 5px solid  #798777;
        width: 100%;
        height: 200px;

    }
    .text{
        margin: 7%;
    }
    #mySpeak{
        margin:6%;
        text-align: center;
        font-size: 35px;
    }

</style>
</style>
<body>


<header>
    <!--nav bar-->
    <%@include file="../views/inc/navbar.jsp" %>
    <!--nav bar-->

    <div class="container">
        <div class="page-banner">
            <div class="row justify-content-center align-items-center h-100">
                <div class="col-md-6">
                    <nav aria-label="Breadcrumb">
                        <ul class="breadcrumb justify-content-center py-0 bg-transparent">
                            <li class="breadcrumb-item"><a href="/home">Home</a></li>
                            <li class="breadcrumb-item active">About</li>
                        </ul>
                    </nav>
                    <h1 class="text-center">???????????? ????????????</h1>

                </div>
            </div>
        </div>
    </div>
</header>


<div class="page-section">

    <div class="container">
        <h1 class="post-title" style="text-align: center;">Voice Search!!</h1>
        <div class="post-meta">





            <div class="post-content" style="width: 100%;height: 500px;" >

                <div class="form-group" style="">

                    <div class="content">
                        <div id="mySpeak" style="">????????????</div>

                    </div>


                </div>

                <div id="micButtonBox" class="row justify-content-sm-center mic_box" style="margin-top: 30px; clear: both;">
                </div>

            </div>


        </div>
        <div><h2>????????????</h2></div>
        <hr>
        <div id="result"></div>
    </div><!-- .container -->


</div> <!-- .section -->


<!--footer-->

<%@include file="../views/inc/footbar.jsp" %>

<!--footer-->
<script src="../assets/js/jquery-3.5.1.min.js"></script>
<!-- annyang js & speechkitt -->
<script src="../assets/js/annyang.js"></script>
<script src="../assets/js/speechkitt.js"></script>
<script>

    if (annyang) {
        // Add our commands to annyang
        annyang.addCommands({});

        //???????????? ??? ?????????????????? ?????? ??????
        let recognition = annyang.getSpeechRecognizer();
        //?????? ???????????? ????????? ?????? ??????
        let final_transcript = "";
        //????????? ????????? ???????????? ??? ????????????(??????)
        recognition.interimResults = true;
        //?????? ???????????? ????????????
        recognition.onresult = function (event) {
            final_transcript = "";
            for (let i = event.resultIndex; i < event.results.length; ++i) {
                if (event.results[i].isFinal) {
                    final_transcript += event.results[i][0].transcript;
                    final_transcript = final_transcript.trim();
                    console.log("final :" + final_transcript);
                }
            }

            $("#mySpeak").html(final_transcript);

            $.ajax({
                url: "/word/analysis",
                type: "post",
                data: {
                    "text": final_transcript,

                },
                success: function (word) {

                    search(word);


                }
            });

        }

        // Tell KITT to use annyang
        SpeechKITT.annyang();

        // Define a stylesheet for KITT to use
        SpeechKITT.setStylesheet('../assets/css/flat.css');

        // Render KITT's interface
        SpeechKITT.vroom();
    };


    function search(dicnm){
    //    let word='';
   //     for (let i = 0; i < dicnm.length; i++) {
   //         console.log (dicnm[i].dicnm );
   //         dicnm[i].dicnm = dicnm[i].dicnm;
    //    }


   /*     if (typeof SpeechSynthesisUtterance === "undefined" || typeof window.speechSynthesis === "undefined") {
            alert("??? ??????????????? ?????? ????????? ???????????? ????????????.")
            return
        }*/
/*
        window.speechSynthesis.cancel() // ?????? ??????????????? ?????????*/

        var html='';

            if (dicnm == '') {
              //  text = "???????????? ???????????? ????????? ?????? ??????????????????";
                html = '<h6 id=res>???????????? ???????????? ????????? ?????? ??????????????????.</h6>';
                $("#result").html(html);
            } else {
                for(let i=0;i<dicnm.length;i++) {
                //text = word + "???????????? ????????? ???????????????.";
                html += '<h6 id=res><a href="/infoPg?DICNM=' +  dicnm[i].dicnm + '">' +  dicnm[i].dicnm + '</a> ???????????? ????????? ???????????????.</h6>'
                }
                $("#result").html(html);
            }




    /*    const speechMsg = new SpeechSynthesisUtterance()
        speechMsg.rate =  1 // ??????: 0.1 ~ 10
        speechMsg.pitch =  1 // ?????????: 0 ~ 2
        speechMsg.lang = "ko-KR"
        speechMsg.text =text;

        // SpeechSynthesisUtterance??? ????????? ????????? ???????????? ???????????? ??????
        window.speechSynthesis.speak(speechMsg)*/
    }


</script>

</body>
</html>