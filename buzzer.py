#!/usr/bin/env python3

import time
import automationhat
from fastapi import FastAPI

time.sleep(0.1) # Short pause after ads1015 class creation recommended

app = FastAPI()

@app.get("/")
def read_root():
    # Toggle channel.
    automationhat.relay.one.on()
    # Pause.
    time.sleep(5)
    automationhat.relay.one.off()
    print("turn off")
    return {"Hello": "World"}
