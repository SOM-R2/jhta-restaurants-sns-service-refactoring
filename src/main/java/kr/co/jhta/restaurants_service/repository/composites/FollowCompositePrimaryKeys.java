package kr.co.jhta.restaurants_service.repository.composites;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Embeddable;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class FollowCompositePrimaryKeys implements Serializable {

    // TODO: Q) why does the embedded id class need to implement `Serializable` or override `hashCode()` and `equals()` ?

    @Column(name = "follower_id")
    private int followerId;

    @Column(name = "followed_id")
    private int followedId;

    public FollowCompositePrimaryKeys(int followerId, int followedId) {
        this.followerId = followerId;
        this.followedId = followedId;
    }

    public FollowCompositePrimaryKeys() {

    }

    @Override
    public boolean equals(Object o) {

        if (this == o) { return true; }
        if (o == null || getClass() != o.getClass()) { return false; }
        FollowCompositePrimaryKeys that = (FollowCompositePrimaryKeys) o;

        return followerId == that.followerId && followedId == that.followedId;
    }

    @Override
    public int hashCode() {

        return Objects.hash(followerId, followedId);
    }

    public int getFollowerId() {
        return followerId;
    }

    public int getFollowedId() {
        return followedId;
    }
}
