package com.xxjproject.service;

import com.xxjproject.domain.User;

/**
 * @author xuxingjun
 * @data 2020/12/12  -  10:45
 */
public interface UserService {

    int userRegister(User user);
    User userLoginByUsername(String username);
    User userLoginByEmail(String mail);
    User userRegisterCheckEmailIsExist(String email);
    User userRegisterCheckUsernameIsExist(String username);
    User getUserByUsername(String username);
    User getUserByUserID(int userID);

    int modifyPasswordByUsername(String username,String password);

    void modifyFileTotalSizeByUserID(int userID, int newSize);

    void grantUserVIPByUsername(String username);
}
