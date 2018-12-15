from .controllers import module, TimeTable
import threading
threading.Timer(1, TimeTable().GetWholeTimeTable).start()
