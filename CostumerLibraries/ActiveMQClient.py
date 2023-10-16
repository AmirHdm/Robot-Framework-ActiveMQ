import stomp


class ActiveMQClient:
    def __init__(self, host='localhost', port=61613, username='admin', password='admin'):
        self.host = host
        self.port = port
        self.username = username
        self.password = password

    def send_message(self, destination, message):
        try:
            # Create a connection to the ActiveMQ server
            conn = stomp.Connection([(self.host, self.port)])
            # Set a listener for error and message events
            conn.set_listener('', stomp.PrintingListener())
            # Connect to the ActiveMQ server
            conn.connect(self.username, self.password, wait=True)
            # Send a message to the specified destination
            conn.send(body=message, destination=destination)
            # Disconnect from the ActiveMQ server
            conn.disconnect()
            return True
        except Exception as e:
            print(f"Error: {e}")
            return False


if __name__ == "__main__":
    client = ActiveMQClient(username='admin', password='admin')

    destination = '/queue/myQueue'  # Replace with the desired destination
    message = 'Hello, ActiveMQ!'

    if client.send_message(destination, message):
        print(f"Message sent to {destination}: {message}")
    else:
        print("Failed to send the message.")
