package com.jpm.ss.user.service;

import java.util.List;
import java.util.Map;

import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import com.jpm.common.service.CrudService;
import com.jpm.ss.user.entity.SysUserEntity;
import com.jpm.ss.user.dao.SysUserDao;

/**
 * 用户管理Service
 *
 * @author 李杰
 * @version 2018-09-08
 */
@Service
@Transactional(readOnly = true)
public class SysUserService extends CrudService<SysUserDao, SysUserEntity, String> {

    @Autowired
    SysUserDao sysUserDao;

    @Override
    public SysUserEntity find(String id) {
        return super.find(id);
    }

    @Override
    public SysUserEntity find(SysUserEntity entity) {
        return super.find(entity);
    }

    @Transactional(readOnly = false)
    @Override
    public int add(SysUserEntity entity) {
        return super.add(entity);
    }

    @Transactional(readOnly = false)
    @Override
    public int update(SysUserEntity entity) {
        return super.update(entity);
    }

    @Transactional(readOnly = false)
    @Override
    public int remove(String[] ids) {
        return super.remove(ids);
    }

    @Override
    public PageInfo findPage(Integer page, Integer rows, Map data) {
        return super.findPage(page, rows, data);
    }

    @Override
    public PageInfo findJgGridPage(Map data) {
        return super.findJgGridPage(data);
    }

    @Override
    public List<SysUserEntity> findAll(Map data) {
        return super.findAll(data);
    }

    public SysUserEntity findByUsername(String username, String id) {
        return sysUserDao.selectUsername(username, id);
    }

    public SysUserEntity findByPhone(String phone, String id) {
        return sysUserDao.selectPhone(phone, id);
    }

    /**
     * 登录时使用
     *
     * @param phone
     * @return
     */
    public SysUserEntity findTel(String phone) {
        return dao.selectTel(phone);
    }
}