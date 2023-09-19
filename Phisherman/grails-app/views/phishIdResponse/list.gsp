
<%@ page import="phisherman.PhishIdResponse" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'response.label', default: 'Response')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-response" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
				<li><g:link action="download">Download</g:link></li>
			</ul>
		</div>
		<div id="list-response" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="confidence" title="${message(code: 'response.confidence.label', default: 'Confidence')}" />
					
						<th><g:message code="response.email.label" default="Email" /></th>
					
						<g:sortableColumn property="isPhish" title="${message(code: 'response.isPhish.label', default: 'Is Phish')}" />
					
						<g:sortableColumn property="userId" title="${message(code: 'response.userId.label', default: 'User Id')}" />
                    
                        <g:sortableColumn property="start" title="${message(code: 'response.start.label', default: 'Start')}" />
                    
                        <g:sortableColumn property="end" title="${message(code: 'response.end.label', default: 'End')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${responseInstanceList}" status="i" var="responseInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${responseInstance.id}">${fieldValue(bean: responseInstance, field: "confidence")}</g:link></td>
					
						<td>${fieldValue(bean: responseInstance, field: "email")}</td>
					
						<td><g:formatBoolean boolean="${responseInstance.isPhish}" /></td>
					
						<td>${fieldValue(bean: responseInstance, field: "userId")}</td>
                    
                        <td>${new Date(responseInstance.start)}</td>
                    
                        <td>${new Date(responseInstance.end)}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${responseInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
