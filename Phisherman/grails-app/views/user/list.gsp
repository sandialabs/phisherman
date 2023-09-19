
<%@ page import="phisherman.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                <li><g:link action="download">Download User Mapping (Warning!)</g:link></li>
                <li><g:link action="downloadUserStatus">Download User Status</g:link></li>
			</ul>
		</div>
		<div id="list-user" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="consented" title="${message(code: 'user.consented.label', default: 'Consented')}" />
					
						<g:sortableColumn property="currentPhishIndex" title="${message(code: 'user.currentPhishIndex.label', default: 'Current Phish Index')}" />
					
						<g:sortableColumn property="emailOrder" title="${message(code: 'user.emailOrder.label', default: 'Email Order')}" />
					
						<g:sortableColumn property="state" title="${message(code: 'user.state.label', default: 'State')}" />
					
						<g:sortableColumn property="userGroup" title="${message(code: 'user.userGroup.label', default: 'User Group')}" />
					
						<g:sortableColumn property="userName" title="${message(code: 'user.userName.label', default: 'User Name')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${userInstanceList}" status="i" var="userInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${userInstance.id}">${fieldValue(bean: userInstance, field: "consented")}</g:link></td>
					
						<td>${fieldValue(bean: userInstance, field: "currentPhishIndex")}</td>
					
						<td>${fieldValue(bean: userInstance, field: "emailOrder")}</td>
					
						<td>${fieldValue(bean: userInstance, field: "state")}</td>
					
						<td>${fieldValue(bean: userInstance, field: "userGroup")}</td>
					
						<td>${fieldValue(bean: userInstance, field: "userName")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${userInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
