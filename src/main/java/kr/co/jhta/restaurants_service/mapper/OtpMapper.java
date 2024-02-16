package kr.co.jhta.restaurants_service.mapper;

import kr.co.jhta.restaurants_service.vo.user.Otp;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OtpMapper {

    void insert(Otp otp);

    Otp findByUserId(String email);

    void update(Otp otp);

    void delete(Otp otp);

    boolean validateByEmail(Otp otp);
}
