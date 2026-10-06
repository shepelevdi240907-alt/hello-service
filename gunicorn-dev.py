import os
import signal


def worker_int(worker):
    os.kill(os.getpid(), signal.SIGTERM)
