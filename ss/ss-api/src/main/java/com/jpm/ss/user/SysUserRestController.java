package com.jpm.ss.user;

import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;
import java.util.Map;

import com.jpm.common.entity.JqGridEntity;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.security.access.prepost.PreAuthorize;
import com.jpm.common.anno.advice.NoRslt;
import com.jpm.ss.user.entity.SysUserEntity;
import com.jpm.ss.user.service.SysUserService;


/**
 * 用户管理Controller
 *
 * @author 李杰
 * @version 2018-09-08
 */
@Api(value = "用户管理", description = "用户管理")
@RestController
@RequestMapping("api/user/sys_user")
public class SysUserRestController {

    @Autowired
    SysUserService sysUserService;

    @ApiOperation("根据id获取用户")
    @PreAuthorize("hasAuthority('sys_user:view')")
    @RequestMapping(method = RequestMethod.GET, value = "{id}")
    public SysUserEntity get(@PathVariable(value = "id") String id) {
        SysUserEntity entiy = sysUserService.find(id);
        return entiy;
    }

    @ApiOperation("普通分页")
    @PreAuthorize("hasAuthority('sys_user:view')")
    @RequestMapping(method = RequestMethod.GET, value = "page")
    public PageInfo page(@RequestParam Integer page
            , @RequestParam Integer rows
            , @RequestParam(required = false) Map data) {
        PageInfo pageInfo = sysUserService.findPage(page, rows, data);
        return pageInfo;
    }


    /**
     * jggrid表格分页
     *
     * @param data
     * @return
     */
    @ApiOperation("jggrid表格分页")
    @PreAuthorize("hasAuthority('sys_user:view')")
    @RequestMapping(method = RequestMethod.GET, value = "jggrid")
    public JqGridEntity<SysUserEntity> jqGrid(@RequestParam Map data) {
        PageInfo pageInfo = sysUserService.findJgGridPage(data);
        JqGridEntity<SysUserEntity> gridEntity = new JqGridEntity<SysUserEntity>(pageInfo.getPageNum(), pageInfo.getPages(), pageInfo.getTotal(), pageInfo.getList());
        return gridEntity;
    }

    @ApiOperation("查询所有用户")
    @PreAuthorize("hasAuthority('sys_user:view')")
    @RequestMapping(method = RequestMethod.GET, value = "list")
    public List<SysUserEntity> list(@RequestParam(required = false) Map data) {
        List<SysUserEntity> list = sysUserService.findAll(data);
        return list;
    }

    @ApiOperation("创建用户")
    @PreAuthorize("hasAuthority('sys_user:add')")
    @RequestMapping(method = RequestMethod.POST)
    public int save(@RequestBody @Valid @ApiParam(name = "用户", value = "传入json格式", required = true) SysUserEntity entity) {

        return sysUserService.add(entity);
    }

    @ApiOperation("修改用户")
    @PreAuthorize("hasAuthority('sys_user:edit')")
    @RequestMapping(method = RequestMethod.PUT)
    public int update(@RequestBody @Valid @ApiParam(name = "用户", value = "传入json格式", required = true) SysUserEntity entity) {

        return sysUserService.update(entity);
    }

    @ApiOperation("删除用户")
    @PreAuthorize("hasAuthority('sys_user:delete')")
    @RequestMapping(method = RequestMethod.DELETE, value = "{id}")
    public int delete(@PathVariable(value = "id") @ApiParam(name = "多个id用,分隔", value = "id字符串", required = true) String[] ids) {

        return sysUserService.remove(ids);
    }


    @ApiOperation("根据用户账号查询")
    @PreAuthorize("hasAuthority('sys_user:view')")
    @NoRslt
    @RequestMapping(method = RequestMethod.GET, value = "username")
    public boolean getUsername(@RequestParam String username, @RequestParam(required = false)
            String id) {
        return (sysUserService.findByUsername(username, id) != null) ? false : true;
    }

    @ApiOperation("根据用户电话查询")
    @PreAuthorize("hasAuthority('sys_user:view')")
    @NoRslt
    @RequestMapping(method = RequestMethod.GET, value = "phone")
    public boolean getPhone(@RequestParam String phone, @RequestParam(required = false)
            String id) {
        return (sysUserService.findByPhone(phone, id) != null) ? false : true;
    }
}