<%@ page import="phisherman.Email" %>

<div class="fieldcontain">
    <label style='float: left'><i>Note:</i></label>
    <div class='email-special-note'>In <b>From</b>, <b>To</b>, 
    <b>CC</b>, <b>Subject</b>, and <b>Body</b> fields, you can
    use the string <div class='email-special-token'>$USERID</div>
    to indicate that the user's own user ID (e.g. qsmith)
    should be shown instead of <div class='email-special-token'>$USERID</div>.</div>
</div>
<div style='clear: both'></div>

<div class="fieldcontain ${hasErrors(bean: emailInstance, field: 'fromAddress', 'error')} ">
    <label for="fromAddress">
        <g:message code="email.fromAddress.label" default="From:" />
    </label>
    <g:textField class="email-text-box" name="fromAddress" value="${emailInstance?.fromAddress}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: emailInstance, field: 'toAddress', 'error')} ">
    <label for="toAddress">
        <g:message code="email.toAddress.label" default="To:" />
    </label>
    <g:textField class="email-text-box" name="toAddress" value="${emailInstance?.toAddress}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: emailInstance, field: 'cc', 'error')} ">
    <label for="cc">
        <g:message code="email.cc.label" default="CC:" />
    </label>
    <g:textField class="email-text-box" name="cc" value="${emailInstance?.cc}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: emailInstance, field: 'subject', 'error')} ">
    <label for="subject">
        <g:message code="email.subject.label" default="Subject:" />
    </label>
    <g:textField class="email-text-box" name="subject" value="${emailInstance?.subject}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: emailInstance, field: 'sent', 'error')} required">
    <label for="sent">
        <g:message code="email.sent.label" default="Sent:" />
        <span class="required-indicator">*</span>
    </label>
    <g:datePicker name="sent" precision="day"  value="${emailInstance?.sent}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: emailInstance, field: 'body', 'error')} ">
	<label for="body">
		<g:message code="email.body.label" default="Body:" />
	</label>
	<g:textArea class="email-text-box" name="body" value="${emailInstance?.body}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: emailInstance, field: 'responses', 'error')} ">
	<label for="responses">
		<g:message code="email.responses.label" default="Responses:" />
	</label>
	<ul class="one-to-many">
		<g:each in="${emailInstance?.responses?}" var="r">
		    <li><g:link controller="phishIdResponse" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
		</g:each>
		<li class="add">
			<g:link controller="phishIdResponse" action="create" params="['email.id': emailInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'phishIdResponse.label', default: 'PhishIdResponse')])}</g:link>
		</li>
	</ul>
</div>

