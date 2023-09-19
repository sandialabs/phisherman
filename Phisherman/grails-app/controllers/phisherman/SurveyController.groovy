package phisherman

import phisherman.User.UserGroup
import phisherman.User.UserState

class SurveyController extends BaseController {

    def index() {

        // Grab user information from the request & database.
        def userName = getUserName()
        def user = User.findByUserName(userName)

        // Ensure user is on the correct page.
        if(!ensureCorrectPage(user, UserState.SURVEY)) {
            return
        }

        if(params['button'] == 'submit') {

			def response = new SurveyResponse(userName: userName)

			for(i in 1..125) {
                if(i == 13) {
                    def q13 = '';
                    for(j in 1..6) {
                        def val = params['question' + i + '-' + j];
                        if(val != null && val != "") {
                            q13 += '' + j;
                            if(j != 6) {
                                q13 += ";"
                            }
                        }
                    }
                    response['question13'] = q13;
                } else if(i == 6 || i == 16 || i == 24 || i == 26) {
                    response['question' + i] = params['question' + i] ?: ""
                    response['question' + i + 'other'] = params['question' + i + '-other'] ?: ""

                } else {
                    response['question' + i] = params['question' + i] ?: ""
                }
			}
			response.save();

            if(user.userGroup == UserGroup.SURVEY_FIRST) {
                user.state = UserState.PHISHID;
                user.save();
                render(view: "end")
            } else {
                user.state = UserState.DONE;
                user.save();
                redirect(controller: "done")
            }
        }
    }
}
