package kr.co.jhta.restaurants_service.repository;

import kr.co.jhta.restaurants_service.vo.socials.FollowRequest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FollowRequestRepository extends JpaRepository<FollowRequest, Integer> {

    Page<FollowRequest> findBySenderIdOrderByCreateDateDesc(int senderId, Pageable pageable);
    Page<FollowRequest> findByRecipientIdOrderByCreateDateDesc(int recipientId, Pageable pageable);
    Page<FollowRequest> findByRecipientIdAndStatusOrderByCreateDateDesc(Integer customerId, FollowRequest.RequestStatus requestStatus, Pageable pageable);
    boolean existsFollowRequestBySenderIdAndRecipientId(int senderId, int recipientId);
}
