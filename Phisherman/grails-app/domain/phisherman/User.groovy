package phisherman

class User {

	enum UserState {
		LANDING,
		SURVEY,
		PHISHID,
        DONE
	}

	enum UserGroup {
		PHISH_ID_FIRST,
		SURVEY_FIRST
	}

	String userName;
	boolean consented;
	UserState state;
	int currentPhishIndex;
	UserGroup userGroup;
    String emailOrder;

    static constraints = {
		emailOrder maxSize: 500000
    }
}
