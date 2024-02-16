package kr.co.jhta.restaurants_service.service;

import kr.co.jhta.restaurants_service.controller.command.OtpCommand;
import kr.co.jhta.restaurants_service.mapper.OtpMapper;
import kr.co.jhta.restaurants_service.repository.OtpRepository;
import kr.co.jhta.restaurants_service.util.EmailSender;
import kr.co.jhta.restaurants_service.util.OtpGenerator;
import kr.co.jhta.restaurants_service.vo.user.Otp;
import org.springframework.stereotype.Service;

@Service
public class OtpService {

    private final EmailSender emailSender;
    private final OtpRepository otpRepository;

    public OtpService(EmailSender emailSender, OtpRepository otpRepository) {
        this.emailSender = emailSender;
        this.otpRepository = otpRepository;
    }

    public Otp issueOtp(String email) {

        Otp otp = new Otp(email);
        otp.setOtpCode(OtpGenerator.generateCode());

        otpRepository.save(otp);
        emailSender.sendEmail(email, otp.getOtpCode());

        return otp;
    }

    public Otp renewOtp(String email) {

        Otp otp = otpRepository.findByEmail(email);
        otp.setOtpCode(OtpGenerator.generateCode());

        otpRepository.save(otp);

        return otp;
    }

    public void invalidateOtp(Otp otp) {

        otpRepository.delete(otp);
    }

    public boolean validateOtp(OtpCommand otpCommand) {

        return otpRepository.validateByEmail(otpCommand.getOtpCode(), otpCommand.getEmail());
    }
}
