package kr.co.jhta.restaurants_service.repository;

import kr.co.jhta.restaurants_service.vo.user.Otp;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface OtpRepository extends JpaRepository<Otp, Integer> {

    Otp findByEmail(String email);

    @Query("SELECT CASE WHEN COUNT(o) > 0 THEN true ELSE false END FROM Otp o WHERE o.otpCode = :otpCode AND o.email = :email")
    boolean validateByEmail(String otpCode, String email);
}
