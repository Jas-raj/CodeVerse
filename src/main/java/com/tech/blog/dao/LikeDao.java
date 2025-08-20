package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class LikeDao {

    Connection con;

    public LikeDao(Connection con) {
        this.con = con;
    }

    public boolean inserLike(int pid, int uid) {
        boolean f = false;
        try {
            String q = "insert into likes(pid, uid) values (?,?)";
            PreparedStatement p = this.con.prepareStatement(q);
            p.setInt(1, pid);
            p.setInt(2, uid);
            p.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public int countLikeOnPost(int pid) {
        int count = 0;
        try {
            String sql = "Select count(*) from likes where pid = ?";
            PreparedStatement p = this.con.prepareStatement(sql);
            p.setInt(1, pid);
            ResultSet set = p.executeQuery();
            if (set.next()) {
                count = set.getInt("count(*)");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return count;
    }

    public boolean isLikedByUser(int pid, int uid) {
        boolean f = false;
        try {
            String q = "Select * from likes where pid = ? and uid = ?";
            PreparedStatement p = this.con.prepareStatement(q);
            p.setInt(1, pid);
            p.setInt(2, uid);
            ResultSet set = p.executeQuery();
            if (set.next()) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public boolean deleteLike(int pid, int uid) {
        boolean f = false;
        try {
            PreparedStatement p = this.con.prepareStatement("DELETE FROM likes WHERE pid=? AND uid=?");
            p.setInt(1, pid);
            p.setInt(2, uid);
            p.executeUpdate();
            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public boolean isPostLikedByUser(int pid, int uid) {
        boolean liked = false;
        try {
            String q = "SELECT 1 FROM likes WHERE pid=? AND uid=?";
            PreparedStatement ps = this.con.prepareStatement(q);
            ps.setInt(1, pid);
            ps.setInt(2, uid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                liked = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return liked;
    }
}
