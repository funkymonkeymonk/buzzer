#!/usr/bin/env python3
import time, os
from fastapi import FastAPI

isTest = False
if os.getenv('PYTHON_ENV') == "test":
    isTest = True


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
        self.relayOne.on()


    def off(self):
        print("Relay off")
        if self.isTest:
            return
        self.relayOne.off()

app = FastAPI()
relay = Relay(isTest)

@app.get("/buzzer")
def read_root():
    # Toggle channel.
    relay.on()
    # Pause.
    time.sleep(5)
    relay.off()
    return {}
