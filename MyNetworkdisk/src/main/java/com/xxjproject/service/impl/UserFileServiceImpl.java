package com.xxjproject.service.impl;

import com.xxjproject.dao.UserFileDao;
import com.xxjproject.domain.UserFile;
import com.xxjproject.service.UserFileService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author xuxingjun
 * @data 2020/12/16  -  21:47
 */
@Service
public class UserFileServiceImpl implements UserFileService {
    @Autowired
    private UserFileDao userFileDao;

    @Override
    public int insertUserFile(UserFile userFile) {
        return userFileDao.insertUserFile(userFile);
    }

    @Override
    public List<UserFile> getUserImgFile(int userID) {
        return userFileDao.selectUserImgFileByUserID(userID);
    }

    @Override
    public UserFile getUserFileByFileID(int fileID) {
        return userFileDao.selectUserFileByFileID(fileID);
    }

    @Override
    public List<UserFile> getUserFile(int userID) {
        return userFileDao.selectUserFileByUserID(userID);
    }

    @Override
    public List<UserFile> getUserDocumentFile(int userID) {
        return userFileDao.selectUserDocumentFileByUserID(userID);
    }

    @Override
    public List<UserFile> getUserVideoFile(int userID) {
        return userFileDao.selectUserVideoFileByUserID(userID);
    }

    @Override
    public List<UserFile> getUserMusicFile(int userID) {
        return userFileDao.selectUserMusicFileByUserID(userID);
    }

    @Override
    public List<UserFile> getUserCompressedFile(int userID) {
        return userFileDao.selectUserCompressedFileByUserID(userID);
    }

    @Override
    public List<UserFile> getUserOtherFile(int userID) {
        return userFileDao.selectUserOtherFileByUserID(userID);
    }

    @Override
    public int modifyFilenameByFileID(String newFilename,int fileID) {
        return userFileDao.updateFilenameByFileID(newFilename,fileID);
    }

    @Override
    public int deleteUserFileToRecycleBinByFileID(int fileID) {
        return userFileDao.deleteUserFileByFileID(fileID);
    }

}
