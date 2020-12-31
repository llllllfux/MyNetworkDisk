package com.xxjproject.vo;

import javax.validation.constraints.Pattern;

/**
 * @author xuxingjun
 * @data 2020/12/13  -  21:21
 */
public class UserRegisterData {

    @Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)",
            message = "（后端校验）用户名必须是6-16位数字，字母或者_-")
    private String registerUsername;

    @Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)",
            message = "（后端校验密码）密码格式错误")
    private String registerPassword;

    @Pattern(regexp = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$",
            message = "（后端校验）邮箱格式不正确")
    private String registerEmail;

    public String getRegisterUsername() {
        return registerUsername;
    }

    public void setRegisterUsername(String registerUsername) {
        this.registerUsername = registerUsername;
    }

    public String getRegisterPassword() {
        return registerPassword;
    }

    public void setRegisterPassword(String registerPassword) {
        this.registerPassword = registerPassword;
    }

    public String getRegisterEmail() {
        return registerEmail;
    }

    public void setRegisterEmail(String registerEmail) {
        this.registerEmail = registerEmail;
    }

    @Override
    public String toString() {
        return "UserRegisterData{" +
                "registerUsername='" + registerUsername + '\'' +
                ", registerPassword='" + registerPassword + '\'' +
                ", registerEmail='" + registerEmail + '\'' +
                '}';
    }
}
