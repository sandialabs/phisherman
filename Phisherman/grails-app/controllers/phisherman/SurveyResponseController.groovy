package phisherman

import org.grails.plugins.csv.CSVWriter
import org.springframework.dao.DataIntegrityViolationException

class SurveyResponseController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [surveyResponseInstanceList: SurveyResponse.list(params), surveyResponseInstanceTotal: SurveyResponse.count()]
    }

    def create() {
        [surveyResponseInstance: new SurveyResponse(params)]
    }

    def save() {
        def surveyResponseInstance = new SurveyResponse(params)
        if (!surveyResponseInstance.save(flush: true)) {
            render(view: "create", model: [surveyResponseInstance: surveyResponseInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'surveyResponse.label', default: 'SurveyResponse'), surveyResponseInstance.id])
        redirect(action: "show", id: surveyResponseInstance.id)
    }

    def show(Long id) {
        def surveyResponseInstance = SurveyResponse.get(id)
        if (!surveyResponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'surveyResponse.label', default: 'SurveyResponse'), id])
            redirect(action: "list")
            return
        }

        [surveyResponseInstance: surveyResponseInstance]
    }

    def edit(Long id) {
        def surveyResponseInstance = SurveyResponse.get(id)
        if (!surveyResponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'surveyResponse.label', default: 'SurveyResponse'), id])
            redirect(action: "list")
            return
        }

        [surveyResponseInstance: surveyResponseInstance]
    }

    def update(Long id, Long version) {
        def surveyResponseInstance = SurveyResponse.get(id)
        if (!surveyResponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'surveyResponse.label', default: 'SurveyResponse'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (surveyResponseInstance.version > version) {
                surveyResponseInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'surveyResponse.label', default: 'SurveyResponse')] as Object[],
                          "Another user has updated this SurveyResponse while you were editing")
                render(view: "edit", model: [surveyResponseInstance: surveyResponseInstance])
                return
            }
        }

        surveyResponseInstance.properties = params

        if (!surveyResponseInstance.save(flush: true)) {
            render(view: "edit", model: [surveyResponseInstance: surveyResponseInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'surveyResponse.label', default: 'SurveyResponse'), surveyResponseInstance.id])
        redirect(action: "show", id: surveyResponseInstance.id)
    }

    def delete(Long id) {
        def surveyResponseInstance = SurveyResponse.get(id)
        if (!surveyResponseInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'surveyResponse.label', default: 'SurveyResponse'), id])
            redirect(action: "list")
            return
        }

        try {
            surveyResponseInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'surveyResponse.label', default: 'SurveyResponse'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'surveyResponse.label', default: 'SurveyResponse'), id])
            redirect(action: "show", id: id)
        }
    }



	def download() {
		def sw = new StringWriter()
		def csv = new CSVWriter(sw, {
			col1:"question1" {it.val1}
			col2:"question2" {it.val2}
			col3:"question3" {it.val3}
			col4:"question4" {it.val4}
			col5:"question5" {it.val5}
			col6:"question6" {it.val6}
			col7:"question7" {it.val7}
			col8:"question8" {it.val8}
			col9:"question9" {it.val9}
			col10:"question10" {it.val10}
			col11:"question11" {it.val11}
			col12:"question12" {it.val12}
			col13:"question13" {it.val13}
			col14:"question14" {it.val14}
			col15:"question15" {it.val15}
			col16:"question16" {it.val16}
			col17:"question17" {it.val17}
			col18:"question18" {it.val18}
			col19:"question19" {it.val19}
			col20:"question20" {it.val20}
			col21:"question21" {it.val21}
			col22:"question22" {it.val22}
			col23:"question23" {it.val23}
			col24:"question24" {it.val24}
			col25:"question25" {it.val25}
			col26:"question26" {it.val26}
			col27:"question27" {it.val27}
			col28:"question28" {it.val28}
			col29:"question29" {it.val29}
			col30:"question30" {it.val30}
			col31:"question31" {it.val31}
			col32:"question32" {it.val32}
			col33:"question33" {it.val33}
			col34:"question34" {it.val34}
			col35:"question35" {it.val35}
			col36:"question36" {it.val36}
			col37:"question37" {it.val37}
			col38:"question38" {it.val38}
			col39:"question39" {it.val39}
			col40:"question40" {it.val40}
			col41:"question41" {it.val41}
			col42:"question42" {it.val42}
			col43:"question43" {it.val43}
			col44:"question44" {it.val44}
			col45:"question45" {it.val45}
			col46:"question46" {it.val46}
			col47:"question47" {it.val47}
			col48:"question48" {it.val48}
			col49:"question49" {it.val49}
			col50:"question50" {it.val50}
			col51:"question51" {it.val51}
			col52:"question52" {it.val52}
			col53:"question53" {it.val53}
			col54:"question54" {it.val54}
			col55:"question55" {it.val55}
			col56:"question56" {it.val56}
			col57:"question57" {it.val57}
			col58:"question58" {it.val58}
			col59:"question59" {it.val59}
			col60:"question60" {it.val60}
			col61:"question61" {it.val61}
			col62:"question62" {it.val62}
			col63:"question63" {it.val63}
			col64:"question64" {it.val64}
			col65:"question65" {it.val65}
			col66:"question66" {it.val66}
			col67:"question67" {it.val67}
			col68:"question68" {it.val68}
			col69:"question69" {it.val69}
			col70:"question70" {it.val70}
			col71:"question71" {it.val71}
			col72:"question72" {it.val72}
			col73:"question73" {it.val73}
			col74:"question74" {it.val74}
			col75:"question75" {it.val75}
			col76:"question76" {it.val76}
			col77:"question77" {it.val77}
			col78:"question78" {it.val78}
			col79:"question79" {it.val79}
			col80:"question80" {it.val80}
			col81:"question81" {it.val81}
			col82:"question82" {it.val82}
			col83:"question83" {it.val83}
			col84:"question84" {it.val84}
			col85:"question85" {it.val85}
			col86:"question86" {it.val86}
			col87:"question87" {it.val87}
			col88:"question88" {it.val88}
			col89:"question89" {it.val89}
			col90:"question90" {it.val90}
			col91:"question91" {it.val91}
			col92:"question92" {it.val92}
			col93:"question93" {it.val93}
			col94:"question94" {it.val94}
			col95:"question95" {it.val95}
			col96:"question96" {it.val96}
			col97:"question97" {it.val97}
			col98:"question98" {it.val98}
			col99:"question99" {it.val99}
			col100:"question100" {it.val100}
			col101:"question101" {it.val101}
			col102:"question102" {it.val102}
			col103:"question103" {it.val103}
			col104:"question104" {it.val104}
			col105:"question105" {it.val105}
			col106:"question106" {it.val106}
			col107:"question107" {it.val107}
			col108:"question108" {it.val108}
			col109:"question109" {it.val109}
			col110:"question110" {it.val110}
			col111:"question111" {it.val111}
			col112:"question112" {it.val112}
			col113:"question113" {it.val113}
			col114:"question114" {it.val114}
			col115:"question115" {it.val115}
			col116:"question116" {it.val116}
			col117:"question117" {it.val117}
			col118:"question118" {it.val118}
			col119:"question119" {it.val119}
			col120:"question120" {it.val120}
			col121:"question121" {it.val121}
			col122:"question122" {it.val122}
			col123:"question123" {it.val123}
			col124:"question124" {it.val124}
			col125:"question125" {it.val125}
            col126:"question6other" {it.val126}
			col127:"question16other" {it.val127}
			col128:"question24other" {it.val128}
			col129:"question26other" {it.val129}
			col130:"userId" {it.val130}
		})
		def results = SurveyResponse.findAll(sort: "userName");
		for(def response in results) {
			def id = Integer.toHexString(response.userName.hash)
			def values = [:]
			for(def i in 1..125) {
				values["val" + i] = response["question" + i].toString().replace("\n", " ").replace("\r", " ");
			}
			values["val126"] = response.question6other.toString().replace("\n", " ").replace("\r", " ");
            values["val127"] = response.question16other.toString().replace("\n", " ").replace("\r", " ");
			values["val128"] = response.question24other.toString().replace("\n", " ").replace("\r", " ");
			values["val129"] = response.question26other.toString().replace("\n", " ").replace("\r", " ");
			values["val130"] = id
			csv << values
		}
		response.setHeader "Content-disposition", "attachment; filename=phishid_survey_responses.csv"
		response.contentType = 'text/csv'
		response.outputStream << csv.writer.toString()
		response.outputStream.flush()
	}
}
