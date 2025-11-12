package com.example.api;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class ApiService {

    public static void main(String[] args) {
        SpringApplication.run(ApiService.class, args);
    }

    @GetMapping("/api/health")
    public String healthCheck() {
        // In a real scenario, this would check the database connection
        return "{\"status\":\"UP\", \"service\":\"api-service\"}";
    }

    @GetMapping("/api/users")
    public String getUsers() {
        // A mock response
        return "[{\"id\":1, \"name\":\"Mock User 1\"}, {\"id\":2, \"name\":\"Mock User 2\"}]";
    }
}