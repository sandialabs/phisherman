package phisherman

import org.grails.plugins.csv.CSVWriter
import org.springframework.dao.DataIntegrityViolationException

class PhishIdResponseController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [responseInstanceList: PhishIdResponse.list(params), responseInstanceTotal: PhishIdResponse.count()]
    }

    def create() {
        [responseInstance: new PhishIdResponse(params)]
    }

    def save() {
        def responseInstance = new PhishIdResponse(params)
        if (!responseInstance.save(flush: true)) {
            render(view: "create", model: [responseInstance: responseInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'response.label', default: 'Response'), responseInstance.id])
        redirect(action: "show", id: responseInstance.id)
    }

    def show(Long id) {
        def responseInstance = PhishIdResponse.get(id)
        if (!responseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'response.label', default: 'Response'), id])
            redirect(action: "list")
            return
        }

        [responseInstance: responseInstance]
    }

    def edit(Long id) {
        def responseInstance = PhishIdResponse.get(id)
        if (!responseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'response.label', default: 'Response'), id])
            redirect(action: "list")
            return
        }

        [responseInstance: responseInstance]
    }

    def update(Long id, Long version) {
        def responseInstance = PhishIdResponse.get(id)
        if (!responseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'response.label', default: 'Response'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (responseInstance.version > version) {
                responseInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'response.label', default: 'Response')] as Object[],
                          "Another user has updated this Response while you were editing")
                render(view: "edit", model: [responseInstance: responseInstance])
                return
            }
        }

        responseInstance.properties = params

        if (!responseInstance.save(flush: true)) {
            render(view: "edit", model: [responseInstance: responseInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'response.label', default: 'Response'), responseInstance.id])
        redirect(action: "show", id: responseInstance.id)
    }

    def delete(Long id) {
        def responseInstance = PhishIdResponse.get(id)
        if (!responseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'response.label', default: 'Response'), id])
            redirect(action: "list")
            return
        }

        try {
            responseInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'response.label', default: 'Response'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'response.label', default: 'Response'), id])
            redirect(action: "show", id: id)
        }
    }
	
	def download() {
		def sw = new StringWriter()
		def csv = new CSVWriter(sw, {
		   col1:"userId" { it.val1 }
		   col2:"emailId" { it.val2 }
		   col3:"isPhish" { it.val3 }
		   col4:"confidence" { it.val4 }
		   col5:"responseId" { it.val5 }
		   col6:"emailOrder" { it.val6 }
		   col6:"duration" { it.val7 }
		})
		def results = PhishIdResponse.createCriteria().list {
		    order('userId', 'asc')
		    order('email.id', 'asc')
		}
		def processedUsers = new HashSet<String>()
		def ids = new HashSet<String>()
		for(def response in results) {
			if(response.end != 0L) {
				def id = Integer.toHexString(response.userId.hash)
				if(!processedUsers.contains(response.userId) && ids.contains(id)) {
					render "Error: User ID Collision! Contact JT or Derek!"
					return
				}
				processedUsers.add(response.userId)
				ids.add(id)
				def user = User.findByUserName(response.userId)
				def eo = user.emailOrder
				def eoArr = eo.split(", ?")
				def eoList = Arrays.asList(eoArr)
				def duration = response.end - response.start;
				csv << [val1: id, val2: response.email.id, val3: response.isPhish, val4: response.confidence, val5: response.id, val6: eoList.indexOf("" + response.email.id) + 1, val7: duration]
			}
		}
		response.setHeader "Content-disposition", "attachment; filename=phishid_email_responses.csv"
		response.contentType = 'text/csv'
		response.outputStream << csv.writer.toString() 
		response.outputStream.flush()
	}
}
