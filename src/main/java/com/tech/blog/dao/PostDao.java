package com.tech.blog.dao;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class PostDao {

    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    public ArrayList<Category> getAllCategories() {

        ArrayList<Category> list = new ArrayList<>();

        try {
            String q = "Select * from categories";
            Statement st = con.createStatement();
            ResultSet set = st.executeQuery(q);
            while (set.next()) {
                int cid = set.getInt("cid");
                String name = set.getString("name");
                String description = set.getString("description");
                Category c;
                c = new Category(cid, name, description);
                list.add(c);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;

    }

    public boolean savePost(Post p) {
        boolean f = false;
        try {
            String q = "insert into posts(pTitle, pContent, pCode, pPic, catId, userid) values (?,?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(q);
            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpPic());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6, p.getUserid());

            // 🔥 THIS LINE IS MISSING IN YOUR CODE!
            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                f = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    public List<Post> getAllPosts() {

        List<Post> list = new ArrayList<>();

        //ftech for the Post
        try {
            PreparedStatement p = con.prepareStatement("SELECT * FROM posts ORDER BY pid DESC");
            ResultSet set = p.executeQuery();
            while (set.next()) {
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int catId = set.getInt("catId");
                int userid = set.getInt("userid");

                Post ppost = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userid);

                list.add(ppost);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Post> getPostByCatId(int catId) {
        List<Post> list = new ArrayList<>();

        try {
            PreparedStatement p = con.prepareStatement("SELECT * FROM posts WHERE catId = ?");
            p.setInt(1, catId);
            ResultSet set = p.executeQuery();
            while (set.next()) {
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int userid = set.getInt("userid");

                Post ppost = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userid);
                list.add(ppost);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Post getPostByPostId(int postid) {
        Post post = null;
        try {
            String query = "SELECT * FROM posts WHERE pid=?";
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setInt(1, postid);
            ResultSet set = pstmt.executeQuery();

            if (set.next()) {
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int catId = set.getInt("catId");
                int userid = set.getInt("userid");

                // ✅ now pid is included
                post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userid);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return post;
    }

    public List<Post> getAllPostsForCardView() {
        List<Post> list = new ArrayList<>();
        try {
            String q = "SELECT * FROM posts ORDER BY pid DESC";
            PreparedStatement ps = con.prepareStatement(q);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Post post = new Post();
                post.setPid(rs.getInt("pid"));
                post.setpTitle(rs.getString("pTitle"));
                post.setpContent(rs.getString("pContent"));
                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
