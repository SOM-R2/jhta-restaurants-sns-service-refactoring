package kr.co.jhta.restaurants_service.repository;

import kr.co.jhta.restaurants_service.vo.user.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface RoleRepository extends JpaRepository<Role, Integer> {

    @Query("SELECT r FROM Role r WHERE r.user.id = :userId") // Use the entity alias "r"
    List<Role> findByUserId(int userId);
}
