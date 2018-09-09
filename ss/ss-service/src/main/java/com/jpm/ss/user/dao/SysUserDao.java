package com.jpm.ss.user.dao;

import com.jpm.common.dao.CrudDao;
import org.apache.ibatis.annotations.Param;
import com.jpm.ss.user.entity.SysUserEntity;

/**
 * 用户管理DAO接口
 *
 * @author 李杰
 * @version 2018-09-08
 */
public interface SysUserDao extends CrudDao<SysUserEntity, String> {
    public SysUserEntity selectUsername(@Param("username") String username, @Param("id") String id);

    public SysUserEntity selectPhone(@Param("phone") String phone, @Param("id") String id);

    /**
     * 登录时使用
     * @param phone
     * @return
     */
    public SysUserEntity selectTel(String phone);
}
