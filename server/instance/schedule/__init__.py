from .controllers import module, GetTimeTableOfCertainClass, GetWholeTimeTable
import threading
threading.Timer(1, GetWholeTimeTable).start()
