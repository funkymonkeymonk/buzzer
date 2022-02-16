import time, os

class Relay:
    def __init__(self, isTest):
        self.isTest = isTest

        if self.isTest:
            return

        import automationhat
        self.relayOne = automationhat.relay.one
        time.sleep(0.1) # Short pause after ads1015 class creation recommended

    def on(self):
        print ("Relay on")

        if self.isTest:
            return

        try:
            self.relayOne.on()
        except Exception as e:
            # TODO: Return this exception in the body and abort
            print("Exception raised")


    def off(self):
        print("Relay off")

        if self.isTest:
            return

        self.relayOne.off()

isTest = False
if os.getenv('PYTHON_ENV') == "test":
    isTest = True
relay = Relay(isTest)

def handle(req):
    """handle a request to the function
    Args:
        req (str): request body
    """
    # Toggle channel.
    try:
        relay.on()
        time.sleep(5)
        relay.off()
    except Exception as e:
        return str(e)

    return "Buzzed them in!"

