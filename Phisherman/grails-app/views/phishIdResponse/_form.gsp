<%@ page import="phisherman.PhishIdResponse" %>



<div class="fieldcontain ${hasErrors(bean: responseInstance, field: 'confidence', 'error')} required">
	<label for="confidence">
		<g:message code="response.confidence.label" default="Confidence" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="confidence" type="number" value="${responseInstance.confidence}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: responseInstance, field: 'email', 'error')} required">
	<label for="email">
		<g:message code="response.email.label" default="Email" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="email" name="email.id" from="${phisherman.Email.list()}" optionKey="id" required="" value="${responseInstance?.email?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: responseInstance, field: 'isPhish', 'error')} ">
	<label for="isPhish">
		<g:message code="response.isPhish.label" default="Is Phish" />
		
	</label>
	<g:checkBox name="isPhish" value="${responseInstance?.isPhish}" />
</div>

<div class="fieldcontain ${hasErrors(bean: responseInstance, field: 'userId', 'error')} ">
	<label for="userId">
		<g:message code="response.userId.label" default="User Id" />
		
	</label>
	<g:textField name="userId" value="${responseInstance?.userId}"/>
</div>

