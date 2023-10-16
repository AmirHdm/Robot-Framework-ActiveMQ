import ActiveMQClient


class ActiveMQLibrary:
    def __init__(self, username='admin', password='admin'):
        self.client = ActiveMQClient.ActiveMQClient(username=username, password=password)

    def send_message_to_activemq(self, destination, message):
        result = self.client.send_message(destination, message)
        if result:
            return "Message sent to ActiveMQ: " + message
        else:
            return "Failed to send the message to ActiveMQ"
