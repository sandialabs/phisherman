
<%@ page import="phisherman.User" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-user" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list user">
			
				<g:if test="${userInstance?.consented}">
				<li class="fieldcontain">
					<span id="consented-label" class="property-label"><g:message code="user.consented.label" default="Consented" /></span>
					
						<span class="property-value" aria-labelledby="consented-label"><g:formatBoolean boolean="${userInstance?.consented}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.currentPhishIndex}">
				<li class="fieldcontain">
					<span id="currentPhishIndex-label" class="property-label"><g:message code="user.currentPhishIndex.label" default="Current Phish Index" /></span>
					
						<span class="property-value" aria-labelledby="currentPhishIndex-label"><g:fieldValue bean="${userInstance}" field="currentPhishIndex"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.emailOrder}">
				<li class="fieldcontain">
					<span id="emailOrder-label" class="property-label"><g:message code="user.emailOrder.label" default="Email Order" /></span>
					
						<span class="property-value" aria-labelledby="emailOrder-label"><g:fieldValue bean="${userInstance}" field="emailOrder"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.state}">
				<li class="fieldcontain">
					<span id="state-label" class="property-label"><g:message code="user.state.label" default="State" /></span>
					
						<span class="property-value" aria-labelledby="state-label"><g:fieldValue bean="${userInstance}" field="state"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.userGroup}">
				<li class="fieldcontain">
					<span id="userGroup-label" class="property-label"><g:message code="user.userGroup.label" default="User Group" /></span>
					
						<span class="property-value" aria-labelledby="userGroup-label"><g:fieldValue bean="${userInstance}" field="userGroup"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${userInstance?.userName}">
				<li class="fieldcontain">
					<span id="userName-label" class="property-label"><g:message code="user.userName.label" default="User Name" /></span>
					
						<span class="property-value" aria-labelledby="userName-label"><g:fieldValue bean="${userInstance}" field="userName"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${userInstance?.id}" />
					<g:link class="edit" action="edit" id="${userInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
