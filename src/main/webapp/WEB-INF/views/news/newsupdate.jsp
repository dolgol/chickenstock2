<%@page import="ssg.com.a.dto.UserDto"%>
<%@page import="ssg.com.a.dto.NewsDto"%>
<%@page import="ssg.com.a.dto.BbsDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	NewsDto dto = (NewsDto)request.getAttribute("newsDto");
	System.out.println(dto);
	UserDto login = (UserDto)session.getAttribute("login");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정</title>
</head>
<body>
<div align="center">
    <h2>글 수정</h2>
    <form action="newsupdateAf.do" method="post">
        <input type="hidden" name="seq" value="<%=dto.getSeq() %>">
        <table border="1">
            <col width="200"><col width="500">
            <tr>
            	<th>아이디</th>
            	<td><%=login.getUser_id() %></td><!-- 원본 기사 작성자로 수정해야함 -->
            </tr>
            <tr>
                <th>제목</th>
                <td>
                    <input type="text" name="title" size="50" value="<%=dto.getTitle() %>">
                </td>
            </tr>
            <tr>
                <th>내용</th>
                <td>
                    <textarea rows="10" cols="50" name="content"><%=dto.getContent() %></textarea>
                </td>
            </tr>
            <tr>
                <th>출처</th>
                <td>
                    <input type="text" name="source" size="50" value="<%=dto.getSource() %>">
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="수정완료">
                </td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
