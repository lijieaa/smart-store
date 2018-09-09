package com.jpm.common.controller;

import com.jpm.common.anno.advice.NoRslt;
import com.jpm.common.config.GlobalConfig;
import com.jpm.common.entity.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.LocaleResolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

/**
 * @description: 通用controller
 * @author: 李杰
 * @create: 2018-08-20 16:10
 **/
@Controller
public class CommonController {

    @RequestMapping("login")
    public String login() {
        return "login";
    }

    @Autowired
    LocaleResolver localeResolver;

    @Autowired
    GlobalConfig globalConfig;

    /**
     * 多语言切换
     * @param request
     * @param response
     * @param lang
     * @return
     */
    @RequestMapping("/change_lang")
    @ResponseBody
    @NoRslt
    public ResultEntity changeLanauage(HttpServletRequest request
            , HttpServletResponse response
            , String lang){
        String[] split = lang.split("_");
        localeResolver.setLocale(request,response,new Locale(split[0],split[1]));

        return new ResultEntity(0, globalConfig.getErrmsg().get("0"),"切换语言成功！");
    }
}
