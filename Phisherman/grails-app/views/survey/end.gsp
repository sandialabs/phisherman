<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <link rel="stylesheet" href="${resource(dir: 'css', file: 'phishid.css')}" type="text/css">
    </head>
    <body>
        <div class="instructions-container">
            <div class="instructions-header">
                Questionnaire Complete
            </div>
            <div class="instructions-body">
                You have completed the Questionnaire portion of the Phish Identification Survey.
                Please click to now complete the Phish ID Task portion of the survey.  Thank you.
            </div>
        </div>
        <div class="begin-survey-btn-container">
            <g:link controller="phishId" action="index"><div class="begin-survey-btn"><div class="begin-survey-btn-text">Phish Identification</div><div class="begin-survey-btn-arrow"></div></div></g:link>
        </div>
    </body>
</html>