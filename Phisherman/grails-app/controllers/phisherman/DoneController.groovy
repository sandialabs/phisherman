package phisherman

import phisherman.User.UserState


class DoneController extends BaseController {
    def index() {
        def userName = getUserName()
        def user = User.findByUserName(userName)

        if(!ensureCorrectPage(user, UserState.DONE)) {
            return
        }

        render(view: "index")
    }
}
