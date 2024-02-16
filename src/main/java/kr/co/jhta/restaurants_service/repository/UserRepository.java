package kr.co.jhta.restaurants_service.repository;

import kr.co.jhta.restaurants_service.projection.Projection;
import kr.co.jhta.restaurants_service.vo.user.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {

    Optional<User> findByUsername(String username);

    boolean existsUserByEmail(String email);

    boolean existsUserByPhone(String phone);

    boolean existsUserByUsername(String username);

    boolean existsUserByNickname(String nickname);

    Projection.User findUserProjectionByIdAndDisabled(int id, User.DISABLED disabled);

    Optional<User> findUserById(int userId);
}
