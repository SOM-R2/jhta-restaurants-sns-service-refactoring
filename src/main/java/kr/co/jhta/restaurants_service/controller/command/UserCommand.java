package kr.co.jhta.restaurants_service.controller.command;

import kr.co.jhta.restaurants_service.vo.user.User;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter @Setter
public class UserCommand {

    private String username;
    private String password;
    private String fullName;
    private String email;
    private String phone;
    private String nickname;
    private Date birthday;
    private String gender;

    public static User toCustomer(UserCommand userCommand) {
        return new User(
                userCommand.getUsername(),
                userCommand.getPassword(),
                userCommand.getFullName(),
                userCommand.getEmail(),
                userCommand.getPhone(),
                userCommand.getNickname(),
                userCommand.getBirthday(),
                userCommand.getGender(),
                User.TYPE.CUSTOMER
        );
    }

    public static User toOwner(UserCommand userCommand) {
        return new User(
                userCommand.getUsername(),
                userCommand.getPassword(),
                userCommand.getFullName(),
                userCommand.getEmail(),
                userCommand.getPhone(),
                userCommand.getNickname(),
                userCommand.getBirthday(),
                userCommand.getGender(),
                User.TYPE.OWNER
        );
    }

    public static User toAdmin(UserCommand userCommand) {
        return new User(
                userCommand.getUsername(),
                userCommand.getPassword(),
                userCommand.getFullName(),
                userCommand.getEmail(),
                userCommand.getPhone(),
                userCommand.getNickname(),
                userCommand.getBirthday(),
                userCommand.getGender(),
                User.TYPE.ADMIN
        );
    }
}
