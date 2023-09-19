package phisherman

class PhishIdResponse {
	
	boolean isPhish;
	int confidence;
	String userId;
	long start;
	long end;
	
	static belongsTo = [email: Email]

    static constraints = {
    }
}
