import logging
import logging.config
import inspect
from enum import Enum
import yaml

class SecType(Enum):
    ADMN = 1
    AUTN = 2
    AUTZ = 3
    FILS = 4
    INPV = 5
    NETW = 6
    PROC = 7
    PTSL = 8
    SWUP = 9
    MISC = 10

class SecStatus(Enum):
    PASS = 1
    FAIL = 2
    DEFR = 3

class MnavFormatter(logging.Formatter):
    """A custom formatter for log records."""

    def __init__(self, fmt=None, datefmt=None, style='%'):
        super().__init__(fmt, datefmt, style)

    def format(self, record):
        # print(self.__dict__)
        if hasattr(record, 'evt'):
            fmt = '%(levelname)s %(filename)s:%(lineno)d [%(funcName)s] (%(sid)s) %(message)s %(evt)s'
        else:
            fmt = '%(levelname)s %(filename)s:%(lineno)d [%(funcName)s] (%(sid)s) %(message)s'
        self._style._fmt = fmt
        return super().format(record)

class MNavLogger:

    with open('./config/py_logging_config.yaml', 'r') as f:
        config = yaml.safe_load(f.read())
        logging.config.dictConfig(config)

    def __init__(self, loggerName):
        self.logger = logging.getLogger(loggerName)
       
    def diagDebug(self, sessionId: str, message: str): self.__diagLog(logging.DEBUG, self.__getLocInfo(), sessionId, message)
       
    def diagInfo(self, sessionId: str, message: str): self.__diagLog(logging.INFO, self.__getLocInfo(), sessionId, message)
       
    def diagWarn(self, sessionId: str, message: str): self.__diagLog(logging.WARN, self.__getLocInfo(), sessionId, message)
       
    def diagError(self, sessionId: str, message: str): self.__diagLog(logging.ERROR, self.__getLocInfo(), sessionId, message)
       
    def diagCrit(self, sessionId: str, message: str): self.__diagLog(logging.CRITICAL, self.__getLocInfo(), sessionId, message)
       
    def secInfo(self, sessionId: str, type: SecType, status: SecStatus, message: str): self.__secLog(logging.INFO, self.__getLocInfo(), sessionId, type, status, message)
        
    def secWarn(self, sessionId: str, type: SecType, status: SecStatus, message: str): self.__secLog(logging.WARN, self.__getLocInfo(), sessionId, type, status, message)
        
    def secError(self, sessionId: str, type: SecType, status: SecStatus, message: str): self.__secLog(logging.ERROR, self.__getLocInfo(), sessionId, type, status, message)
        
    def secCrit(self, sessionId: str, type: SecType, status: SecStatus, message: str): self.__secLog(logging.CRITICAL, self.__getLocInfo(), sessionId, type, status, message)
        
    def __diagLog(self, level: str, location: str, sessionId: str, message: str):
        extra = {'sid': sessionId}        
        self.__log(level, message, location, extra)

    def __secLog(self, level: str, location: str, sessionId: str, type: SecType, status: SecStatus, message: str):
        extra = {"evt": type.name, "sts": status.name, "sid": sessionId}
        self.__log(level, message, location, extra) 

    # Handle a log message with location information in the metadata
    def __log(self, level, msg, location, extra):
        record = self.logger.makeRecord(
            name='mnav_logger',
            level=level,
            fn=location['filename'],
            lno=location['line_number'],
            msg=msg,
            args=(),
            exc_info=None,
            func=location['function_name'],
            extra=extra
        )
        self.logger.handle(record)
    
    def __getLocInfo(self):
        frame, filename, line_number, function_name, lines, index = inspect.stack()[2]
        location_info = {"filename": filename, "line_number": line_number, "function_name": function_name}
        return location_info

