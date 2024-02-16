package kr.co.jhta.restaurants_service.controller.command;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class OtpCommand {

    public String email;
    public String otpCode;
}
