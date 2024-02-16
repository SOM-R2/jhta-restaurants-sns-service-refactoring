package kr.co.jhta.restaurants_service.service;

import kr.co.jhta.restaurants_service.dto.FollowRequestDto;
import kr.co.jhta.restaurants_service.projection.Projection;
import kr.co.jhta.restaurants_service.repository.FollowRequestRepository;
import kr.co.jhta.restaurants_service.repository.FollowsRepository;
import kr.co.jhta.restaurants_service.repository.UserRepository;
import kr.co.jhta.restaurants_service.repository.composites.FollowCompositePrimaryKeys;
import kr.co.jhta.restaurants_service.vo.socials.Follow;
import kr.co.jhta.restaurants_service.vo.socials.FollowRequest;
import kr.co.jhta.restaurants_service.vo.user.User;
import org.jboss.logging.Logger;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class SocialService {
    private final Logger logger = Logger.getLogger(SocialService.class);

    private final FollowsRepository followsRepository;
    private final FollowRequestRepository followRequestRepository;
    private final UserRepository userRepository;

    public SocialService(FollowsRepository followsRepository, UserRepository userRepository, FollowRequestRepository followRequestRepository) {
        this.followsRepository = followsRepository;
        this.userRepository = userRepository;
        this.followRequestRepository = followRequestRepository;
    }

    public List<Projection.User> getNonDisabledFollowingsByCustomerIdOrderByCreateDate(int customerId, User.DISABLED disabled, Integer page, Integer limit) {

        return followsRepository
                .findFollowsByCompositePrimaryKeys_FollowerIdOrderByCreateDateDesc(customerId, PageRequest.of(page, limit))
                .stream()
                .map(follow -> follow.getCompositePrimaryKeys().getFollowedId())
                .map(followedId -> userRepository.findUserProjectionByIdAndDisabled(followedId, disabled))
                .collect(Collectors.toList());
    }

    public List<Projection.User> getNonDisabledFollowersByCustomerIdOrderByCreateDate(int customerId, User.DISABLED disabled, Integer page, Integer limit) {

        return followsRepository
                .findFollowsByCompositePrimaryKeys_FollowedIdOrderByCreateDateDesc(customerId, PageRequest.of(page, limit))
                .stream()
                .map(follow -> follow.getCompositePrimaryKeys().getFollowerId())
                .map(followerId -> userRepository.findUserProjectionByIdAndDisabled(followerId, disabled))
                .collect(Collectors.toList());
    }

    public long getFollowersCountByCustomerId(int customerId) {
        return followsRepository.countByCompositePrimaryKeys_FollowedId(customerId);
    }

    public long getFollowingsCountByCustomerId(Integer customerId) {
        return followsRepository.countByCompositePrimaryKeys_FollowerId(customerId);

    }

    public List<FollowRequestDto> getArrivedRequestsDeniedByRecipientId(Integer customerId, int page, int limit) {
        return followRequestRepository.findByRecipientIdAndStatusOrderByCreateDateDesc(customerId, FollowRequest.RequestStatus.DECLINED, PageRequest.of(page, limit))
                .stream()
                .map(request -> {
                    Projection.User user = userRepository.findUserProjectionByIdAndDisabled(request.getSenderId(), User.DISABLED.NO);
                    return new FollowRequestDto(request, user);
                })
                .collect(Collectors.toList());
    }

    public List<FollowRequestDto> getArrivedRequestsPendingByRecipientId(Integer customerId, int page, int limit) {

        return followRequestRepository.findByRecipientIdAndStatusOrderByCreateDateDesc(customerId, FollowRequest.RequestStatus.PENDING, PageRequest.of(page, limit))
                .stream()
                .map(request -> {
                    Projection.User user = userRepository.findUserProjectionByIdAndDisabled(request.getSenderId(), User.DISABLED.NO);
                    return new FollowRequestDto(request, user);
                })
                .collect(Collectors.toList());
    }

    public List<FollowRequestDto> getArrivedRequestsAcceptedByRecipientId(Integer customerId, int page, int limit) {

        return followRequestRepository.findByRecipientIdAndStatusOrderByCreateDateDesc(customerId, FollowRequest.RequestStatus.ACCEPTED, PageRequest.of(page, limit))
                .stream()
                .map(request -> {
                    Projection.User user = userRepository.findUserProjectionByIdAndDisabled(request.getSenderId(), User.DISABLED.NO);
                    return new FollowRequestDto(request, user);
                })
                .collect(Collectors.toList());
    }

    public List<FollowRequestDto> getSentRequestsBySenderId(Integer customerId, int page, int limit) {
        return followRequestRepository.findBySenderIdOrderByCreateDateDesc(customerId, PageRequest.of(page, limit))
                .stream()
                .map(request -> {
                    request.setStatus(FollowRequest.RequestStatus.SENT);
                    Projection.User user = userRepository.findUserProjectionByIdAndDisabled(request.getRecipientId(), User.DISABLED.NO);
                    return new FollowRequestDto(request, user);
                })
                .collect(Collectors.toList());
    }

    public List<FollowRequestDto> getArrivedRequestsByRecipientId(Integer customerId, int page, int limit) {
        return followRequestRepository.findByRecipientIdOrderByCreateDateDesc(customerId, PageRequest.of(page, limit))
                .stream()
                .map(request -> {
                    Projection.User user = userRepository.findUserProjectionByIdAndDisabled(request.getSenderId(), User.DISABLED.NO);
                    return new FollowRequestDto(request, user);
                })
                .collect(Collectors.toList());
    }

    public String updateRequestStatus(int requestId, int recipientId) {

        FollowRequest followRequest = followRequestRepository.findById(requestId).get();

        if (followRequest.getRecipientId() == recipientId) {

            Follow follow = new Follow(new FollowCompositePrimaryKeys(followRequest.getSenderId(), followRequest.getRecipientId()));

            // only when the person who tries to modify the status is the person who got the follow request
            if (followRequest.getStatus().equals(FollowRequest.RequestStatus.PENDING)) {
                followsRepository.save(follow);
                followRequest.setStatus(FollowRequest.RequestStatus.ACCEPTED);

            } else if (followRequest.getStatus().equals(FollowRequest.RequestStatus.ACCEPTED)) {
                followsRepository.delete(follow);
                followRequest.setStatus(FollowRequest.RequestStatus.DECLINED);

            } else {
                followsRepository.save(follow);
                followRequest.setStatus(FollowRequest.RequestStatus.ACCEPTED);
            }
        } // if not, no modification occurs

        followRequestRepository.save(followRequest);

        return followRequest.getStatus().toString();
    }

    public boolean handleFollowRequest(int senderId, int recipientId) {

        // if there's no request before
        if (!followRequestRepository.existsFollowRequestBySenderIdAndRecipientId(senderId, recipientId)) {

            User recipient = userRepository.findUserById(recipientId).get();
            if (recipient.getVisibility().equals(User.VISIBILITY.PUBLIC)) {

                followRequestRepository.save(new FollowRequest(senderId, recipientId, FollowRequest.RequestStatus.ACCEPTED));

                Follow follow = new Follow(new FollowCompositePrimaryKeys(senderId, recipientId));
                followsRepository.save(follow);

                return true;
            }

            followRequestRepository.save(new FollowRequest(senderId, recipientId));
            return true;
        } else {
            return false;
        }
    }

    public boolean doesThisUserFollowsOtherUser(int thisId, int othersId) {

        return followsRepository.existsByCompositePrimaryKeys_FollowerIdAndCompositePrimaryKeys_FollowedId(thisId, othersId);
    }
}
