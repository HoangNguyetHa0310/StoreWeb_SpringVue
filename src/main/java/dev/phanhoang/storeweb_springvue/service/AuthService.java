package dev.phanhoang.storeweb_springvue.service;

import dev.phanhoang.storeweb_springvue.dto.AuthResponse;
import dev.phanhoang.storeweb_springvue.dto.LoginRequest;
import dev.phanhoang.storeweb_springvue.dto.RegisterRequest;

public interface AuthService {
    AuthResponse register(RegisterRequest request);
    AuthResponse login(LoginRequest request);
}
