package kr.co.jhta.restaurants_service.util;

import kr.co.jhta.restaurants_service.repository.FollowRequestRepository;
import kr.co.jhta.restaurants_service.repository.UserRepository;
import kr.co.jhta.restaurants_service.vo.socials.FollowRequest;
import kr.co.jhta.restaurants_service.vo.user.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class FollowRequestGenerator {

    @Autowired
    FollowRequestRepository followRequestRepository;

    @Autowired
    UserRepository userRepository;

    public void generateAndInsertFollowRequests() {
        List<Integer> userIds = userRepository.findAll().stream()
                .map(User::getId)
                .collect(Collectors.toList());

        List<Integer> recipients = Arrays.asList(181, 182, 183);

        for (int i = 0; i < userIds.size(); i++) {
            int senderId = userIds.get(i);

            for (int j = 0; j < recipients.size(); j++) {
                int recipientId = recipients.get(j);

                // Check if a follow request with the same senderId and recipientId already exists
                if (!followRequestRepository.existsFollowRequestBySenderIdAndRecipientId(senderId, recipientId)) {
                    FollowRequest followRequest = new FollowRequest(senderId, recipientId);

                    try {
                        followRequestRepository.save(followRequest);
                    } catch (DataIntegrityViolationException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

}
