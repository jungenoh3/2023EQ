package com.junge.api.controller;

import com.junge.api.model.Users;
import com.junge.api.repository.UserRep;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/EQMS/user")
public class UserController {
    private final UserRep userRep;

    public UserController(UserRep userRep) {
        this.userRep = userRep;
    }

    @PostMapping("/register")
    public String saveUserInfo(@RequestParam String name, @RequestParam String identification, @RequestParam String password, @RequestParam String phone_number, @RequestParam String email){
        Users idVerification = this.userRep.getReferenceByidentification(identification);
        if (idVerification == null){
            this.userRep.save(new Users(name, identification, password, phone_number, email));
            return "회원 등록이 되었습니다.";
        } else {
            return "같은 아이디가 있습니다.";
        }
    }

    @GetMapping("/login")
    public String loginUser(@RequestParam String identification, @RequestParam String password){
        Users checkUser = this.userRep.getReferenceByidentification(identification);
        if (checkUser == null){
            return "없는 유저입니다.";
        } else {
            return checkUser.getPassword().equals(password) ? "로그인:" + checkUser.getName() : "틀린 비밀번호";
        }
    }

}
