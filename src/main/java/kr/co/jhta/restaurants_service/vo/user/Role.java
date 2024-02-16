package kr.co.jhta.restaurants_service.vo.user;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

@Getter @Setter
@Table(name = "ROLES")
@Entity
public class Role {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @JsonIgnore // for resolving the circular reference between `Role` and `User` entities
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;
    private String role;

    public Role(User user, String role) {
        this.user = user;
        this.role = role;
    }

    public Role() {
    }
}
