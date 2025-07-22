package dev.phanhoang.storeweb_springvue.service;

import dev.phanhoang.storeweb_springvue.dto.AuthResponse;
import dev.phanhoang.storeweb_springvue.dto.LoginRequest;
import dev.phanhoang.storeweb_springvue.dto.RegisterRequest;
import dev.phanhoang.storeweb_springvue.entity.User;
import dev.phanhoang.storeweb_springvue.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
public class AuthServiceImpl implements AuthService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JwtUtil jwtUtil;

    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @Override
    public AuthResponse register(RegisterRequest request) {
        if (userRepository.existsByEmail(request.email)) {
            throw new dev.phanhoang.storeweb_springvue.exception.DuplicateResourceException("Email already exists");
        }
        User user = new User();
        user.setEmail(request.email);
        user.setPasswordHash(passwordEncoder.encode(request.password));
        user.setFirstName(request.firstName);
        user.setLastName(request.lastName);
        user.setPhone(request.phone);
        userRepository.save(user);
        String token = jwtUtil.generateToken(user.getEmail());
        return new AuthResponse(token, user.getEmail(), user.getFirstName(), user.getLastName());
    }

    @Override
    public AuthResponse login(LoginRequest request) {
        Optional<User> userOpt = userRepository.findByEmail(request.email);
        if (userOpt.isEmpty() || !passwordEncoder.matches(request.password, userOpt.get().getPasswordHash())) {
            throw new RuntimeException("Invalid email or password");
        }
        User user = userOpt.get();
        String token = jwtUtil.generateToken(user.getEmail());
        return new AuthResponse(token, user.getEmail(), user.getFirstName(), user.getLastName());
    }
}
