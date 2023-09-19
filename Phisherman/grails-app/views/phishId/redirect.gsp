<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<meta name="layout" content="main"/>
<link rel="stylesheet" href="${resource(dir: 'css', file: 'redirect.css')}" type="text/css">
<script type="text/javascript">
	// Next buttons
	function submitForm() {
	    document.frmResponse.submit();
	}
</script>
<title>Insert title here</title>
</head>
<body>
  <div class="body">
    <g:form name="frmResponse" action="index" controller="phishId" method="post">
    <g:hiddenField name="index" value="${index}"/>
    <g:hiddenField name="isRedirect" value="true"/>
        <div class="redirect-message">You have already entered a response to this e-mail. Please <b>DO NOT</b> use the "Back" button on your browser when completing this survey. Please click continue to proceed with the experiment.</div>
        <div class="begin-survey-btn-container"><a href="javascript:submitForm();"><div class="begin-survey-btn"><div class="begin-survey-btn-text">Continue</div><div class="begin-survey-btn-arrow"></div></div></a></div>
    </g:form>
  </div>
</body>
</html>
