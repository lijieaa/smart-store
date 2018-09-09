package com.jpm.ss.config;


import com.jpm.ss.user.entity.SysUserEntity;
import com.jpm.ss.user.service.SysUserService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

@Component
public class MyUserDetailService implements UserDetailsService {

    private final Log logger = LogFactory.getLog(MyUserDetailService.class);


    @Autowired
    SysUserService userService;

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {

        SysUserEntity user = userService.findTel(s);

        if(user == null){
            throw new UsernameNotFoundException("用户名不存在！");
        }

        return user;
    }
}
