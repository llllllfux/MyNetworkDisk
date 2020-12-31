package com.xxjproject.service.impl;

import com.xxjproject.dao.UserFileDeleteDao;
import com.xxjproject.domain.UserFileDelete;
import com.xxjproject.service.UserFileDeleteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author xuxingjun
 * @data 2020/12/20  -  14:29
 */
@Service
public class UserFileDeleteServiceImpl implements UserFileDeleteService {

    @Autowired
    private UserFileDeleteDao userFileDeleteDao;

    @Override
    public int addDeleteFile(UserFileDelete userFileDelete) {
        return userFileDeleteDao.insertUserDeleteFile(userFileDelete);
    }

    @Override
    public List<UserFileDelete> getUserDeleteFileByUserID(Integer userID) {
        return userFileDeleteDao.selectUserDeleteFileByUserID(userID);
    }

    @Override
    public UserFileDelete getUserDeleteFileByFileID(int fileID) {
        return userFileDeleteDao.selectUserDeleteFileByFileID(fileID);
    }

    @Override
    public int deleteUserFileFromRecycleBin(int fileID) {
        return userFileDeleteDao.deleteUserFileByFileID(fileID);
    }

    @Override
    public int clearUserFileByUserID(Integer userID) {
        return userFileDeleteDao.deleteAllFileByUserID(userID);
    }

//    @Override
//    public List<String> getFilenameByUserID(Integer userID) {
//        return userFileDeleteDao.selectFilenameByUserID(userID);
//    }
}
