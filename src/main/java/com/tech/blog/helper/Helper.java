package com.tech.blog.helper;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;

public class Helper {

    // Delete File
    public static boolean deleteFile(String path) {
        boolean isDeleted = false;
        try {
            File file = new File(path);
            isDeleted = file.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isDeleted;
    }

    // Save File
    public static boolean saveFile(InputStream is, String path) {
        boolean isSaved = false;
        try (FileOutputStream fos = new FileOutputStream(path)) {  // Auto-close
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = is.read(buffer)) != -1) {
                fos.write(buffer, 0, bytesRead);
            }
            isSaved = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isSaved;
    }
}
