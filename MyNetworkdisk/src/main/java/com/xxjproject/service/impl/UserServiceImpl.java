package com.xxjproject.service.impl;

import com.xxjproject.dao.UserDao;
import com.xxjproject.domain.User;
import com.xxjproject.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author xuxingjun
 * @data 2020/12/12  -  10:49
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;
    @Override
    public int userRegister(User user) {
        int num = userDao.insertUser(user);
        return num;
    }

    @Override
    public User userLoginByUsername(String username) {
        User user = userDao.selectUserByUsername(username);
        return user;
    }

    @Override
    public User getUserByUsername(String username) {
        User user = userDao.selectUserByUsername(username);
        return user;
    }

    @Override
    public User userRegisterCheckEmailIsExist(String email) {
        User user = userDao.selectUserByEmail(email);
        return user;
    }

    @Override
    public User userRegisterCheckUsernameIsExist(String username) {
        User user = userDao.selectUserByUsername(username);
        return user;
    }

    @Override
    public User userLoginByEmail(String email) {
        User user = userDao.selectUserByEmail(email);
        return user;
    }

    @Override
    public int modifyPasswordByUsername(String username,String password) {
        return userDao.updatePasswordByUsername(username,password);
    }

    @Override
    public void modifyFileTotalSizeByUserID(int userID, int newSize) {
        userDao.updateFileTotalSizeByUserID(userID,newSize);
    }

    @Override
    public void grantUserVIPByUsername(String username) {
        userDao.updateUserRoleByUsername(username);
    }

    @Override
    public User getUserByUserID(int userID) {
        return userDao.selectUserByUserID(userID);
    }
}


