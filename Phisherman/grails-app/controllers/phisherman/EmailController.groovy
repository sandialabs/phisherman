package phisherman

import org.springframework.dao.DataIntegrityViolationException

class EmailController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [emailInstanceList: Email.list(params), emailInstanceTotal: Email.count()]
    }

    def create() {
        [emailInstance: new Email(params)]
    }

    def save() {
        def emailInstance = new Email(params)
        if (!emailInstance.save(flush: true)) {
            render(view: "create", model: [emailInstance: emailInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'email.label', default: 'Email'), emailInstance.id])
        redirect(action: "show", id: emailInstance.id)
    }

    def show(Long id) {
        def emailInstance = Email.get(id)
        if (!emailInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'email.label', default: 'Email'), id])
            redirect(action: "list")
            return
        }

        [emailInstance: emailInstance]
    }

    def edit(Long id) {
        def emailInstance = Email.get(id)
        if (!emailInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'email.label', default: 'Email'), id])
            redirect(action: "list")
            return
        }

        [emailInstance: emailInstance]
    }

    def update(Long id, Long version) {
        def emailInstance = Email.get(id)
        if (!emailInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'email.label', default: 'Email'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (emailInstance.version > version) {
                emailInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'email.label', default: 'Email')] as Object[],
                          "Another user has updated this Email while you were editing")
                render(view: "edit", model: [emailInstance: emailInstance])
                return
            }
        }

        emailInstance.properties = params

        if (!emailInstance.save(flush: true)) {
            render(view: "edit", model: [emailInstance: emailInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'email.label', default: 'Email'), emailInstance.id])
        redirect(action: "show", id: emailInstance.id)
    }

    def delete(Long id) {
        def emailInstance = Email.get(id)
        if (!emailInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'email.label', default: 'Email'), id])
            redirect(action: "list")
            return
        }

        try {
            emailInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'email.label', default: 'Email'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'email.label', default: 'Email'), id])
            redirect(action: "show", id: id)
        }
    }
}
