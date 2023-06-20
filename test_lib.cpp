#include "MNavLog.h"
// #include <iostream> // only for dev, printing to console

using namespace MNavLogger;

static MNavLogger::MNavLogger logger("AboutThisStealthService");

int main()
{
    //Security Logging Functions
    logger.secLow("5654sd55", SecType::AUTZ, SecStatus::PASS, "C++/Security/Info Message");
    // logger.secMed("978D875D", SecType::AUTN, SecStatus::FAIL, "C++/Security/Warn Message");      
    // logger.secHigh("978D875D", SecType::AUTN, SecStatus::FAIL, "C++/Security/Error Message");      
    // // logger.secCrit("978D875D", SecType::ADMN, SecStatus::FAIL, "C++/Security/Fatal Message"); //Often commented out because Fatal log4cxx events sent to rsyslog are "emergency" and printed to all terminals          

    // //Diagnostic Logging Macros
    // DIAG_TRACE(logger, "521585k5", "C++/Diagnostic/Info Message [from MACRO]");
    // DIAG_DEBUG(logger, "521585k5", "C++/Diagnostic/Info Message [from MACRO]");
    // DIAG_INFO(logger, "521585k5", "C++/Diagnostic/Info Message [from MACRO]");
    // DIAG_WARN(logger, "521585k5", "C++/Diagnostic/Info Message [from MACRO]");
    // DIAG_ERROR(logger, "521585k5", "C++/Diagnostic/Info Message [from MACRO]");
    // // DIAG_CRIT(logger, "521585k5", "C++/Diagnostic/Info Message [from MACRO]"); //Often commented out because Fatal log4cxx events sent to rsyslog are "emergency" and printed to all terminals     

    // //Diagnostic Logging Functions
    // if (logger.isEnabledTrace()){
    //     logger.diagTrace("5654sd55", "C++/Diagnostic/Trace Message");
    // }
    // if (logger.isEnabledDebug()){
    //     logger.diagDebug("5654sd55", "C++/Diagnostic/Debug Message");
    // }
    // if (logger.isEnabledInfo()){
    //     logger.diagInfo("5654sd55", "C++/Diagnostic/Info Message");
    // }
    // logger.diagWarn("978D875D", "C++/Diagnostic/Warn Message");      
    // logger.diagError("978D875D", "C++/Diagnostic/Error Message");      
    // // logger.diagCrit("978D875D", "C++/Diagnostic/Fatal Message")); //Often commented out because Fatal log4cxx events sent to rsyslog are "emergency" and printed to all terminals     

    // //Test when switching the ID and the message
    // DIAG_INFO(logger, "C++/Diagnostic/Info Message [from MACRO] with CID and message mistakenly swapped", "521585k5");

    // //Test using the left shift operator << to form the message
    // DIAG_INFO(logger, "521585k5", "C++/Diagnostic/Info Message" << " Formed using the left shift operator");
    // logger.diagInfo("5654sd55", MNAV_SS("C++/Diagnostic/Fatal Message " << 5 << " Formed using the left shift operator"));



    return 0;
}