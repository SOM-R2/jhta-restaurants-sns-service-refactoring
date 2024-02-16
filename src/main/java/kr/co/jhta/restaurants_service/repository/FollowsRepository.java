package kr.co.jhta.restaurants_service.repository;

import kr.co.jhta.restaurants_service.repository.composites.FollowCompositePrimaryKeys;
import kr.co.jhta.restaurants_service.vo.socials.Follow;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FollowsRepository extends JpaRepository<Follow, FollowCompositePrimaryKeys> {

    Page<Follow> findFollowsByCompositePrimaryKeys_FollowedIdOrderByCreateDateDesc(int customerId, Pageable pageable);

    Page<Follow> findFollowsByCompositePrimaryKeys_FollowerIdOrderByCreateDateDesc(int customerId, Pageable pageable);

    long countByCompositePrimaryKeys_FollowedId(int customerId);
    long countByCompositePrimaryKeys_FollowerId(int customerId);

    boolean existsByCompositePrimaryKeys_FollowerIdAndCompositePrimaryKeys_FollowedId(int followerId, int followedId);
}
