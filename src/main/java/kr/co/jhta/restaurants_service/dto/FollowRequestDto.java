package kr.co.jhta.restaurants_service.dto;

import kr.co.jhta.restaurants_service.projection.Projection;
import kr.co.jhta.restaurants_service.vo.socials.FollowRequest;

public class FollowRequestDto {

    private FollowRequest followRequest;
    private Projection.User user;

    public FollowRequestDto(FollowRequest followRequest, Projection.User user) {
        this.followRequest = followRequest;
        this.user = user;
    }

    public FollowRequest getFollowRequest() {
        return followRequest;
    }

    public void setFollowRequest(FollowRequest followRequest) {
        this.followRequest = followRequest;
    }

    public Projection.User getUser() {
        return user;
    }

    public void setUser(Projection.User user) {
        this.user = user;
    }
}
