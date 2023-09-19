package phisherman



import org.junit.*
import grails.test.mixin.*

@TestFor(SurveyResponseController)
@Mock(SurveyResponse)
class SurveyResponseControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/surveyResponse/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.surveyResponseInstanceList.size() == 0
        assert model.surveyResponseInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.surveyResponseInstance != null
    }

    void testSave() {
        controller.save()

        assert model.surveyResponseInstance != null
        assert view == '/surveyResponse/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/surveyResponse/show/1'
        assert controller.flash.message != null
        assert SurveyResponse.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/surveyResponse/list'

        populateValidParams(params)
        def surveyResponse = new SurveyResponse(params)

        assert surveyResponse.save() != null

        params.id = surveyResponse.id

        def model = controller.show()

        assert model.surveyResponseInstance == surveyResponse
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/surveyResponse/list'

        populateValidParams(params)
        def surveyResponse = new SurveyResponse(params)

        assert surveyResponse.save() != null

        params.id = surveyResponse.id

        def model = controller.edit()

        assert model.surveyResponseInstance == surveyResponse
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/surveyResponse/list'

        response.reset()

        populateValidParams(params)
        def surveyResponse = new SurveyResponse(params)

        assert surveyResponse.save() != null

        // test invalid parameters in update
        params.id = surveyResponse.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/surveyResponse/edit"
        assert model.surveyResponseInstance != null

        surveyResponse.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/surveyResponse/show/$surveyResponse.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        surveyResponse.clearErrors()

        populateValidParams(params)
        params.id = surveyResponse.id
        params.version = -1
        controller.update()

        assert view == "/surveyResponse/edit"
        assert model.surveyResponseInstance != null
        assert model.surveyResponseInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/surveyResponse/list'

        response.reset()

        populateValidParams(params)
        def surveyResponse = new SurveyResponse(params)

        assert surveyResponse.save() != null
        assert SurveyResponse.count() == 1

        params.id = surveyResponse.id

        controller.delete()

        assert SurveyResponse.count() == 0
        assert SurveyResponse.get(surveyResponse.id) == null
        assert response.redirectedUrl == '/surveyResponse/list'
    }
}
