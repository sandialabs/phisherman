
<%
def resolveUserId = { str, user ->
    str.replaceAll('\\$[Uu][Ss][Ee][Rr][Ii][Dd]', user)
}
def removeTime = { str ->
    if(str != null && !str.equals("")) {
        return str.substring(0, str.indexOf(' '));
    }
    return str;
}
def cleanLinks = { body, debug ->

    // If there is a value for body...
    if(body != null) {
        
        // Keep track of the most recent close caret.
        int lastClosePos = -1;
        
        // Loop over body characters from the end of the string
        // to the beginning.
	    for(int i = body.length() - 1; i >= 0; i--) {
	        char ch = body.charAt(i);
            
            // Keep track of most recent close caret.
            if(ch == '>') {
                lastClosePos = i;
                
            // If we have an open caret and there is valid close caret.
            } else if(ch == '<' && lastClosePos != -1) {

                // Grab tag content
                String tag = body.substring(i, lastClosePos + 1).toLowerCase();
                
                // If this is an anchor tag...
                if(tag.startsWith('<a ') || 
                   tag.startsWith('<a\t') || 
                   tag.startsWith('<a\n') || 
                   tag.startsWith('<a\r') || 
                   tag.startsWith('<a\f')) {

                    // Find out if there's a link attribute on this anchor tag...
	                int hrefPos = tag.indexOf(' href=');
                    if(hrefPos == -1) hrefPos = tag.indexOf('\thref=');
                    if(hrefPos == -1) hrefPos = tag.indexOf('\nhref=');
                    if(hrefPos == -1) hrefPos = tag.indexOf('\rhref=');
                    if(hrefPos == -1) hrefPos = tag.indexOf('\fhref=');
                    
                    if(hrefPos != -1) {
                        
                        // Determine the location where there should be a quote character.
	                    int quotePos = hrefPos + ' href='.length();
                        
                        // Grab the quote character 
                        String quoteChar = '' + tag.charAt(quotePos);
                        
                        String href = null;
                        
                        // If its an expected quote character...
                        if(quoteChar == '\'' || quoteChar == '"') {
                            
                            // Find the matching quote character.
                            int quotePos2 = tag.indexOf(quoteChar, quotePos + 1);
	                        if(quotePos2 != -1) {
                                
                                // Grab the content between the quotes.
	                            href = tag.substring(quotePos + 1, quotePos2);
	                        }
                        } else {
                            int spacePos = tag.indexOf(' ', quotePos + 1);
		                    if(spacePos == -1) spacePos = tag.indexOf('\t', quotePos + 1);
		                    if(spacePos == -1) spacePos = tag.indexOf('\n', quotePos + 1);
		                    if(spacePos == -1) spacePos = tag.indexOf('\r', quotePos + 1);
		                    if(spacePos == -1) spacePos = tag.indexOf('\f', quotePos + 1);
                            
                            if(spacePos == -1 || spacePos > lastClosePos) {
                                spacePos = lastClosePos;
                            }
                            
                            href = tag.substring(quotePos, spacePos);
                        }
                        
                        // If there's an href, modify the body.
                        if(href != null) {
                            if(debug) {
	                            println '<br>*FOUND=[' + href + '] tag=[' + tag.replaceAll('<', '&lt;') + ']'
                                println '<br>*body before=[' + body.replaceAll('<', '&lt;') + ']'
                                println '<br>*' + body.length() + '|' + lastClosePos
                                println '<br>*pre=[' + body.substring(0, i).replaceAll('<', '&lt;') + ']'
                                println '<br>*post=[' + body.substring(lastClosePos + 1).replaceAll('<', '&lt;') + ']'
                            }
                            body = 
                                body.substring(0, i) +
                                '<a href="javascript:link(\'' + href + '\');">' + 
                                body.substring(lastClosePos + 1);
                            if(debug) {
                                println '<br>*body after=[' + body.replaceAll('<', '&lt;') + ']'
                            }
                        }
                    }
                }
            }
	    }
    }
    
    return body;
}
%>

<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <style type="text/css">
        th:hover, tr:hover {
            background: initial;
        }
        </style>
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'phishid.css')}" type="text/css">
        <script type="text/javascript">

            function link(href) {
                alert('You would have visited ' + href + ' !');
            }
        
            // Next buttons
            function submitForm() {
		        if(endsWith(document.getElementById("btnNext").className, "enabled")) {
	                document.frmResponse.submit();
	            }
	        }
            function endsWith(str, suffix) {
                return str.indexOf(suffix, str.length - suffix.length) !== -1;
            }

	        // Needed because FF will sometimes automatically
	        // set the value of previous INPUT controls on a back
	        // button, or the like, so we need to make sure the 
	        // buttons are in sync with that FF set the controls
	        // to under da hood.
	        function updateFromPhishSelectionBox() {
		        if(document.frmResponse.txtPhishSelection.value == "1") {
			        setPhish();
			    } else if(document.frmResponse.txtPhishSelection.value == "2") {
				    setNotPhish();
			    }
		        reconcileCollapse();
		    }

		    // Response selection
	        function setPhish() {
	            var node = document.getElementById("btnPhish");
	            node.className = 'phish-button phish-button-yes-selected';
	            node = document.getElementById("btnNotPhish");
	            node.className = 'phish-button phish-button-no-unselected';
	            node = document.getElementById("txtPhishSelection");
	            node.value = "1"
                updateNextButton();
	        }
	        function setNotPhish() {
	            var node = document.getElementById("btnNotPhish");
	            node.className = 'phish-button phish-button-no-selected';
	            node = document.getElementById("btnPhish");
	            node.className = 'phish-button phish-button-yes-unselected';
	            node = document.getElementById("txtPhishSelection");
	            node.value = "2"
		        updateNextButton();
	        }
	        function setConfidence() {
		        setConfidenceEnabled(getConfidenceSelected());
		    }
	        function setConfidenceEnabled(which) {
		        document.frmResponse.confidence[which].checked = true;
                for(var i = 0; i < 5; i++) {
                    var node = document.getElementById("divRadio" + i);
                    if(i == which) {
                        node.className = "confidence-radio confidence-radio-" + which + "-selected";
                    } else {
                        node.className = "confidence-radio confidence-radio-" + i;
                    }
                }
		        updateNextButton();
		    }

		    // Update
		    function updateNextButton() {
			    if(isConfidenceSelected() && 
					    document.frmResponse.txtPhishSelection.value != "0") {
	                var node = document.getElementById("btnNext");
	                node.className = 'next-email-button next-email-button-enabled';
				}
			}
			function getConfidenceSelected() {
				var selected = -1;
                for(var i = 0; i < document.frmResponse.confidence.length; i++) {
                    if(document.frmResponse.confidence[i].checked) {
                        selected = i;
                    }
                }
                return selected;
		    }            
            function isConfidenceSelected() {
                return getConfidenceSelected() != -1;
            }

            function toggleEmailInstructions() {
                var lnk = document.getElementById("lnkCollapseExpand");
                var divIcon = document.getElementById("divCollapseExpand");
                var divInstrHeader = document.getElementById("divEmailInstrHeader");
                var divInstrBody = document.getElementById("divEmailInstrBody");
                if(endsWith(divIcon.className, "collapse-icon")) {
                    lnk.title = "Expand";
                	divIcon.className = 'corner-icon collapse-expand-icon expand-icon';
                	divInstrHeader.className = "instructions-header email-instructions-header-collapsed";
                	divInstrBody.className = "instructions-body email-instructions-body-hidden";
                	document.frmResponse.chkCollapsed.value = "1";
                } else {
                    lnk.title = "Collapse";
                	divIcon.className = 'corner-icon collapse-expand-icon collapse-icon';
                    divInstrHeader.className = "instructions-header email-instructions-header";
                	divInstrBody.className = "instructions-body";
                    document.frmResponse.chkCollapsed.value = "0";
                }
            }
        </script>
        <g:if test="${ collapsed == "1" }">
            <script type="text/javascript">
            function reconcileCollapse() {
                toggleEmailInstructions();
            }
            </script>
        </g:if>
        <g:else>
            <script type="text/javascript">
            function reconcileCollapse() {
            }
            </script>
        </g:else>
    </head>
    <body onload="updateFromPhishSelectionBox();">
        <div class="instructions-container email-instructions-container">
            <div id='divEmailInstrHeader' class="instructions-header email-instructions-header">
                <div class='corner-icon empty-corner-icon'>&nbsp;</div>
                <div style='padding-top: 10px;display:inline-block;'>Instructions</div>
                <a id='lnkCollapseExpand' href='javascript:toggleEmailInstructions();' title='Collapse'><div id='divCollapseExpand' class='corner-icon collapse-expand-icon collapse-icon'>&nbsp;</div></a>
            </div>
            <div id='divEmailInstrBody' class="instructions-body">
	            <ol>
	                <li><div class='email-instructions-emphasis'>Decide</div>: Does this email look like a phish?
	                    <ul>
	                        <li>Yes: <div class='email-instructions-emphasis'>Click</div> on the "Phish" button</li>
	                        <li>No: <div class='email-instructions-emphasis'>Click</div> on the "Not Phish" button</li>
	                    </ul>
	                </li>
	                <li><div class='email-instructions-emphasis'>Click</div> on the bubble on the scale that shows how confident you are in your answer.
	                    <ul>
	                        <li>After you click on the scale, the "Next" button will be enabled.</li>
	                    </ul>
	                </li>
	                <li><div class='email-instructions-emphasis'>Click</div> the "Next" button to submit your answer and move to the next email.</li>
	            </ol>
	            <p style='margin-left:18px;margin-top:15px'>You may exit and return to this task at any time.  All of your submitted answers have been saved.</p>
            </div>
        </div>
        <div class="email-box">
	        <div class="email-buttons">
		        <a href="javascript:void(0);"><div class="email-button email-button-reply">&nbsp;</div></a>
		        <a href="javascript:void(0);"><div class="email-button email-button-reply-all">&nbsp;</div></a>
		        <a href="javascript:void(0);"><div class="email-button email-button-forward">&nbsp;</div></a>
	        </div>
	        <div class="email-header">
	           <div><div class="email-header-field-name">From:</div><div class="email-header-field-value"><%= resolveUserId(email.fromAddress, "${user}") %></div></div>
               <div><div class="email-header-field-name">To:</div><div class="email-header-field-value"><%= resolveUserId(email.toAddress, "${user}") %></div></div>
               <div><div class="email-header-field-name">CC:</div><div class="email-header-field-value"><%= resolveUserId(email.cc, "${user}") %></div></div>
	           <div><div class="email-header-field-name">Date:</div><div class="email-header-field-value"><%= removeTime(email.sent.toString()) %></div></div>
	           <div><div class="email-header-field-name">Subject:</div><div class="email-header-field-value"><%= resolveUserId(email.subject, "${user}") %></div></div>
	        </div>
            <div class="email-content">
                <%= cleanLinks(resolveUserId(email.body, "${user}"), false) %>
<%
//def x = """\
//some html to test here
//""";
//println cleanLinks(x, true);
%>               
            </div>
        </div>
        <g:form name="frmResponse" action="index" controller="phishId" method="post">
        <g:hiddenField name="index" value="${index}"/>
        <g:hiddenField name="txtPhishSelection" value="0"/>
        <g:hiddenField name="chkCollapsed" value="0"/>
        <div class="response-box">
            <div class="container">
                <a href="javascript:setPhish();"><div class="phish-button phish-button-yes-unselected" id="btnPhish"><div class='phish-button-text'>Phish</div></div></a>
            </div>
            <div class="container">
                <a href="javascript:setNotPhish();"><div class="phish-button phish-button-no-unselected" id="btnNotPhish"><div class='phish-button-text'>Not Phish</div></div></a>
            </div>
            <div class="confidence-box">
                <div>
                    <div class='confidence-title-text'>Confidence</div>
                    <g:set var="radioCounter" value="${0}" />
                    <g:radioGroup onclick="setConfidence();" values="[1,2,3,4,5]" name="confidence" labels="['low','&lt;~&gt;','medium','&lt;~&gt;','high']">
                        <a href="javascript:setConfidenceEnabled(${radioCounter});">
                        <div class="confidence-radio confidence-radio-${radioCounter}" id="divRadio${radioCounter}">
                            <div class='confidence-text confidence-text-${radioCounter}'>
                                <g:message code="${it.label}" />
                            </div>
                            <div>${it.radio}</div>
                        </div></a>
                        <g:set var="radioCounter" value="${radioCounter + 1}" /> 
                    </g:radioGroup>
                </div>
            </div>
            <div class="container">
                <a href="javascript:submitForm();"><div class="next-email-button next-email-button-disabled" id="btnNext"><div class='phish-button-text'>Next</div></div></a>
            </div>
        </div>
        </g:form>
    </body>
</html>