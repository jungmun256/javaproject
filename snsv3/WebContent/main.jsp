<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="mytag" %>

<!DOCTYPE HTML>
<!--
	Future Imperfect by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>SNS</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="assets/css/main.css" />
		<link rel="icon" href="/images/logofav.ico" type="image/x-icon" />

		<script type="text/javascript">
			function newMember(){
				window.open('new.jsp','새창으로 회원가입','width=500, height=700, menubar=no, status=no,toolbar=no');
			}
			
			function time(){
	        	var time= new Date();
	            document.getElementById("now").innerHTML=time.getHours()+"시"+time.getMinutes()+"분";
	            setInterval("time()",1000);
	            document.getElementById("date").innerHTML=time.getFullYear()+"/"+(time.getMonth()+1)+"/"+time.getDate();
	        }
		</script>
	</head>
	<body class="is-preload" onload="time()">

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Header -->
					<header id="header">
						<h1><a href="index.html">Future Imperfect</a></h1>
						<nav class="links">
							<ul>
								<li><a href="#">Lorem</a></li>
								<li><a href="#">Ipsum</a></li>
								<li><a href="#">Feugiat</a></li>
								<li><a href="#">Tempus</a></li>
								<li><a href="#">Adipiscing</a></li>
							</ul>
						</nav>
						<nav class="main">
							<ul>
								<li class="search">
									<a class="fa-search" href="#search">Search</a>
									<form id="search" method="get" action="#">
										<input type="text" name="query" placeholder="Search" />
									</form>
								</li>
								<li class="menu">
									<a class="fa-bars" href="#menu">Menu</a>
								</li>
							</ul>
						</nav>
					</header>

				<!-- Menu -->
					<section id="menu">

						<!-- Search -->
							<section>
								<form class="search" method="get" action="#">
									<input type="text" name="query" placeholder="Search" />
								</form>
							</section>

						<!-- Links -->
							<section>
								<ul class="links">
									<li>
										<a href="#">
											<h3>Lorem ipsum</h3>
											<p>Feugiat tempus veroeros dolor</p>
										</a>
									</li>
									<li>
										<a href="#">
											<h3>Dolor sit amet</h3>
											<p>Sed vitae justo condimentum</p>
										</a>
									</li>
									<li>
										<a href="#">
											<h3>Feugiat veroeros</h3>
											<p>Phasellus sed ultricies mi congue</p>
										</a>
									</li>
									<li>
										<a href="#">
											<h3>Etiam sed consequat</h3>
											<p>Porta lectus amet ultricies</p>
										</a>
									</li>
								</ul>
							</section>

						<!-- Actions -->
							<section>
								<ul class="actions stacked">
									<li><a href="#" class="button large fit">Log In</a></li>
								</ul>
							</section>

					</section>

				<!-- Main -->
					<div id="main">

						<!-- Post -->
						
							<div>
								<article class="post">
								<header>
									<div class="title">
										<h2><a href="single.html">새 글</a></h2>
										<p></p>
									</div>
									<div class="meta">
										<div class="published"><span id="date"></span></div>
										<div class="published">time: <span id="now"></span></div>
										
									</div>
								</header>
								<div>
									<form action="insertB.do" method="post">
										<input type="hidden" name="mid" value="${mid}">
										<mytag:write type="board"/>
									</form>
								</div>
								<footer>
								</footer>
								</article>
							</div>
						
							<c:forEach var="v" items="${datas}">
								<div>
									<article class="post">
									<header>
										<div class="title">
											<c:set var="bvo" value="${v.board}" />
											<h2><a href="single.html">${bvo.mid}님의 글</a></h2>
											<p></p>
										</div>
										<div class="meta">
											<time class="published" datetime="2015-11-01">November 1, 2015</time>
										</div>
									</header>
									<a href="single.html" class="image featured">
										 ${bvo.msg} 
									</a>
										<hr>
										[좋아요: ${bvo.favcnt} | 댓글: ${bvo.rcnt}]<mytag:removeB rmid="${bvo.mid}" bid="${bvo.bid}"/>
									<footer>
										<!-- 동일 페이지여서 태그 속성으로 값을 줌. reqest.getparameter가 아니다.** -->
										<div>
											<hr>
											<c:forEach var="vv" items="${v.rdatas}">
												${vv.mid}:${vv.rmsg} 
												<mytag:removeR rmid="${vv.mid}" rid="${vv.rid}"/><br>
											</c:forEach>
											
											<form action="insertR.do?cnt=${cnt}" method="post">
												<input type="hidden" name="mid" value="${mid}">
												<input type="hidden" name="bid" value="${bvo.bid}">
												<mytag:write type="reply"/>
											</form>
											
										</div>
									</footer>
									</article>
								</div>
								<br>
							</c:forEach>
							<div align="center">
								<a href="main.do?cnt=${cnt+2}">[게시글 더보기]</a>
							</div>

						<!-- Pagination -->
							<ul class="actions pagination">
								<li><a href="" class="disabled button large previous">Previous Page</a></li>
								<li><a href="#" class="button large next">Next Page</a></li>
							</ul>

					</div>

					<!-- Sidebar -->
					<section id="sidebar">

						<!-- Intro -->
							<section id="intro">
								<a href="main.do" class="logo"><img src="images/img1.jpg" alt="로고이미지"/></a>
								<header>
									<h2>SNS project with MVC pattern</h2>
									<ul>
										<li><a href="javascript:newMember()">회원가입</a></li>
										<li>
											<!-- 커스텀 태그 이용 : if(로그인상태라면)로그아웃 else 로그인 -->
											<mytag:login/>
										</li>
									</ul>
								</header>
							</section>

						

						<!-- Posts List -->
							<section>
								<ul class="posts">
									<li>
										<article>
											<header>
												<h3><a href="single.html">Lorem ipsum fermentum ut nisl vitae</a></h3>
												<time class="published" datetime="2015-10-20">October 20, 2015</time>
											</header>
											<a href="single.html" class="image"><img src="images/img2.jpg" alt="" /></a>
										</article>
									</li>
									<li>
										<article>
											<header>
												<h3><a href="single.html">Convallis maximus nisl mattis nunc id lorem</a></h3>
												<time class="published" datetime="2015-10-15">October 15, 2015</time>
											</header>
											<a href="single.html" class="image"><img src="images/img3.jpg" alt="" /></a>
										</article>
									</li>
									<li>
										<article>
											<header>
												<h3><a href="single.html">Euismod amet placerat vivamus porttitor</a></h3>
												<time class="published" datetime="2015-10-10">October 10, 2015</time>
											</header>
											<a href="single.html" class="image"><img src="images/img4.jpg" alt="" /></a>
										</article>
									</li>
									
								</ul>
							</section>

						<!-- About -->
							<section class="blurb">
								<h2>About</h2>
								<p>Mauris neque quam, fermentum ut nisl vitae, convallis maximus nisl. Sed mattis nunc id lorem euismod amet placerat. Vivamus porttitor magna enim, ac accumsan tortor cursus at phasellus sed ultricies.</p>
								<ul class="actions">
									<li><a href="#" class="button">Learn More</a></li>
								</ul>
							</section>

						<!-- Footer -->
							<section id="footer">
								<ul class="icons">
									<li><a href="#" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li>
									<li><a href="#" class="icon brands fa-facebook-f"><span class="label">Facebook</span></a></li>
									<li><a href="#" class="icon brands fa-instagram"><span class="label">Instagram</span></a></li>
									<li><a href="#" class="icon solid fa-rss"><span class="label">RSS</span></a></li>
									<li><a href="#" class="icon solid fa-envelope"><span class="label">Email</span></a></li>
								</ul>
								<p class="copyright">&copy; Untitled. Design: <a href="http://html5up.net">HTML5 UP</a>. Images: <a href="http://unsplash.com">Unsplash</a>.</p>
							</section>

					</section>

			</div>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/browser.min.js"></script>
			<script src="assets/js/breakpoints.min.js"></script>
			<script src="assets/js/util.js"></script>
			<script src="assets/js/main.js"></script>

	</body>
</html>