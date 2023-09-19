
<%@ page import="phisherman.SurveyResponse" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'surveyResponse.label', default: 'SurveyResponse')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-surveyResponse" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-surveyResponse" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list surveyResponse">
			
			    <g:each var="i" in="${1..125}">
	                <li class="fieldcontain">
	                    <span id="question${i}-label" class="property-label">
	                        <g:message code="surveyResponse.question${i}.label" default="Question${i}" />
	                    </span>
	                    <span class="property-value" aria-labelledby="question${i}-label">
	                        <g:fieldValue bean="${surveyResponseInstance}" field="question${i}"/>
	                    </span>
	                </li>
	                <g:if test="${i == 16 || i == 24 || i == 26}">
	                    <li class="fieldcontain">
	                        <span id="question${i}-other-label" class="property-label">
	                            <g:message code="surveyResponse.question${i}-other.label" default="Question${i}-other" />
	                        </span>
	                        <span class="property-value" aria-labelledby="question${i}-other-label">
	                            <g:fieldValue bean="${surveyResponseInstance}" field="question${i}other"/>
	                        </span>
	                    </li>
	                </g:if>
			    </g:each>
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${surveyResponseInstance?.id}" />
					<g:link class="edit" action="edit" id="${surveyResponseInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
