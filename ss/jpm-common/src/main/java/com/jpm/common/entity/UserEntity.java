package com.jpm.common.entity;

import java.io.Serializable;

/**
 * @description: 系统用户
 * @author: 李杰
 * @create: 2018-07-30 14:21
 **/
public class UserEntity<T,PK extends Serializable> extends DataEntity<T,PK> {
    public UserEntity() {
    }

    public UserEntity(PK id) {
        super(id);
    }
}
