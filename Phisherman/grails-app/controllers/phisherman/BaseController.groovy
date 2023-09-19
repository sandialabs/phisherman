package phisherman

import phisherman.User.UserState


abstract class BaseController {

    def showDebug() {
        def sp = "    "
        println "Request:"
        println sp + "contextPath = " + request.contextPath
        println sp + "dispatcherType = " + request.dispatcherType
        println sp + "pathInfo = " + request.pathInfo
        println sp + "queryString = " + request.queryString
        println sp + "requestDispatcherPath = " + request.requestDispatcherPath
        println sp + "requestURI = " + request.requestURI
        println sp + "servletPath = " + request.servletPath
        println sp + "specials = " + Arrays.toString(request.specials)
        println sp + "specialAttributes = " + Arrays.toString(request.specialAttributes)
        println sp + "Parameters:"
        for(Object key : params.keySet()) {
            def type = key instanceof String ? "" : " [" + key.getClass().getSimpleName() + "]"
            Object value = params.get(key)
            def type2 = value instanceof String ? "" : " [" + value.getClass().getSimpleName() + "]"
            println sp + sp + key + type + " = " + value + type
        }
        println sp + "Session:"
        for(Object key : session.getAttributeNames()) {
            def type = key instanceof String ? "" : " [" + key.getClass().getSimpleName() + "]"
            Object value = session.getAttribute(key)
            def type2 = value instanceof String ? "" : " [" + value.getClass().getSimpleName() + "]"
            println sp + sp + key + type + " = " + value + type
        }
        println sp + "Servlet Context:"
        for(Object key : servletContext.getAttributeNames()) {
            if(!key.toString().endsWith("MergedWebXml")) {
                def type = key instanceof String ? "" : " [" + key.getClass().getSimpleName() + "]"
                Object value = servletContext.getAttribute(key)
                def type2 = value instanceof String ? "" : " [" + value.getClass().getSimpleName() + "]"
                println sp + sp + key + type + " = " + value + type
            }
        }
    }

    def isDev = {
        grailsApplication.config.phisherman.isdev
    }

    // Copy of this method in main.gsp!
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


    // Ensure user is on the correct page.
    def ensureCorrectPage(user, current) {
println "ENSURE=USER=[" + user + "]/ CUR=[" + current + "]"
        // If there is no user, redirect to landing page.
        if(!user) {
            redirect(controller: "landing")
            return false
        }

        // If this user is on the wrong page, redirect
        // to the correct page.
        if(current != UserState.SURVEY && user.state == UserState.SURVEY) {
            println "need to be on survey"
            if(user.consented) {
                redirect(controller: "survey")
            } else {
                redirect(controller: "landing")  // Should never happen!
            }
            return false

        } else if(current != UserState.PHISHID && user.state == UserState.PHISHID) {
            println "need to be on phishid"
            println ">>PHISH INDEX=" + user.currentPhishIndex
            if(user.consented) {
                redirect(controller: "phishId", params:[index:user.currentPhishIndex, isRedirect:true], method: "post")
                // Need to specify which question
            } else {
                redirect(controller: "landing")  // Should never happen!
            }
            return false

        } else if(current != UserState.LANDING && user.state == UserState.LANDING) {
        println "need to be on landing"
            redirect(controller: "landing")
            return false
        } else if(current != UserState.DONE && user.state == UserState.DONE) {
        println "need to be on done"
            redirect(controller: "done")
            return false
        }

        return true
    }
}
