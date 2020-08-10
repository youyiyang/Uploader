package com.maskkk.log;

import org.apache.logging.log4j.*;

public class Log4jDemo {
    static Logger logger = LogManager.getLogger(Log4jDemo.class.getName());
    public static void main(String[] args) {
        System.out.println("=> Hello Log4jDemo...");
        logger.trace("trace level");
        logger.debug("debug level");
        logger.info("info level");
        logger.warn("warn level");
        logger.error("error level");
        logger.fatal("fatal level");
    }
}