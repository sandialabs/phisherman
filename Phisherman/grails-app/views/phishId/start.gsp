<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'phishid.css')}" type="text/css">
        <script type="text/javascript">
            function submitForm() {
	            document.frmBegin.submit();
            }
        </script>
    </head>
    <body>
        <div class="instructions-container">
	        <div class="instructions-header">
	            Phish ID Task Instructions
	        </div>
	        <div class="instructions-body">
                In this task, you will be shown a series of emails and asked whether or 
                not you think each email is a phish, and how confident you are in that 
                answer. The emails will appear to contain links and attachments. If you 
                click on a link or attachment, you will not navigate away from this webpage. 
                A pop-up window will appear and tell you what would have happened in a 
                real email. Example message: “You would have visited http://www.youtube.com!”. 
                This feature was added for your protection.
                <br><br>
                You will be shown 100 emails.  They are fabricated, and have been made
                to look like real emails that one might receive at work. Please read
                through them at the same rate at which you normally read emails at work. 
                <br>
                <br>
                We estimate that this portion of the Survey will take approximately 30-40 
                minutes. If you need to log out or close the browser window while doing 
                the Phish ID Task, you may do so. You can log back in by using the link 
                in our email to you. Your submitted answers will be saved, so if you log 
                back in, you’ll be taken to where you left off in the Phish ID Task.
                <br> 
                <br>
                Thank you for your participation!
	        </div>
        </div>
        <div class="begin-survey-btn-container"><a href="javascript:submitForm();"><div class="begin-survey-btn"><div class="begin-survey-btn-text">Begin</div><div class="begin-survey-btn-arrow"></div></div></a></div>
        <g:form name="frmBegin" action="index" controller="phishId">
            <g:hiddenField name="index" value="-1" />
        </g:form>
    </body>
</html>
