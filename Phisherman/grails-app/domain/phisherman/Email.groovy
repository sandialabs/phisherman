package phisherman

class Email {

	String fromAddress;
	String toAddress;
	String cc;
	String subject;
	Date sent;
	String body;

	static hasMany = [responses: PhishIdResponse]

    static constraints = {
		fromAddress maxSize: 500000
		toAddress maxSize: 500000
		cc maxSize: 500000
		subject maxSize: 500000
		body maxSize: 500000
    }
}
