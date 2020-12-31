package com.xxjproject.vo;

import javax.validation.constraints.Pattern;

/**
 * @author xuxingjun
 * @data 2020/12/30  -  19:47
 */
public class ModifyPasswordCheck {

    @Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)",
            message = "（后端校验）用户名必须是6-16位数字，字母或者_-")
    private String username;
    @Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)",
            message = "（后端校验密码）密码格式错误")
    private String oldPassword;
    @Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)",
            message = "（后端校验密码）密码格式错误")
    private String newPassword;
    @Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)",
            message = "（后端校验密码）密码格式错误")
    private String confirmPassword;




    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getOldPassword() {
        return oldPassword;
    }

    public void setOldPassword(String oldPassword) {
        this.oldPassword = oldPassword;
    }

    public String getNewPassword() {
        return newPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }
}
