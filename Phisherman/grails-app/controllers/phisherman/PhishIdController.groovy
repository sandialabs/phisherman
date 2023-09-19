package phisherman

import phisherman.User.UserGroup
import phisherman.User.UserState

class PhishIdController extends BaseController {

    def index() {

        // Grab user information from the request & database.
		def userName = getUserName()
		def user = User.findByUserName(userName)
println "PhishIdController.index " + user
if(user) {
    println " == PHISH IDX=" + user.currentPhishIndex
} else {
    println "no user"
}
        // Ensure user is on the correct page.
        if(!ensureCorrectPage(user, UserState.PHISHID)) {
            return
        }

		def confidence = params['confidence']
		def phishSelection = params['txtPhishSelection']
		def curIndexStr = params['index']
        def collapsed = params['chkCollapsed']
		def isRedirect = params['isRedirect']
        if(!collapsed) {
            collapsed = 0
        }

		if(!curIndexStr) {
			render(view: "start", model: [user: userName])
			return
		}

        // Get list of email ID's specifying the order the
        // e-mails should be shown to the user.  This will
        // be in the form of "2, 6, 3, 5, 4, 1".
        String emailOrder = user.emailOrder;
        String[] parts = emailOrder.split("\\s*,\\s*");

        def curIndex = Integer.parseInt(curIndexStr);
        if(!isRedirect && curIndex >= 0) {

            // Look up the current email object given the index.
            int curEmailId = Integer.parseInt(parts[curIndex]);
			def curEmail = Email.findById(curEmailId)

			if(curEmail) {
				def index = PhishIdResponse.countByUserIdAndConfidenceNotEqual(userName, 0)
		
				if(curIndex != index) {
					render(view: "redirect", model: [user: userName, index: index])
					return
				}
				def isPhish = phishSelection == "1"
		
				// *************************************************
				// Toggle to disable timing
				def response = PhishIdResponse.findByUserIdAndEmail(userName, curEmail)
				response.isPhish = isPhish
				response.confidence = Integer.parseInt(confidence)
				response.end = System.currentTimeMillis()
//				def response = new PhishIdResponse(
//                    email: curEmail,
//                    userId: userName,
//                    isPhish: isPhish,
//                    confidence: confidence
//                )
				// *************************************************
                user.currentPhishIndex = curIndex + 1;
				response.save(flush: true)
				curEmail.addToResponses(response)
				curEmail.save()
			}
		}

        def nextIndex = curIndex
		if(!isRedirect) {
			nextIndex++
		}
		if(nextIndex >= parts.length) {
            if(user.userGroup == UserGroup.PHISH_ID_FIRST) {
                user.state = UserState.SURVEY;
                user.save();
                render(view: "end")
            } else {
                user.state = UserState.DONE;
                user.save();
                redirect(controller: "done")
            }
            return;
		}

        // Look up the next email object given the next index.
        int nextEmailId = Integer.parseInt(parts[nextIndex]);
        def nextEmail = Email.findById(nextEmailId)
		
		// *************************************************
		// Remove to disable timing
		def response = PhishIdResponse.findByUserIdAndEmail(userName, nextEmail)
		if(!response) {
			response = new PhishIdResponse(
				email: nextEmail,
				userId: userName,
				start: System.currentTimeMillis()
			)
			response.save(flush: true)
		}
		// *************************************************
		
		render(view: "response",
            model: [
                user: userName,
                email: nextEmail,
                index: nextIndex,
                collapsed: collapsed
            ]
        )
	}
}
