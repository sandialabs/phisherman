package phisherman



import org.junit.*
import grails.test.mixin.*

@TestFor(PhishIdResponseController)
@Mock(PhishIdResponse)
class PhishIdResponseControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/response/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.responseInstanceList.size() == 0
        assert model.responseInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.responseInstance != null
    }

    void testSave() {
        controller.save()

        assert model.responseInstance != null
        assert view == '/response/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/response/show/1'
        assert controller.flash.message != null
        assert PhishIdResponse.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/response/list'

        populateValidParams(params)
        def response = new PhishIdResponse(params)

        assert response.save() != null

        params.id = response.id

        def model = controller.show()

        assert model.responseInstance == response
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/response/list'

        populateValidParams(params)
        def response = new PhishIdResponse(params)

        assert response.save() != null

        params.id = response.id

        def model = controller.edit()

        assert model.responseInstance == response
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/response/list'

        response.reset()

        populateValidParams(params)
        def response = new PhishIdResponse(params)

        assert response.save() != null

        // test invalid parameters in update
        params.id = response.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/response/edit"
        assert model.responseInstance != null

        response.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/response/show/$response.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        response.clearErrors()

        populateValidParams(params)
        params.id = response.id
        params.version = -1
        controller.update()

        assert view == "/response/edit"
        assert model.responseInstance != null
        assert model.responseInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/response/list'

        response.reset()

        populateValidParams(params)
        def response = new PhishIdResponse(params)

        assert response.save() != null
        assert PhishIdResponse.count() == 1

        params.id = response.id

        controller.delete()

        assert PhishIdResponse.count() == 0
        assert PhishIdResponse.get(response.id) == null
        assert response.redirectedUrl == '/response/list'
    }
}
