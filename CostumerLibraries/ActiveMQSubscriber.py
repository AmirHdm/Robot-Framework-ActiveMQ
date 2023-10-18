import stomp


class ActiveMQPurger:
    def __init__(self, host='localhost', port=61613, username='admin', password='admin'):
        self.host = host
        self.port = port
        self.username = username
        self.password = password
        self.conn = None

    def connect(self):
        self.conn = stomp.Connection([(self.host, self.port)])
        self.conn.connect(self.username, self.password, wait=True)

    def disconnect(self):
        if self.conn:
            self.conn.disconnect()

    def purge_queue(self, destination):
        while True:
            self.connect()
            self.conn.subscribe(destination=destination, id=1, ack='auto')
            if type(stomp.PrintingListener()) == type(stomp.listener.PrintingListener):
                self.disconnect()


if __name__ == "__main__":
    purger = ActiveMQPurger(username='admin', password='admin')
    destination = '/queue/org.provider.testQueue'
    purger.purge_queue(destination)
