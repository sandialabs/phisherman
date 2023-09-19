
<%@ page import="phisherman.SurveyResponse" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'surveyResponse.label', default: 'SurveyResponse')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-surveyResponse" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                <li><g:link action="download">Download</g:link></li>
			</ul>
		</div>
		<div id="list-surveyResponse" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="question1" title="${message(code: 'surveyResponse.question1.label', default: 'Question1')}" />
					
						<g:sortableColumn property="question10" title="${message(code: 'surveyResponse.question10.label', default: 'Question10')}" />
					
						<g:sortableColumn property="question100" title="${message(code: 'surveyResponse.question100.label', default: 'Question100')}" />
					
						<g:sortableColumn property="question101" title="${message(code: 'surveyResponse.question101.label', default: 'Question101')}" />
					
						<g:sortableColumn property="question102" title="${message(code: 'surveyResponse.question102.label', default: 'Question102')}" />
					
						<g:sortableColumn property="question103" title="${message(code: 'surveyResponse.question103.label', default: 'Question103')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${surveyResponseInstanceList}" status="i" var="surveyResponseInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${surveyResponseInstance.id}">${fieldValue(bean: surveyResponseInstance, field: "question1")}</g:link></td>
					
						<td>${fieldValue(bean: surveyResponseInstance, field: "question10")}</td>
					
						<td>${fieldValue(bean: surveyResponseInstance, field: "question100")}</td>
					
						<td>${fieldValue(bean: surveyResponseInstance, field: "question101")}</td>
					
						<td>${fieldValue(bean: surveyResponseInstance, field: "question102")}</td>
					
						<td>${fieldValue(bean: surveyResponseInstance, field: "question103")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${surveyResponseInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
