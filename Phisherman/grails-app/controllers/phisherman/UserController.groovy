package phisherman

import org.grails.plugins.csv.CSVWriter
import org.springframework.dao.DataIntegrityViolationException

class UserController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [userInstanceList: User.list(params), userInstanceTotal: User.count()]
    }

    def create() {
        [userInstance: new User(params)]
    }

    def save() {
        def userInstance = new User(params)
        if (!userInstance.save(flush: true)) {
            render(view: "create", model: [userInstance: userInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

    def show(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance]
    }

    def edit(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        [userInstance: userInstance]
    }

    def update(Long id, Long version) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (userInstance.version > version) {
                userInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'user.label', default: 'User')] as Object[],
                          "Another user has updated this User while you were editing")
                render(view: "edit", model: [userInstance: userInstance])
                return
            }
        }

        userInstance.properties = params

        if (!userInstance.save(flush: true)) {
            render(view: "edit", model: [userInstance: userInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), userInstance.id])
        redirect(action: "show", id: userInstance.id)
    }

    def delete(Long id) {
        def userInstance = User.get(id)
        if (!userInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
            return
        }


        try {
            def phishIdResponses =
                PhishIdResponse.findAllByUserId(userInstance.userName);
            for(resp in phishIdResponses) {
                resp.delete(flush: true);
            }

            userInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
            redirect(action: "show", id: id)
        }
    }
	
	def download() {
		def sw = new StringWriter()
		def csv = new CSVWriter(sw, {
		   col1:"userId" { it.val1 }
		   col2:"username" { it.val2 }
		})
		def results = User.findAll(sort: "userName");
		for(def user in results) {
			def id = Integer.toHexString(user.userName.hash)
			csv << [val1: id, val2: user.userName]
		}
		response.setHeader "Content-disposition", "attachment; filename=phishid_userid_mapping.csv"
		response.contentType = 'text/csv'
		response.outputStream << csv.writer.toString() 
		response.outputStream.flush()
	}
	
	def downloadUserStatus() {
		def sw = new StringWriter()
		def csv = new CSVWriter(sw, {
		   col1:"username" { it.val1 }
		   col2:"state" { it.val2 }
		   col3:"consented" { it.val3 }
		})
		def results = User.findAll(sort: "userName");
		for(def user in results) {
			csv << [val1: user.userName, val2: user.state, val3: user.consented]
		}
		response.setHeader "Content-disposition", "attachment; filename=phishid_user_status.csv"
		response.contentType = 'text/csv'
		response.outputStream << csv.writer.toString()
		response.outputStream.flush()
	}
}
