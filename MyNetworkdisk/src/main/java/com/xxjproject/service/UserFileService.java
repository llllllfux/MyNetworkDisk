package com.xxjproject.service;

import com.xxjproject.dao.UserFileDao;
import com.xxjproject.domain.UserFile;

import java.util.List;

/**
 * @author xuxingjun
 * @data 2020/12/16  -  21:47
 */
public interface UserFileService {
    List<UserFile> getUserFile(int userID);

    int insertUserFile(UserFile userFile);

    UserFile getUserFileByFileID(int fileID);

    List<UserFile> getUserImgFile(int userID);

    List<UserFile> getUserDocumentFile(int userID);

    List<UserFile> getUserVideoFile(int userID);

    List<UserFile> getUserMusicFile(int userID);

    List<UserFile> getUserCompressedFile(int userID);

    List<UserFile> getUserOtherFile(int userID);

    int modifyFilenameByFileID(String newFilename,int fileID);

    int deleteUserFileToRecycleBinByFileID(int fileID);
}
