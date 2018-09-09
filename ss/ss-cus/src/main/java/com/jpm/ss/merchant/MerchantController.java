package com.jpm.ss.merchant;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("merchant")
public class MerchantController {

    @RequestMapping(method = RequestMethod.GET,value = "list")
    public String list(){
        return "list";
    }
}
