# custom_jms_keywords.py

from javax.jms import Session, ConnectionFactory
from org.apache.activemq import ActiveMQConnectionFactory
from org.apache.activemq import ActiveMQQueue

class JMSKeywords:

    def __init__(self, broker_url):
        self.broker_url = broker_url
        self.connection = None
        self.session = None
        self.producer = None

    def connect_to_jms(self):
        connection_factory = ActiveMQConnectionFactory(self.broker_url)
        self.connection = connection_factory.createConnection()
        self.connection.start()
        self.session = self.connection.createSession(False, Session.AUTO_ACKNOWLEDGE)

    def send_jms_message(self, queue_name, message_text):
        destination = ActiveMQQueue(queue_name)
        self.producer = self.session.createProducer(destination)
        message = self.session.createTextMessage(message_text)
        self.producer.send(message)

    def disconnect_from_jms(self):
        if self.producer:
            self.producer.close()
        if self.session:
            self.session.close()
        if self.connection:
            self.connection.close()
