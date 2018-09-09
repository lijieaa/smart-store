package com.jpm.ss.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;

/**
 * 用户管理Controller
 * @author 李杰
 * @version 2018-09-08
 */
@Controller
@RequestMapping("user/sys_user")
public class SysUserController {

    @PreAuthorize("hasAuthority('sys_user:view')")
    @RequestMapping(method = RequestMethod.GET, value = "list")
    public String list() {
        return "user/sys_user_list";
    }

    @PreAuthorize("hasAuthority('sys_user:add')")
    @RequestMapping(method = RequestMethod.GET, value = "add_form")
    public String add() {
        return "user/sys_user_form";
    }

    @PreAuthorize("hasAuthority('sys_user:edit')")
    @RequestMapping(method = RequestMethod.GET, value = "edit_form")
    public String edit() {
        return "user/sys_user_form";
    }

    @PreAuthorize("hasAuthority('sys_user:view')")
    @RequestMapping(method = RequestMethod.GET, value = "detail")
    public String detail() {
        return "user/sys_user_detail";
    }
}
