
<%@ page import="phisherman.Email" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'email.label', default: 'Email')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-email" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-email" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list email">
			
				<g:if test="${emailInstance?.fromAddress}">
				<li class="fieldcontain">
					<span id="fromAddress-label" class="property-label"><g:message code="email.fromAddress.label" default="From:" /></span>
				    <span class="property-value" aria-labelledby="fromAddress-label"><g:fieldValue bean="${emailInstance}" field="fromAddress"/></span>
				</li>
				</g:if>
			         
                <g:if test="${emailInstance?.toAddress}">
                <li class="fieldcontain">
                    <span id="toAddress-label" class="property-label"><g:message code="email.toAddress.label" default="To:" /></span>
                    <span class="property-value" aria-labelledby="toAddress-label"><g:fieldValue bean="${emailInstance}" field="toAddress"/></span>
                </li>
                </g:if>
			         
                <g:if test="${emailInstance?.cc}">
                <li class="fieldcontain">
                    <span id="cc-label" class="property-label"><g:message code="email.cc.label" default="CC:" /></span>
                    <span class="property-value" aria-labelledby="cc-label"><g:fieldValue bean="${emailInstance}" field="cc"/></span>
                </li>
                </g:if>
            
                <g:if test="${emailInstance?.subject}">
                <li class="fieldcontain">
                    <span id="subject-label" class="property-label"><g:message code="email.subject.label" default="Subject:" /></span>
                    <span class="property-value" aria-labelledby="subject-label"><g:fieldValue bean="${emailInstance}" field="subject"/></span>
                </li>
                </g:if>
            
                <g:if test="${emailInstance?.sent}">
                <li class="fieldcontain">
                    <span id="sent-label" class="property-label"><g:message code="email.sent.label" default="Sent:" /></span>
                    <span class="property-value" aria-labelledby="sent-label"><g:formatDate date="${emailInstance?.sent}" /></span>
                </li>
                </g:if>
            
                <g:if test="${emailInstance?.body}">
                <li class="fieldcontain">
                    <span id="body-label" class="property-label"><g:message code="email.body.label" default="Raw Body:" /></span>
                    <span class="property-value" aria-labelledby="body-label"><g:fieldValue bean="${emailInstance}" field="body"/></span>
                </li>
                <li class="fieldcontain">
                    <span id="body-label" class="property-label"><g:message code="email.body.label" default="Body:" /></span>
                    <span class="property-value" aria-labelledby="body-label" style="border: 3px black solid;">${emailInstance.body}</span>
                </li>
                </g:if>
				<g:if test="${emailInstance?.responses}">
				<li class="fieldcontain">
					<span id="responses-label" class="property-label"><g:message code="email.responses.label" default="Responses:" /></span>
					<g:each in="${emailInstance.responses}" var="r">
					<span class="property-value" aria-labelledby="responses-label"><g:link controller="phishIdResponse" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></span>
					</g:each>
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${emailInstance?.id}" />
					<g:link class="edit" action="edit" id="${emailInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
