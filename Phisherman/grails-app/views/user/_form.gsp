<%@ page import="phisherman.User" %>



<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'consented', 'error')} ">
	<label for="consented">
		<g:message code="user.consented.label" default="Consented" />
		
	</label>
	<g:checkBox name="consented" value="${userInstance?.consented}" />
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'currentPhishIndex', 'error')} required">
	<label for="currentPhishIndex">
		<g:message code="user.currentPhishIndex.label" default="Current Phish Index" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="currentPhishIndex" type="number" value="${userInstance.currentPhishIndex}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'emailOrder', 'error')} ">
	<label for="emailOrder">
		<g:message code="user.emailOrder.label" default="Email Order" />
		
	</label>
	<g:textField name="emailOrder" value="${userInstance?.emailOrder}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'state', 'error')} required">
	<label for="state">
		<g:message code="user.state.label" default="State" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="state" from="${phisherman.User$UserState?.values()}" keys="${phisherman.User$UserState.values()*.name()}" required="" value="${userInstance?.state?.name()}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'userGroup', 'error')} required">
	<label for="userGroup">
		<g:message code="user.userGroup.label" default="User Group" />
		<span class="required-indicator">*</span>
	</label>
	<g:select name="userGroup" from="${phisherman.User$UserGroup?.values()}" keys="${phisherman.User$UserGroup.values()*.name()}" required="" value="${userInstance?.userGroup?.name()}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: userInstance, field: 'userName', 'error')} ">
	<label for="userName">
		<g:message code="user.userName.label" default="User Name" />
		
	</label>
	<g:textField name="userName" value="${userInstance?.userName}"/>
</div>

