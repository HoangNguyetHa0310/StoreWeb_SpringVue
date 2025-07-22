package dev.phanhoang.storeweb_springvue.controller;

import dev.phanhoang.storeweb_springvue.dto.AuthResponse;
import dev.phanhoang.storeweb_springvue.dto.LoginRequest;
import dev.phanhoang.storeweb_springvue.dto.RegisterRequest;
import dev.phanhoang.storeweb_springvue.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {
    @Autowired
    private AuthService authService;

    @PostMapping("/register")
    public AuthResponse register(@RequestBody RegisterRequest request) {
        return authService.register(request);
    }

    @PostMapping("/login")
    public AuthResponse login(@RequestBody LoginRequest request) {
        return authService.login(request);
    }
}
