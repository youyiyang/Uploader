package com.maskkk.controller;
//Import log4j classes.
import com.maskkk.controller.Bar;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.apache.logging.log4j.LogManager;
@Controller
@RequestMapping("/spring")
public class TestLog {

 // Define a static logger variable so that it references the
 // Logger instance named "MyApp".
 private static final Logger logger = LogManager.getLogger(TestLog.class);
@RequestMapping("/testlog")
 public static void main(final String... args) {

     // Set up a simple configuration that logs on the console.

     logger.trace("Entering application.");
     Bar bar = new Bar();
     if (!bar.doIt()) {
         logger.error("Didn't do it.");
     }
     logger.trace("Exiting application.");
 }
}