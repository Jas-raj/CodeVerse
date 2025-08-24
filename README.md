**CodeVerse**

A Java-based web based tech blog sharing application designed to demonstrate clean architecture and modular development with Servlets, JSP, and MySQL. This project focuses on implementing a scalable backend structure, separating concerns into multiple packages (dao, entities, servlets, helper) for maintainability.

**About the project**

CodeVerse is a Java full-stack blogging platform designed to share and read the latest technology updates worldwide. It features a clean blue-and-white UI with a structured navigation bar for easy access to Home, Contact, Sign Up, and Login pages. Users can explore blog previews and view full posts after logging in or signing up, with secure authentication and duplicate email checks in place. Once logged in, users can filter blogs by category, interact through likes, dislikes, and comments, and even publish their own posts. Profile management, editing options, and logout functionality are provided, while comments are powered by the Disqus plugin with email authentication for a more engaging experience.

**✨ Features**

  • User Management: Sign up, login, and session handling

  • Content Handling: Add, update, and manage posts/content. 

  • Database Connectivity: JDBC integration with MySQL

  • Modular Architecture: Clearly separated packages for DAO, Entities, Servlets, and Helpers

  • Responsive Frontend: JSP pages styled with HTML, CSS, and JavaScript

**📂 Project Structure**

  The project is organized into different packages for clarity and maintainability:

  • dao – Data Access Objects, handling all database operations (CRUD for users, posts, etc.)

  • entities – Plain Old Java Objects (POJOs) representing database entities like User, Post, etc.

  • servlets – Controllers handling HTTP requests, responses, and routing

  • helper – Utility classes for database connection, configuration, and common functions

  • web – JSP pages, static resources (HTML, CSS, JS)

**🛠 Tech Stack**

  • Backend: Java, Servlets, JSP

  • Frontend: HTML, CSS, JavaScript (basic interactivity)

  • Database: MySQL with JDBC

  • Server: Apache Tomcat

  • IDE: NetBeans / IntelliJ IDEA

  • Version Control: Git & GitHub

**⚙️ Setup & Installation**
	1. Clone the repository
```
copy code

git clone https://github.com/Jas-raj/CodeVerse.git
cd CodeVerse

```
2. Configure Database
   
    • Create a MySQL database (e.g., codeverse_db)
   
    • Import the SQL schema (if included in /sql folder)
   
    • Update database credentials in **helper/ConnectionProvider.java**

3. Add MySQL Connector

   • Download the MySQL Connector JAR
 
   • Add it to your project’s lib folder and include it in classpath

4.  Deploy to Server

     • Configure Apache Tomcat in your IDE

     • Run the project as a web application


**🚀 Usage**

• Open the application in your browser:

```
http://localhost:8080/CodeVerse
```

• Register/Login as a user

• Explore content management features

**📌 Future Enhancements**

Implement role-based access (admin/user)

• Add REST APIs for frontend integration

• Enhance frontend with Bootstrap/Tailwind

• Improve security with hashing (e.g., BCrypt)

**👨‍💻 Author**

Developed by Jasraj Kaur as a full-stack Java learning project.
