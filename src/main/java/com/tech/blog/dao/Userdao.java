package com.tech.blog.dao;

import com.tech.blog.entities.User;
import java.sql.*;

public class Userdao {

    private final Connection con;

    public Userdao(Connection con) {
        this.con = con;
    }

    //methos to insert user to database
    public boolean saveUser(User user) {
        boolean f = false;
        try {
            //user---> Databse

            String query = "Insert into users(name, email, password, gender, about) value(?,?,?,?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());

            pstmt.executeUpdate();
            f = true;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return f;

    }

    //get user by useremail and userpassword
    public User getuserByEmailAndPassword(String email, String password) {
        User user = null;

        try {
            String query = "SELECT * FROM users WHERE email = ? AND password = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, email.trim());
            pstmt.setString(2, password.trim());

            ResultSet set = pstmt.executeQuery();

            if (set.next()) {
                user = new User();
                user.setId(set.getInt("id"));
                user.setName(set.getString("name"));
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setDateTime(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    public boolean isEmailAlreadyRegistered(String email) {
        boolean exists = false;
        try {
            String query = "SELECT id FROM users WHERE email = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, email.trim());
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                exists = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return exists;
    }

    public boolean updateUser(User user) {
        boolean f = false;

        try {
            String query = "Update users set name=?, email=?, password=?, gender=?, about=?, profile=? where id=?";
            PreparedStatement pstmt = con.prepareStatement(query);

            pstmt.setString(1, user.getName());

            pstmt.setString(2, user.getEmail());

            pstmt.setString(3, user.getPassword());

            pstmt.setString(4, user.getGender());

            pstmt.setString(5, user.getAbout());

            pstmt.setString(6, user.getProfile());

            pstmt.setInt(7, user.getId());

            pstmt.executeUpdate();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

    public User getUserByEmail(String email) {
        User user = null;
        try {
            String query = "SELECT * FROM users WHERE email=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setGender(rs.getString("gender"));
                user.setAbout(rs.getString("about"));
                user.setProfile(rs.getString("profile"));
                user.setDateTime(rs.getTimestamp("rdate"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public User getUserByUserId(int userId) {

        User user = null;
        try {
            PreparedStatement pstmt = this.con.prepareStatement("Select * from users where id=?");
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setGender(rs.getString("gender"));
                user.setAbout(rs.getString("about"));
                user.setProfile(rs.getString("profile"));
                user.setDateTime(rs.getTimestamp("rdate"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

}
