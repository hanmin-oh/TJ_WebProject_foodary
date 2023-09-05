<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 전 메인페이지</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<script src="js/jquery.min.js"></script>
<script src="js/jquery.poptrox.min.js"></script>
<script src="js/jquery.scrolly.min.js"></script>
<script src="js/jquery.scrollex.min.js"></script>
<script src="js/skel.min.js"></script>
<script src="js/init.js"></script>
<link rel="stylesheet" href="css/skel.css" />
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/style-wide.css" />
<link rel="stylesheet" href="css/style-normal.css" />
<link rel="stylesheet" href="css/fiveGrid.css"/>
<script type="text/javascript" src="../js/jquery-3.7.0.js"></script>
<script type="text/javascript" src="../js/mainFunction.js"></script>
</head>
<body>
	<header id="header">
		<!-- Logo -->
			<a href="?" style="
				font-family: 'insungitCutelivelyjisu'; font-size: 28pt; font-weight: 900;
				color: black; cursor: pointer; text-decoration: none;">
				Foodary
			</a>
		<!-- Nav -->
			<nav id="nav">
				<ul>
					<li>
						<a href="#" style="font-family: 'insungitCutelivelyjisu';
							color: black; cursor: pointer; text-decoration: none;">
							<span style="background: lavender; color:black; font-size: 20pt;">Join</span>
						</a>
					</li>
					<li>
						<a href="#" style="font-family: 'insungitCutelivelyjisu';
							color: black; cursor: pointer; text-decoration: none;">
							<span style="background: #baffda; color:black; font-size: 20pt;">Login</span>
						</a>
					</li>
				</ul>
			</nav>
	</header>
	<!-- Intro -->
		<section id="intro" class="main style1 fullscreen">
			<div class="content container 75%">
				<header>
					<a href="?" style="
						font-family: 'insungitCutelivelyjisu'; font-size: 70pt; font-weight: 900;
						color: black; cursor: pointer; text-decoration: none;">
						Foodary
					</a>
				</header>
				<p class="text-center">
					<span style="background: #fafcd9; font-family: 'insungitCutelivelyjisu'; font-size: 26pt;">"내 몸을 위한 일기장"</span>
				</p>
				<footer>
					<a href="#contact" class="button style2 down">More</a>
				</footer>
			</div>
		</section>

	<!-- Contact -->
		<section id="contact" class="main style3 secondary">
			<div class="content container">
				<header>
					<h2>Say Hello.</h2>
					<p>Lorem ipsum dolor sit amet et sapien sed elementum egestas dolore condimentum.</p>
				</header>
				<div class="box container 75%">
				<!-- Contact Form -->
					<form method="post" action="#">
						<div class="row 50%">
							<div ><input type="text" name="name" placeholder="Name" /></div>
							<div class="6u"><input type="email" name="email" placeholder="Email" /></div>
						</div>
						<div class="row 50%">
							<div class="12u"><textarea name="message" placeholder="Message" rows="6"></textarea></div>
						</div>
						<div class="row">
							<div class="12u">
								<ul class="actions">
									<li><input type="submit" value="Send Message" /></li>
								</ul>
							</div>
						</div>
					</form>
				</div>
			</div>
		</section>

	<!-- Footer -->
		<footer id="footer">

			<!-- Icons -->
				<ul class="actions">
					<li><a href="#" class="icon fa-twitter"><span class="label">Twitter</span></a></li>
					<li><a href="#" class="icon fa-facebook"><span class="label">Facebook</span></a></li>
					<li><a href="#" class="icon fa-google-plus"><span class="label">Google+</span></a></li>
					<li><a href="#" class="icon fa-dribbble"><span class="label">Dribbble</span></a></li>
					<li><a href="#" class="icon fa-pinterest"><span class="label">Pinterest</span></a></li>
					<li><a href="#" class="icon fa-instagram"><span class="label">Instagram</span></a></li>
				</ul>

			<!-- Menu -->
				<ul class="menu">
					<li>&copy; Untitled</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
				</ul>

		</footer>
	</body>
</html>

