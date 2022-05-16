#!/usr/bin/env python

import asyncio
import datetime
import random
import websockets

async def time(websocket, path):
    while True:
        # now = datetime.datetime.utcnow().isoformat() + 'Z'
        # await websocket.send(now)
        number1 = random.randint(10, 100)
        await websocket.send("{}".format(number1))
        await asyncio.sleep(random.random() * 3)

        pong = await websocket.recv()
        print("< {}".format(pong))

start_server = websockets.serve(time, '127.0.0.1', 5678)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()