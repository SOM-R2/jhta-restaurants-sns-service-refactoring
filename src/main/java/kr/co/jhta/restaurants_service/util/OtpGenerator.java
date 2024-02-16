package kr.co.jhta.restaurants_service.util;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

public class OtpGenerator {
    public static String generateCode() {

        String otp;

        try {
            SecureRandom secureRandom = SecureRandom.getInstanceStrong();
            otp = String.valueOf(secureRandom.nextInt(9000) + 1000);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("No algorithm for generating an OTP.");
        }

        return otp;
    }
}
