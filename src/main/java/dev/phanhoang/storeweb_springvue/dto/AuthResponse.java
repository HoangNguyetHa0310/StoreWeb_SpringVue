package dev.phanhoang.storeweb_springvue.dto;

public class AuthResponse {
    public String token;
    public String email;
    public String firstName;
    public String lastName;
    public AuthResponse(String token, String email, String firstName, String lastName) {
        this.token = token;
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
    }
}
