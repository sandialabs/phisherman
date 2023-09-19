package phisherman

import phisherman.User.UserGroup
import phisherman.User.UserState


class LandingController extends BaseController {

    def index() {

        // Grab user information from the request & database.
        def userName = getUserName()
        def user = User.findByUserName(userName)

        // If this user has never been seen before, create
        // a record for them.
        if(!user) {

            // Prepare group
            def group = servletContext.getAttribute("groupToggle")
            if(!group) {
                group = 0;
            }
            UserGroup userGroup = (group == 1) ?
                UserGroup.SURVEY_FIRST :
                UserGroup.PHISH_ID_FIRST;

            // Prepare order
            def order = []
            Email.list().each {
                order.add(it.id)
            }
            Collections.shuffle(order)
            String emailOrder = order.toString();
            emailOrder = emailOrder.substring(0, emailOrder.length() - 1);
            emailOrder = emailOrder.substring(1);

            // Construct record
            user = new User(
                userName: userName,
                consented: false,
                state: UserState.LANDING,
                currentPhishIndex: 0,
                userGroup: userGroup,
                emailOrder: emailOrder
            )
            user.save()

            // Change group
            group = 1 - group;
            servletContext.setAttribute("groupToggle", group);
        }

        // Ensure user is on the correct page.
        if(!ensureCorrectPage(user, UserState.LANDING)) {
            return
        }

        if(params['button'] == 'accept') {
            user.consented = true;
            if(user.userGroup == UserGroup.PHISH_ID_FIRST) {
                user.state = UserState.PHISHID;
                redirect(controller: "phishId")
            } else {
                user.state = UserState.SURVEY;
                redirect(controller: "survey")
            }
            user.save();

        } else if(params['button'] == 'decline' ) {
            user.consented = false;
            user.save();
            render(view: "end")

        } else {
            render(view: "index")
        }
    }
}
