<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Bootstrap Elegant Account Login Form with Avatar Icon</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <style>
        body {
            background-color: #ACB992;

            font-family: 'Varela Round', sans-serif;
            margin-top: 200px;
        }

        .form-control {
            box-shadow: none;
            border-color: #ddd;
        }

        .form-control:focus {
            border-color: #4aba70;
        }

        .login-form {
            width: 600px;
            margin: 0 auto;
            padding: 30px 0;
        }

        .login-form form {
            color: #434343;
            border-radius: 1px;
            margin-bottom: 15px;
            background: #fff;
            border: 1px solid #f3f3f3;
            box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
            padding: 30px;
        }

        .login-form h4 {
            text-align: center;
            font-size: 22px;
            margin-bottom: 20px;
        }

        .login-form .avatar {
            color: #fff;
            margin: 0 auto 30px;
            text-align: center;
            width: 100px;
            height: 100px;
            border-radius: 50%;
            z-index: 9;
            background: #ACB992;
            padding: 15px;
            box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.1);
        }

        .login-form .avatar i {
            font-size: 62px;
        }

        .login-form .form-group {
            margin-bottom: 20px;
        }

        .login-form .form-control, .login-form .btn {
            min-height: 40px;
            border-radius: 2px;
            transition: all 0.5s;
        }

        .login-form .close {
            position: absolute;
            top: 15px;
            right: 15px;
        }

        .login-form .btn {
            background: #ACB992;
            border: none;
            line-height: normal;
        }

        .login-form .btn:hover, .login-form .btn:focus {
            background:#ACB992;
        }

        .login-form .checkbox-inline {
            float: left;
        }

        .login-form input[type="checkbox"] {
            margin-top: 2px;
        }

        .login-form .forgot-link {
            float: right;
        }

        .login-form .small {
            font-size: 18px;
            margin-top: 10px;
        }

        .login-form a {
            color:#464E2E;
        }
    </style>
</head>
<body>
<div class="login-form">
    <form action="/login" method="post">
        <div class="avatar"><i class="material-icons">&#xE7FF;</i></div>
        <h4 class="modal-title">Login to Your Account</h4>
        <div class="form-group">
            <p style="font-weight:900">Useremail</p>
            <input type="text" class="form-control" placeholder="Enter Useremail" required="required" name="user_email">
        </div>
        <div class="form-group">
            <p style="font-weight:900">password</p>
            <input type="password" class="form-control" placeholder="Enter password" required="required" name="user_pw">
        </div>
        <div class="form-group small clearfix">
            <a href="/findPwPage" class="forgot-link">Forgot Password?</a>
        </div>
        <input type="submit" class="btn btn-primary btn-block btn-lg" value="Login">
        <div class="text-center small">Don't have an account? <a href="/register">Sign up</a><p>or</p></div>
        <div class="text-center small">Do you want to go back?<a href="/home">home</a></div>
    </form>

</div>
</body>
</html>