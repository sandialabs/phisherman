<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<meta name="layout" content="main"/>
<link rel="stylesheet" href="${resource(dir: 'css', file: 'survey.css')}" type="text/css">
<script type="text/javascript">
   // Next buttons
   function submitForm() {
	   for(var i = 122; i <= 125; i++) {
		   var check = checkDate("question" + i);
		   if(check != null) {
			   alert('One or more of your TEDS course dates is invalid.  ' + check);
			   return;
		   }
	   }
       document.frmSurvey.submit();
   }
   function checkDate(id) {
	   var val = document.getElementById(id).value;
	   if(val != null && val != "") {
		   return isValidDate(val);
	   }
	   return null;
   }
   function isValidDate(dateString) {

	   // First check for the pattern
       if(!/^\d{1,2}\/\d{1,2}\/\d{4}$/.test(dateString))
           return "Invalid format - must be in MM/DD/YYYY format.";

       // Parse the date parts to integers
       var parts = dateString.split("/");
       var day = parseInt(parts[1], 10);
       var month = parseInt(parts[0], 10);
       var year = parseInt(parts[2], 10);

       // Check the ranges of month and year
       if(year < 1990 || year > 2014)  return "Invalid year value.";
       if(month < 1 || month > 12)     return "Invalid month value.";
       
       var monthLength = [ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 ];

       // Adjust for leap years
       if(year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
           monthLength[1] = 29;

       // Check the range of the day
       if(day > 0 && day <= monthLength[month - 1]) {
           return null;
       }

       return "Invalid day of month.";
   }
</script>
<title>Insert title here</title>
</head>
<body>
  <div class="body">
    <div class="instructions-container survey-instructions-container">
            <div class="instructions-header">
                Questionnaire Instructions
            </div>
            <div class="instructions-body">
                We would like to understand more about our end-users in order to improve anti-phishing training. 
                Your individual answers will be kept strictly confidential; all data from this study will be safeguarded 
                and represented in aggregate form only.
                <br>
                <br>
                Please answer the following questions as truthfully as possible. Your answers will not be saved until
                you hit the "Submit" button at the bottom of the page, so it's best to complete this part in a single
                sitting.  You may skip questions you are uncomfortable with or choose to withdraw from this study 
                at any time without consequence.  Thank you for your input!
            </div>
        </div>
    <g:form name="frmSurvey" action="index" controller="survey" params="[button: 'submit']">
    <div class="survey-body-container">
	    <div class="survey-body">
	        <div class="survey-question-container survey-question-container-colored">
		        <div class="survey-question">
		            Age
		        </div>
		        <div class="survey-response">
		            <g:radioGroup values="[1,2,3,4,5]" name="question1" labels="['<21','21-25','26-35','36-50','51+']">
		               ${it.radio} ${it.label}<br>
	                </g:radioGroup>
		        </div>
	        </div>
            <div class="survey-question-container">
		        <div class="survey-question">
		            Gender
		        </div>
		        <div class="survey-response">
                    <g:radioGroup values="[1,2,3]" name="question2" labels="['Male','Female','Rather not say']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
		        </div>
	        </div>
            <div class="survey-question-container survey-question-container-colored">
                <div class="survey-question">
                    Highest Degree Earned
                </div>
                <div class="survey-response">
                    <g:radioGroup values="[1,2,3,4]" name="question3" labels="['High School / GED','Bachelor\'s','Master\'s', 'Doctorate']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
                </div>
            </div>
            <div class="survey-question-container">
                <div class="survey-question">
                    Do you have any degrees in computer science, computation, cybersecurity, or a related computer-based field?
                </div>
                <div class="survey-response">
                    <g:radioGroup values="[1,2]" name="question4" labels="['Yes','No']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
                </div>
            </div>
            <div class="survey-question-container survey-question-container-colored">
                <div class="survey-question">
                    Number of years at Sandia
                </div>
                <div class="survey-response">
                    <g:select name="question5" from="['0-4','5-10','11-15','16-20','21+']"/>
                </div>
            </div>
            <div class="survey-question-container">
                <div class="survey-question">
                    Job Family at Sandia
                </div>
                <div class="survey-response">
	                <g:radioGroup values="[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22]" name="question6" labels="['Audit Management','Administrative Assistant','Business Development','General Business Management','Communications and Marketing','Contracts Management','Engineering and Operations','Environment, Safety, and Health','Executive','Facilities','Finance and Accounting','Health Care','Human Resources','Information Management','Information Technology','Legal and Regulatory','Manufacturing Production Operations','Project Management','Quality','Research and Development','Supply Chain','Security']">
	                   ${it.radio} ${it.label}<br>
	                </g:radioGroup>
	                <div class="other-question-container">
	                    <div class="other-question-radio"><g:radio name="question6" value="23"/> Other:</div>
	                    <div class="other-question-text"><g:textField name="question6-other"/></div>
	                </div>
                </div>
            </div>
            <div class="survey-question-container survey-question-container-colored">
                <div class="survey-question">
                    Position Type
                </div>
                <div class="survey-response">
                    <g:radioGroup values="[1,2,3,4]" name="question7" labels="['Student/Temporary/Part-time','Post-doc or Full-time Contractor','Full-time Employee (non-management)', 'Management']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
                </div>
            </div>
            <div class="survey-question-container">
                <div class="survey-question">
                    Level of security at your office, where “your office” is defined as “where you check your email and do most of your work”
                </div>
                <div class="survey-response">
                    <g:radioGroup values="[1,2,3,4]" name="question8" labels="['Off-site (e.g., work remotely from home)','SNL General Access Area (GAA)', 'PPA','Limited area','VTR/SCIF']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
                </div>
            </div>
            <div class="survey-question-container" style="background: #D6E7FF; height: 50px;">
                <div class="survey-question" style="color: #003177; font-size: 16pt; width: 100%;">
                    Please answer the following questions without guessing:
                </div>
            </div>
            <div class="survey-question-container survey-question-container-colored">
                <div class="survey-question">
                    What is the definition of “phishing”?
                </div>
                <div class="survey-response">
                    <g:radioGroup values="[1,2,3,4,5]" name="question9" labels="['Using electronic messaging systems to send unsolicited bulk messages indiscriminately','Attempting to acquire sensitive information by masquerading as a trustworthy entity in an electronic communication','Using embedded links or attachments in an electronic communication in an effort to get the recipient to open them', 'Internet slang for “fishing”','I don\'t know']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
                </div>
            </div>
            <div class="survey-question-container">
                <div class="survey-question">
                    How confident are you in your abilities to detect phish? (Generic phish; not spearphish.)
                </div>
                <div class="survey-response">
                    <g:radioGroup values="[1,2,3,4,5]" name="question10" labels="['I\'m a pro: I deal with phish regularly as part of my job','Very confident: I am very well-informed on what phish look like','Confident: I know the common tell-tale signs of a phish','Not very confident: I only know a few things about identifying phish','Not at all confident: I don\'t know anything about detecting phish']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
                </div>
            </div>
            <div class="survey-question-container survey-question-container-colored">
                <div class="survey-question">
                    Do you know what an e-mail header is?
                </div>
                <div class="survey-response">
                    <g:radioGroup values="[1,2]" name="question11" labels="['Yes','No']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
                </div>
            </div>
            <div class="survey-question-container">
                <div class="survey-question">
                    If you received a phishing email at work, what would you do with it?
                </div>
                <div class="survey-response">
                    <g:radioGroup values="[1,2,3,4,5,6,7]" name="question12" labels="['Keep it for your records','Forward it to phish@sandia.gov and delete it from my inbox','Open its link/attachment to see what happens','Delete it from my inbox only','Forward it to my manager','Forward it to spam@sandia.gov and delete it from my inbox','I don\'t know']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
                </div>
            </div>
            <div class="survey-question-container survey-question-container-colored">
                <div class="survey-question">
                    What consequences are likely as a direct result of opening a link or attachment in a phishing email on a computer connected to the SRN? Select all that apply.
                </div>
                <div class="survey-response">
                    <g:checkBox name="question13-1"/> Nothing<br>
                    <g:checkBox name="question13-2"/> Installation of malware on the recipient's machine<br>
                    <g:checkBox name="question13-3"/> The recipient's account credentials or personal information could be stolen<br>
                    <g:checkBox name="question13-4"/> The recipient's machine will blow up<br>
                    <g:checkBox name="question13-5"/> Sandia's classified network will be immediately compromised<br>
                    <g:checkBox name="question13-6"/> I don't know<br>
                </div>
            </div>
            <div class="survey-question-container">
                <div class="survey-question">
                    How do you verify that an email is genuine?
                </div>
                <div class="survey-response">
                    <g:textArea name="question14"></g:textArea>
                </div>
            </div>
            <div class="survey-question-container survey-question-container-colored">
                <div class="survey-question">
                    Have you personally ever fallen for a phishing attack?
                </div>
                <div class="survey-response">
                    <g:radioGroup values="[1,2,3,4]" name="question15" labels="['Yes, I clicked on a phish','No, I recognized it and didn’t click on it','No, I\'ve never gotten phished','I don\'t know']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
                </div>
            </div>
            <div class="survey-question-container">
                <div class="survey-question">
                    If you clicked on a real phish, who would you contact?
                </div>
                <div class="survey-response">
                    <g:radioGroup values="[1,2,3,4,5,6,7]" name="question16" labels="['CCHD','SIMP','Corporate Investigations','IR','CSU','Counterintelligence','My manager']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
                    <div class="other-question-container">
                        <div class="other-question-radio"><g:radio name="question16" value="8"/> Other:</div>
                        <div class="other-question-text"><g:textField name="question16-other"/></div>
                    </div>
                </div>
            </div>
            <div class="survey-question-container survey-question-container-colored">
                <div class="survey-question">
                    Does the “EXTERNAL” tag attached to some emails catch your attention when you’re reading a message?
                </div>
                <div class="survey-response">
                    <g:radioGroup values="[1,2]" name="question17" labels="['Yes','No']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
                </div>
            </div>
            <div class="survey-question-container">
                <div class="survey-question">
                   Are you more or less trusting of an email with the “EXTERNAL” tag?
                </div>
                <div class="survey-response">
                    <g:radioGroup values="[1,2,3]" name="question18" labels="['I trust an email with the “EXTERNAL” tag more','I trust an email with the “EXTERNAL” tag less','I trust all emails equally']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
                </div>
            </div>
            <div class="survey-question-container survey-question-container-colored">
                <div class="survey-question">
                    How often do you think Sandians receive real phishing emails? (i.e., not training)
                </div>
                <div class="survey-response">
                    <g:radioGroup values="[1,2,3,4,5]" name="question19" labels="['Never','Rarely','Sometimes','Fairly often','Very often']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
                </div>
            </div>
            <div class="survey-question-container">
                <div class="survey-question">
                    If you clicked on a phish, how serious do you think the consequences are to Sandia as an organization?
                </div>
                <div class="survey-response">
                    <g:radioGroup values="[1,2,3,4,5]" name="question20" labels="['None','Low','Medium','High','Very high']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
                </div>
            </div>
            <div class="survey-question-container survey-question-container-colored">
                <div class="survey-question">
                    If you clicked on a phish, how serious do you expect the consequences to be to you, personally?
                </div>
                <div class="survey-response">
                    <g:radioGroup values="[1,2,3,4,5]" name="question21" labels="['None','Low','Medium','High','Very high']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
                </div>
            </div>
            <div class="survey-question-container">
                <div class="survey-question">
                    How likely do you think it is that you personally will be targeted by an adversary’s phishing attack?
                </div>
                <div class="survey-response">
                    <g:radioGroup values="[1,2,3,4,5]" name="question22" labels="['Not at all likely','Not very likely','Somewhat likely','Fairly likely','Almost certain']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
                </div>
            </div>
            <div class="survey-question-container survey-question-container-colored">
                <div class="survey-question">
                    Are you more deeply concerned about:
                </div>
                <div class="survey-response">
                    <g:radioGroup values="[1,2]" name="question23" labels="['Consequences to me personally, including my work, compensation and job security','Consequences to the lab and national security']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
                </div>
            </div>
            <div class="survey-question-container">
                <div class="survey-question">
                    In general, what do you think is the primary reason for why people fall for phish?
                </div>
                <div class="survey-response">
                    <g:radioGroup values="[1,2,3,4,5]" name="question24" labels="['They don’t know what an email phish looks like','They don’t have time to be careful – too many emails per day','They don’t care about looking for phish','They\'re stupid','Phish are really tricky']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
                    <div class="other-question-container">
                        <div class="other-question-radio"><g:radio name="question24" value="6"/> Other:</div>
                        <div class="other-question-text"><g:textField name="question24-other"/></div>
                    </div>
                </div>
            </div>
            <div class="survey-question-container survey-question-container-colored">
                <div class="survey-question">
                    Do you think people should be punished for falling for a phish?
                </div>
                <div class="survey-response">
                    <g:radioGroup values="[1,2,3,4]" name="question25" labels="['Yes, every time','Yes, if they repeatedly fall for phish','No','I\'m not sure']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
                </div>
            </div>
            <div class="survey-question-container">
                <div class="survey-question">
                    Who do you think holds the most responsibility for preventing phishing attacks at Sandia?
                </div>
                <div class="survey-response">
                    <g:radioGroup values="[1,2,3,4]" name="question26" labels="['Cybersecurity','Management','Me','CCHD']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
                    <div class="other-question-container">
                        <div class="other-question-radio"><g:radio name="question26" value="5"/> Other:</div>
                        <div class="other-question-text"><g:textField name="question26-other"/></div>
                    </div>
                </div>
            </div>
            <div class="survey-question-container survey-question-container-colored">
                <div class="survey-table-question-instructions">
                    Select the answer that most closely matches how much you agree with the following series of statements. Use your first-instinct response.
                </div>
                <div class="survey-table-question">
                    I see Myself as Someone Who:
                </div>
                <div class="survey-table">
                    <div class="survey-table-header">
                        <div class="survey-table-question-cell"></div>
                        <div class="survey-table-cell">Disagree Strongly</div>
                        <div class="survey-table-cell">Disagree a little</div>
                        <div class="survey-table-cell">Neither agree or disagree</div>
                        <div class="survey-table-cell">Agree a little</div>
                        <div class="survey-table-cell">Agree strongly</div>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Is talkative</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question27" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Tends to find fault with others</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question28" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Does a thorough job</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question29" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Is depressed, blue</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question30" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Is original, comes up with new ideas</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question31" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Is reserved</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question32" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Is helpful and unselfish with others</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question33" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Can be somewhat careless</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question34" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Is relaxed, handles stress well</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question35" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Is curious about many different things</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question36" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Is full of energy</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question37" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Starts quarrels with others</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question38" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Is a reliable worker</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question39" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Can be tense</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question40" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Is ingenious, a deep thinker</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question41" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Generates a lot of enthusiasm</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question42" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Has a forgiving nature</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question43" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Tends to be disorganized</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question44" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Worries a lot</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question45" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Has an active imagination</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question46" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Tends to be quiet</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question47" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Is generally trusting</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question48" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Tends to be lazy</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question49" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Is emotionally stable, not easily upset</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question50" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Is inventive</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question51" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Has an assertive personality</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question52" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Can be cold and aloof</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question53" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Perseveres until the task is finished</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question54" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Can be moody</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question55" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Values artistic, aesthetic experiences</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question56" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Is sometimes shy, inhibited</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question57" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Is considerate and kind to almost everyone</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question58" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Does things efficiently</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question59" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Remains calm in tense situations</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question60" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Prefers work that is routine</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question61" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Is outgoing, sociable</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question62" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Is sometimes rude to others</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question63" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Makes plans and follows through with them</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question64" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Gets nervous easily</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question65" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Likes to reflect, play with ideas</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question66" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Has few (not many) artistic interests</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question67" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Likes to cooperate with others</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question68" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Is easily distracted</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question69" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-bottom-row">
                        <div class="survey-table-question-cell">Is sophisticated in art, music, or literature</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question70" value="${i}"/></div>
                        </g:each>
                    </div>
                </div>
            </div>
            <div class="survey-question-container">
                <!-- div class="survey-table-question-instructions">
                    Please tell us how much each statement below applies to you personally.
                </div -->
                                
                <!-- another table -->
                <div class="survey-table">
                    <div class="survey-table-header">
                        <div class="survey-table-question-cell"></div>
                        <div class="survey-table-cell">Unimportant</div>
                        <div class="survey-table-cell"></div>
                        <div class="survey-table-cell">Somewhat Important</div>
                        <div class="survey-table-cell"></div>
                        <div class="survey-table-cell">Very Important</div>
                    </div>
                    <div class="survey-table-bottom-row">
                        <div class="survey-table-question-cell-4lines">I believe that protecting my confidential information is important</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question71" value="${i}"/></div>
                        </g:each>
                    </div>
                </div>
                
                <!-- another table -->
                <div class="survey-table">
                    <div class="survey-table-header">
                        <div class="survey-table-question-cell"></div>
                        <div class="survey-table-cell">Invulnerable</div>
                        <div class="survey-table-cell"></div>
                        <div class="survey-table-cell">Somewhat Vulnerable</div>
                        <div class="survey-table-cell"></div>
                        <div class="survey-table-cell">Very Vulnerable</div>
                    </div>
                    <div class="survey-table-bottom-row">
                        <div class="survey-table-question-cell-4lines">The vulnerability of my confidential information is</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question72" value="${i}"/></div>
                        </g:each>
                    </div>
                </div>
                
                <!-- another table -->
                <div class="survey-table">
                    <div class="survey-table-header">
                        <div class="survey-table-question-cell"></div>
                        <div class="survey-table-cell">Harmless</div>
                        <div class="survey-table-cell"></div>
                        <div class="survey-table-cell"></div>
                        <div class="survey-table-cell"></div>
                        <div class="survey-table-cell">Severe</div>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">Threats to the security of my confidential information are</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question73" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">Having my confidential information obtained by someone without my authorization is</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question74" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-bottom-row">
                        <div class="survey-table-question-cell-4lines">Threats from email phishing are</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question75" value="${i}"/></div>
                        </g:each>
                    </div>
                </div>
                
                <!-- another table -->
                <div class="survey-table">
                    <div class="survey-table-header">
                        <div class="survey-table-question-cell"></div>
                        <div class="survey-table-cell">Unlikely</div>
                        <div class="survey-table-cell"></div>
                        <div class="survey-table-cell">Somewhat Likely</div>
                        <div class="survey-table-cell"></div>
                        <div class="survey-table-cell">Very Likely</div>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">The likelihood of someone getting my confidential information without my consent or knowledge is</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question76" value="${i}"/></div>
                        </g:each>
                    </div>                    
                    <div class="survey-table-bottom-row">
                        <div class="survey-table-question-cell-4lines">The likelihood of an email phishing attack on me occurring is</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question77" value="${i}"/></div>
                        </g:each>
                    </div>
                </div>
                
                
                <div class="survey-table">
                    <div class="survey-table-header">
                        <div class="survey-table-question-cell"></div>
                        <div class="survey-table-cell">Disagree Strongly</div>
                        <div class="survey-table-cell">Disagree a little</div>
                        <div class="survey-table-cell">Neither agree nor disagree</div>
                        <div class="survey-table-cell">Agree a little</div>
                        <div class="survey-table-cell">Agree strongly</div>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">I believe that trying to protect my confidential information will reduce illegal access to it</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question78" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">I worry a lot when someone tells me I am about to lose my privileges</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question79" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">If I start on something, I cannot stop until it’s done</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question80" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">When someone gives me something, I feel like I should return the favor</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question81" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">I have confidence in people who have made successes of their lives</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question82" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">I don’t like losing out on opportunities</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question83" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">I trust people who I perceive to have special expertise</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question84" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">I enjoy helping people I like</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question85" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">When someone does something for me, I feel like I should do something for them</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question86" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">I believe in finishing what I start</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question87" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">If my friends are doing something, I like to join in</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question88" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">I buy something if it’s no longer going to be available and its value will increase</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question89" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">I believe it is important to strictly follow the chain of command</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question90" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">If I don’t take a chance on things, I feel like I will lose out</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question91" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">I think professional-looking emails are more trustworthy than those that are plain or have errors</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question92" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">I would rather comply with an order than to get into trouble</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question93" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">I will take risks if there is a chance I will be rewarded</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question94" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">I was taught to keep my promises</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question95" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">If I like someone, I will help them even when I probably shouldn’t</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question96" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">When there is a limited time to act, I do act</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question97" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">I think it is important to act quickly if time is running out</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question98" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">I believe in keeping up my end of the bargain even when others don’t</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question99" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">People who have confidence are good decision-makers</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question100" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">It’s important to be part of the “in group”</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question101" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-bottom-row">
                        <div class="survey-table-question-cell-4lines">Friendly people are usually trustworthy</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question102" value="${i}"/></div>
                        </g:each>
                    </div>
                </div>


                <!-- another table -->
                <div class="survey-table">
                    <div class="survey-table-header">
                        <div class="survey-table-question-cell"></div>
                        <div class="survey-table-cell">Never</div>
                        <div class="survey-table-cell">Rarely</div>
                        <div class="survey-table-cell">Sometimes</div>
                        <div class="survey-table-cell">Often</div>
                        <div class="survey-table-cell">Always</div>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">I update my information online when requested</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question103" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">I give out personal information if it benefits me</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question104" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell-4lines">I open links in email to get important information</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question105" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-bottom-row">
                        <div class="survey-table-question-cell-4lines">I provide confidential information when important people request it</div>
                        <g:each var="i" in="${ (1..<6) }">
                            <div class="survey-table-cell"><g:radio name="question106" value="${i}"/></div>
                        </g:each>
                    </div>
                </div>
            </div>
            
            
            <div class="survey-question-container" style="background: #D6E7FF; height: 50px;">
                <div class="survey-question" style="color: #003177; font-size: 16pt">
                    Please give your best estimate for the following:
                </div>
            </div>
            <div class="survey-question-container survey-question-container-colored">
                <div class="survey-question">
                    Number of emails you receive in your SNL inbox per day:
                </div>
                <div class="survey-response">
                    <g:textField name="question107"/>
                </div>
            </div>
            <div class="survey-question-container">
                <div class="survey-question">
                    Number of emails you read in your SNL inbox per day:
                </div>
                <div class="survey-response">
                    <g:textField name="question108"/>
                </div>
            </div>
            <div class="survey-question-container survey-question-container-colored">
                <div class="survey-question">
                    Number of hours you spend on the following activities per day:
                </div>
                <div class="survey-subquestion-container">
                    <div class="survey-subquestion">Email:</div>
                    <div class="survey-response"><g:textField name="question109"/></div>
                </div>
                <div class="survey-subquestion-container">
                    <div class="survey-subquestion">Meetings:</div>
                    <div class="survey-response"><g:textField name="question110"/></div>
                </div>
                <div class="survey-subquestion-container">
                    <div class="survey-subquestion">Paperwork (timecards, expense reports, etc.):</div>
                    <div class="survey-response"><g:textField name="question111"/></div>
                </div>
                <div class="survey-subquestion-container">
                    <div class="survey-subquestion">Work (not counting any overhead):</div>
                    <div class="survey-response"><g:textField name="question112"/></div>
                </div>
                <div class="survey-subquestion-container">
                    <div class="survey-subquestion">Informal discussions with others:</div>
                    <div class="survey-response"><g:textField name="question113"/></div>
                </div>
            </div>
            <div class="survey-question-container">
                <div class="survey-question">
                    Average number of hours you work per week:
                </div>
                <div class="survey-response">
                    <g:textField name="question114"/>
                </div>
            </div>
            <div class="survey-question-container survey-question-container-colored">
                <div class="survey-question">
                    Average number of hours you use a computer (at work + at home) per day:
                </div>
                <div class="survey-response">
                    <g:textField name="question115"/>
                </div>
            </div>
            <div class="survey-question-container">
                <div class="survey-question">
                    How attentive are you when you check your email?
                </div>
                <div class="survey-response">
                    <g:radioGroup values="[1,2,3,4,5]" name="question116" labels="['Highly attentive: I read each email carefully and follow-up with senders regularly. I focus on each email and scan it carefully.','Attentive: I read most of my emails pretty carefully. I\'m mostly focused on the email I’m reading.','Cognizant: I read a few emails that look important carefully; I skim the rest. When reading an email, I\'m mostly paying attention to the email, though there are a few other things that may intrude on my thoughts.','Inattentive: I skim most of my emails; I skip some entirely; I\'m sometimes distracted or thinking about other things when I\'m reading my email.','Very inattentive: I only have time to check my email when I\'m too exhausted to do more complicated work.']">
                       ${it.radio} ${it.label}<br>
                    </g:radioGroup>
                </div>
            </div>
            <div class="survey-question-container survey-question-container-colored">
                <div class="survey-table-question-instructions">
                    How often do you check your SNL email on each of these types of devices?
                </div>
                <div class="survey-table">
                    <div class="survey-table-header">
                        <div class="survey-table-question-cell-4lines"></div>
                        <div class="survey-table-cell2">Constantly</div>
                        <div class="survey-table-cell2">A few times / day</div>
                        <div class="survey-table-cell2">At least once / day</div>
                        <div class="survey-table-cell2">Few times / week</div>
                        <div class="survey-table-cell2">Few times / month</div>
                        <div class="survey-table-cell2">Few times / year</div>
                        <div class="survey-table-cell2">Not applicable*</div>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">SNL-owned computer at work</div>
                        <g:each var="i" in="${ (1..<8) }">
                            <div class="survey-table-cell2"><g:radio name="question117" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">SNL-owned computer at home</div>
                        <g:each var="i" in="${ (1..<8) }">
                            <div class="survey-table-cell2"><g:radio name="question118" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Personal computer</div>
                        <g:each var="i" in="${ (1..<8) }">
                            <div class="survey-table-cell2"><g:radio name="question119" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-row">
                        <div class="survey-table-question-cell">Tablet (e.g. iPad)</div>
                        <g:each var="i" in="${ (1..<8) }">
                            <div class="survey-table-cell2"><g:radio name="question120" value="${i}"/></div>
                        </g:each>
                    </div>
                    <div class="survey-table-bottom-row">
                        <div class="survey-table-question-cell">Mobile device (phone)</div>
                        <g:each var="i" in="${ (1..<8) }">
                            <div class="survey-table-cell2"><g:radio name="question121" value="${i}"/></div>
                        </g:each>
                    </div>
                </div>
                <div class="survey-response">
                    * Not Applicable: I never check my email with this device and/or I do not own this type of device.
                </div>
            </div>
            <div class="survey-question-container">
                <div class="survey-question">
                    When did you last take these courses? Please look up 
                    the actual date in TEDS if you’re not sure.
                    (Tip: In TEDS, click on the "Activities" tab (dark blue tab at the top of the screen).
                    From the gray menu on the left side of the screen, under "Show Me:", click on "My History".
                    This will show you the list of learnings you've done, with the dates you've taken them.) 
                    Please use <u>MM/DD/YYYY</u> format.
                </div>
                <div class="survey-subquestion-container">
                    <div class="survey-subquestion">CI100:</div>
                    <div class="survey-response"><g:textField name="question122"/><br><i>(MM/DD/YYYY)</i></div>
                </div>
                <div class="survey-subquestion-container">
                    <div class="survey-subquestion">COM100:</div>
                    <div class="survey-response"><g:textField name="question123"/><br><i>(MM/DD/YYYY)</i></div>
                </div>
                <div class="survey-subquestion-container">
                    <div class="survey-subquestion">LMC330:</div>
                    <div class="survey-response"><g:textField name="question124"/><br><i>(MM/DD/YYYY)</i></div>
                </div>
                <div class="survey-subquestion-container">
                    <div class="survey-subquestion">Any other course that mentioned phishing (if applicable):</div>
                    <div class="survey-response"><g:textField name="question125"/><br><i>(MM/DD/YYYY)</i></div>
                </div>
            </div>
	    </div>
    </div>
    <div class="begin-survey-btn-container"><a href="javascript:submitForm();"><div class="begin-survey-btn"><div class="begin-survey-btn-text">Submit</div><div class="begin-survey-btn-arrow"></div></div></a></div>
    </g:form>
  </div>
</body>
</html>