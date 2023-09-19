<!DOCTYPE html>
<%

def isDev = {
    grailsApplication.config.phisherman.isdev
}

// Copy of this method in BaseController.gsp!
def getUserName = {
    def BE_VAR = 'become';
    def CL_VAL = 'clear';
    
    def be = params[BE_VAR];
    def auth = request.getHeader('AUTHUSER');
    
    // If the user is attempting to become
    // another user or unset this user...
    if(be != null) {
        
        // Make sure they are allowed...
        if(auth == 'dtrumbo' || auth == 'jtmccl' || isDev()) {
            
            // If they want to clear, remove the setting.
            if(be == CL_VAL) {
                session.removeAttribute(BE_VAR)
                
            // Else set the value into the session.
            } else {
	            session[BE_VAR] = be
            }
        }
    }

    // If the user has been set in the session, use that user.
    def sbe = session[BE_VAR]
    if(sbe != null) {
        return sbe
    }
    
    // Then use the authenticated user if there is nothing
    // set in the session.
    if(auth != null) {
        return auth
    }
    
    // Else choose a default user name.
    return "test_user"
}

%>

<html lang="en" class="no-js">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>Phish Identification</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
		<g:layoutHead/>
		<r:layoutResources />
	</head>
	<body onload="${pageProperty(name:'body.onload')}">
		<div id="grailsLogo" role="banner">
		  <div class="fish-logo"><img src="${resource(dir: 'images', file: 'logo.png')}" alt="Fish Logo"/></div>
		  <div class=title-text>
		  <div class="title-text-big">Phish Identification</div>
		  <div class="title-text-small">@ Sandia National Laboratories</div>
		  </div>
		  <div class="header-info">Welcome <div class='user-name'><%= getUserName() %></div>!</div>
		  <div class="header-line"></div>
	    </div>
		<g:layoutBody/>
        <div class="footer-line"></div>
		<div class="footer" role="contentinfo">
		  <div class="footer-container">
		      <div class="branding-info-image"></div>
		      <div class="branding-info">Powered by 1463 Software Engineering</div>
		      <div class="thunderbird-image"></div>
	      </div>
        </div>
		<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
		<g:javascript library="application"/>
		<r:layoutResources />
	</body>
</html>
