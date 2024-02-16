package kr.co.jhta.restaurants_service.vo.user;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.apache.ibatis.type.Alias;
import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.CascadeType;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.annotation.Transient;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Getter @Setter
@Alias("Customer")
@Table(name = "USERS")
@Entity
public class User {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String username;

    @JsonIgnore
    private String password;

    @Column(name = "full_name")
    private String fullName;

    private String email;
    private String phone;
    private Date birthday;
    private String gender;

    @CreatedDate
    @Column(name = "create_date")
    private Date createDate;

    @LastModifiedDate
    @Column(name = "update_date")
    private Date updateDate;

    @Enumerated(EnumType.STRING)
    private DISABLED disabled;

    private String nickname;

    @Column(name = "profile_picture_name")
    private String profilePictureName;

    @Enumerated(EnumType.STRING)
    private TYPE type;

    @OneToMany(
            mappedBy = "user",
            cascade = javax.persistence.CascadeType.ALL,
            fetch = FetchType.EAGER
    )
    private List<Role> roles;

    @Enumerated(EnumType.STRING)
    private VISIBILITY visibility = VISIBILITY.PUBLIC;

    public User() {

        this.createDate = new Date(); // default to current time
        this.updateDate = new Date(); // default to current time
        this.disabled = DISABLED.NO; // default to `NO`
        this.visibility = VISIBILITY.PUBLIC;
    }

    public User(TYPE type) {
        this.type = type;

        this.createDate = new Date(); // default to current time
        this.updateDate = new Date(); // default to current time
        this.disabled = DISABLED.NO; // default to `NO`
        this.visibility = VISIBILITY.PUBLIC;
    }

    public User(String username, String password, String fullName, String email, String phone, String nickname, Date birthday, String gender, TYPE type) {
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.nickname = nickname;
        this.birthday = birthday;
        this.gender = gender;
        this.type = type;

        this.createDate = new Date(); // default to current time
        this.updateDate = new Date(); // default to current time
        this.disabled = DISABLED.NO; // default to `NO`
    }

    public enum TYPE {
        ADMIN, CUSTOMER, OWNER
    }

    public enum DISABLED {
        YES, NO
    }

    public enum VISIBILITY {
        PUBLIC, PRIVATE
    }

    public void addRole(Role role) {
        if (this.roles == null) {
            this.roles = new ArrayList<>();
        }

        role.setUser(this);
        this.roles.add(role);
    }
}
