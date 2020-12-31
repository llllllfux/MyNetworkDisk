package com.xxjproject.dao;

import com.xxjproject.domain.User;

/**
 * @author xuxingjun
 * @data 2020/12/11  -  20:02
 */
public interface UserDao {
    int insertUser(User user);
    User selectUserByUsername(String username);
    User selectUserByEmail(String Email);
    User selectUserByUserID(int userID);
    int updatePasswordByUsername(String username,String password);
    void updateFileTotalSizeByUserID(int userID, int newSize);
    void updateUserRoleByUsername(String username);
}
