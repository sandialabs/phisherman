
<%@ page import="phisherman.PhishIdResponse" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'response.label', default: 'Response')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-response" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-response" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list response">
			
				<g:if test="${responseInstance?.confidence}">
				<li class="fieldcontain">
					<span id="confidence-label" class="property-label"><g:message code="response.confidence.label" default="Confidence" /></span>
					
						<span class="property-value" aria-labelledby="confidence-label"><g:fieldValue bean="${responseInstance}" field="confidence"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${responseInstance?.email}">
				<li class="fieldcontain">
					<span id="email-label" class="property-label"><g:message code="response.email.label" default="Email" /></span>
					
						<span class="property-value" aria-labelledby="email-label"><g:link controller="email" action="show" id="${responseInstance?.email?.id}">${responseInstance?.email?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${responseInstance?.isPhish}">
				<li class="fieldcontain">
					<span id="isPhish-label" class="property-label"><g:message code="response.isPhish.label" default="Is Phish" /></span>
					
						<span class="property-value" aria-labelledby="isPhish-label"><g:formatBoolean boolean="${responseInstance?.isPhish}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${responseInstance?.userId}">
				<li class="fieldcontain">
					<span id="userId-label" class="property-label"><g:message code="response.userId.label" default="User Id" /></span>
					
						<span class="property-value" aria-labelledby="userId-label"><g:fieldValue bean="${responseInstance}" field="userId"/></span>
					
				</li>
				</g:if>
            
                <g:if test="${responseInstance?.start}">
                <li class="fieldcontain">
                    <span id="start-label" class="property-label"><g:message code="response.start.label" default="Start" /></span>
                    
                        <span class="property-value" aria-labelledby="start-label">${new Date(responseInstance.start)}</span>
                    
                </li>
                </g:if>
            
                <g:if test="${responseInstance?.end}">
                <li class="fieldcontain">
                    <span id="end-label" class="property-label"><g:message code="response.end.label" default="End" /></span>
                    
                        <span class="property-value" aria-labelledby="end-label">${new Date(responseInstance.end)}</span>
                    
                </li>
                </g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${responseInstance?.id}" />
					<g:link class="edit" action="edit" id="${responseInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
