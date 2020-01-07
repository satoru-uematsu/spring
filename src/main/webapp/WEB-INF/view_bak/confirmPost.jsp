<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="resources\css\style.css">
<script>
    function getSelect(text) {
    	document.getElementById('selectedCategory').value = text;
    }
</script>
<title>掲示板システム</title>
</head>
<body id="home">
	<div id="wrapper">
		<div id="header">
			<h2 id="loginInfo"><label>ログインユーザー：</label><c:out value="${ sessionScope.loginUser.name }"/></h2>
			<div id="menu">
				<div id="post">
					<a href="${pageContext.request.contextPath}/home">ホーム</a>
				</div>
			</div>
			<div class="error">
				<c:if test="${ not empty errorMessages }">
					<c:forEach items="${ errorMessages }" var="message">
						<c:out value="${ message }"/>
					</c:forEach>
					<c:remove var="errorMessages" scope="session"/>
				</c:if>
			</div>
		</div>
		<span id="postTitle" class="title-t2">投稿確認</span>
		<div id="form" class="kokuban-t2">
				<form:form modelAttribute="post" action="${pageContext.request.contextPath}/${action_post}">
				<div>
					<label>件名:</label>
					<input type="text" id="title" size="40" maxlength="50" readOnly="true" value="${post.title}" />
					<c:forEach items="${ violationMessages['_title'] }" var="message">
						<div class="error"><c:out value="${ message }"/></div>
					</c:forEach>
				</div>
				<div>
					<label>投稿内容:</label>
					<textarea id="text" cols="50" rows="10" readOnly="true" >${post.text}</textarea>
					<c:forEach items="${ violationMessages['_text'] }" var="message">
						<div class="error"><c:out value="${ message }"/></div>
					</c:forEach>
				</div>
				<div>
					<label>カテゴリー:</label>
					<input id="selectedCategory" size="12" maxlength="10" readOnly="true" value="${post.category}" />
					<c:forEach items="${ violationMessages['_category'] }" var="message">
						<div class="error"><c:out value="${ message }"/></div>
					</c:forEach>
				</div>
				<div><input id="button" type="submit" value="登録"></div>
				<form:hidden path="id"/>
				<form:hidden path="text" value="${post.text}"/>
				<form:hidden path="title" value="${post.title}"/>
				<form:hidden path="category" value="${post.category}"/>
			</form:form>
		</div>
	</div>
</body>
</html>