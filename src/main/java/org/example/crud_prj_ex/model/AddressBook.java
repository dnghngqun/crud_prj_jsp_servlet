package org.example.crud_prj_ex.model;

public class AddressBook {
    private int id;
    private String fullName;
    private String phoneNumber;
    private String address;
    private String userId;

    public AddressBook() {}

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
}