package com.xxjproject.domain;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * @author xuxingjun
 * @data 2021/1/22  -  17:23
 */
public class FileUploadThread extends Thread {


    private final Object lock = new Object();
    private boolean pause = false;
    private OutputStream os;
    private InputStream is;
    private int role;

    public FileUploadThread() {
    }

    public FileUploadThread(InputStream is, OutputStream os, int role) {
        this.is = is;
        this.os = os;
        this.role = role;
    }

    public void pauseThread(){
        pause = true;
    }

    public void resumeThread(){
        pause =false;
        synchronized (lock){
            lock.notify();
        }
    }
    private void onPause() {
        synchronized (lock) {
            try {
                lock.wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }



    @Override
    public void run() {
        super.run();
        if (role == 1) {
            byte[] buff = new byte[1024];
            int len = 0;
            try {
                while ((len = is.read(buff)) > 0) {
                    while (pause){
                        onPause();
                    }
                        os.write(buff, 0, len);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (is != null) {
                try {
                    is.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (is != null) {
                try {
                    os.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
//            file.transferTo(uploadFile);
        else {
            //对非会员限速,限制在60kb左右
//            InputStream is = file.getInputStream();
//            FileOutputStream os = new FileOutputStream(uploadFile);
            byte[] buff = new byte[1024];
            int len = 0;
            try {
                while ((len = is.read(buff)) > 0) {
                    while (pause){
                        onPause();
                    }
                    os.write(buff, 0, len);
                    try {
                        Thread.sleep(17);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            if (is != null) {
                try {
                    is.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (is != null) {
                try {
                    os.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
