#!/usr/bin/env python3

from log import MNavLogger, SecType, SecStatus

#Get reference to manvLogger
logger = MNavLogger("mnavLogger")

# Write messages with all different types of levels
logger.diagDebug("54545467", "Test Message")
logger.diagInfo("54545467", "Test Message")
logger.diagWarn("54545467", "Test Message")
logger.diagError("54545467", "Test Message")
logger.diagCrit("54545467", "Test Message")


logger.secInfo("54545467", SecType.ADMN, SecStatus.PASS, "Test Message")
logger.secWarn("54545467", SecType.ADMN, SecStatus.PASS, "Test Message")
logger.secError("54545467", SecType.ADMN, SecStatus.PASS, "Test Message")
logger.secCrit("54545467", SecType.ADMN, SecStatus.PASS, "Test Message")
