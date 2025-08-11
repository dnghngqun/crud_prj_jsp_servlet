package org.example.crud_prj_ex.model;

public class User {
    private String user_id;
    private String password;
    private String email;
    private String fullName;

    public User() {}

    public User( String password, String email, String fullName) {
        this.password = password;
        this.email = email;
        this.fullName = fullName;
    }

    // Getters and setters

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
}