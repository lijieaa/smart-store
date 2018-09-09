package com.jpm.common.advice;

import com.jpm.common.anno.advice.NoRslt;
import com.jpm.common.config.GlobalConfig;
import com.jpm.common.entity.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

/**
 * @description: 封装全局响应对象
 * @author: 李杰
 * @create: 2018-08-08 14:49
 **/
@ControllerAdvice
public class ResponseAdvice implements ResponseBodyAdvice {
    @Autowired
    GlobalConfig globalConfig;

    public boolean supports(MethodParameter returnType, Class converterType) {
        if(returnType.hasMethodAnnotation(NoRslt.class)){
            return false;
        }else if(returnType.getMethod().getName().equals("uiConfiguration")){ //swaggerui
            return false;
        }else if(returnType.getMethod().getName().equals("swaggerResources")){//swaggerui
            return false;
        }else if(returnType.getMethod().getName().equals("getDocumentation")){//swaggerui
            return false;
        }else{
            return true;
        }

    }

    public Object beforeBodyWrite(Object body, MethodParameter returnType, MediaType selectedContentType, Class selectedConverterType, ServerHttpRequest request, ServerHttpResponse response) {
        return new ResultEntity(0, globalConfig.getErrmsg().get("0"),body);
    }
}
