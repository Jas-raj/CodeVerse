package com.tech.blog.entities;

import java.sql.Timestamp;

public class Post {

    private int pid;
    private String pTitle;
    private String pContent;
    private String pCode;
    private String pPic;
    private Timestamp pDate;
    private int catId;
    private int userid;

    public Post() {
    }

    public Post(int pid, String pTitle, String pContent, String pCode, String pPic, Timestamp pDate, int catId, int userid) {
        this.pid = pid;
        this.pTitle = pTitle;
        this.pContent = pContent;
        this.pCode = pCode;
        this.pPic = pPic;
        this.pDate = pDate;
        this.catId = catId;
        this.userid = userid;
    }

    public Post(String pTitle, String pContent, String pCode, String pPic, Timestamp pDate, int catId, int userid) {
        this.pTitle = pTitle;
        this.pContent = pContent;
        this.pCode = pCode;
        this.pPic = pPic;
        this.pDate = pDate;
        this.catId = catId;
        this.userid = userid;
    }

    public Post(int pid, String pTitle, String pContent) {
        this.pid = pid;
        this.pTitle = pTitle;
        this.pContent = pContent;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public String getpTitle() {
        return pTitle;
    }

    public void setpTitle(String pTitle) {
        this.pTitle = pTitle;
    }

    public String getpContent() {
        return pContent;
    }

    public void setpContent(String pContent) {
        this.pContent = pContent;
    }

    public String getpCode() {
        return pCode;
    }

    public void setpCode(String pCode) {
        this.pCode = pCode;
    }

    public String getpPic() {
        return pPic;
    }

    public void setpPic(String pPic) {
        this.pPic = pPic;
    }

    public Timestamp getpDate() {
        return pDate;
    }

    public void setpDate(Timestamp pDate) {
        this.pDate = pDate;
    }

    public int getCatId() {
        return catId;
    }

    public void setCatId(int catId) {
        this.catId = catId;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getFormattedContent() {
        if (this.pContent == null || this.pContent.trim().isEmpty()) {
            return "";
        }

        // Step 1: Trim overall content
        String content = this.pContent.trim();

        // Step 2: Escape HTML for safety
        content = content
                .replace("&", "&amp;")
                .replace("<", "&lt;")
                .replace(">", "&gt;");

        return content;
    }

    public String getFormattedCode() {
    if (this.pCode == null || this.pCode.trim().isEmpty()) {
        return "";
    }

    return this.pCode
        .replace("&", "&amp;")
        .replace("<", "&lt;")
        .replace(">", "&gt;");
}

}
