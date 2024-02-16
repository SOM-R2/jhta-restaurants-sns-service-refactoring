package kr.co.jhta.restaurants_service.vo.user;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;
import org.springframework.data.annotation.CreatedDate;

import javax.persistence.*;
import java.util.Date;

@Getter @Setter
@Alias("Otp")
@Table(name = "OTP")
@Entity
public class Otp {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String email;

    @Column(name = "otp_code")
    private String otpCode;

    @CreatedDate
    @Column(name = "create_date")
    private Date createDate;

    public Otp() {
    }

    public Otp(String email) {
        this.createDate = new Date();
        this.email = email;
    }

    public Otp(String email, String otpCode) {
        this.createDate = new Date();
        this.email = email;
        this.otpCode = otpCode;
    }
}
