package com.jpm.ss;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class CommonController {

    @RequestMapping(method = RequestMethod.GET, value = "login")
    public String login() {
        return "login";
    }

    @RequestMapping(method = RequestMethod.GET, value = "index")
    public String index() {
        return "index";
    }
}
