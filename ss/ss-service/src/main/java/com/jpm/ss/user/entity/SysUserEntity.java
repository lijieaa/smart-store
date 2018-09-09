package com.jpm.ss.user.entity;

import com.jpm.common.entity.UserEntity;
import org.hibernate.validator.constraints.Length;
import com.jpm.common.entity.DataEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.HashSet;

/**
 * 用户管理Entity
 *
 * @author 李杰
 * @version 2018-09-08
 */
@ApiModel(value = "用户管理", description = "用户管理")
public class SysUserEntity extends UserEntity<SysUserEntity, String> implements UserDetails {

    private static final long serialVersionUID = 1L;
    @ApiModelProperty(value = "账号", name = "username")
    private String username;        // 账号
    @ApiModelProperty(value = "电话", name = "phone")
    private String phone;        // 电话
    @ApiModelProperty(value = "密码", name = "password")
    private String password;        // 密码
    @ApiModelProperty(value = "姓名", name = "nickName")
    private String nickName;        // 姓名
    @ApiModelProperty(value = "地址", name = "address")
    private String address;        // 地址
    @ApiModelProperty(value = "性别，0-男，1-女", name = "sex")
    private String sex;        // 性别，0-男，1-女
    @ApiModelProperty(value = "邮箱", name = "email")
    private String email;        // 邮箱

    public SysUserEntity() {
        super();
    }

    public SysUserEntity(String id) {
        super(id);
    }

    @Length(min = 0, max = 20, message = "账号长度必须介于 0 和 20 之间")
    public String getUsername() {
        return username;
    }

    public boolean isAccountNonExpired() {
        return true;
    }

    public boolean isAccountNonLocked() {
        return true;
    }

    public boolean isCredentialsNonExpired() {
        return true;
    }

    public boolean isEnabled() {
        return true;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Length(min = 0, max = 11, message = "电话长度必须介于 0 和 11 之间")
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Collection<? extends GrantedAuthority> getAuthorities() {
        Collection<? extends GrantedAuthority> authorities=new HashSet<SimpleGrantedAuthority>();
        return authorities;
    }

    @Length(min = 0, max = 100, message = "密码长度必须介于 0 和 100 之间")
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Length(min = 0, max = 50, message = "姓名长度必须介于 0 和 50 之间")
    public String getNickName() {
        return nickName;
    }

    public void setNickName(String nickName) {
        this.nickName = nickName;
    }

    @Length(min = 0, max = 100, message = "地址长度必须介于 0 和 100 之间")
    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Length(min = 0, max = 4, message = "性别，0-男，1-女长度必须介于 0 和 4 之间")
    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    @Length(min = 0, max = 50, message = "邮箱长度必须介于 0 和 50 之间")
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}