package kr.co.jhta.restaurants_service.vo.socials;

import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.type.Alias;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.util.Date;

@Getter @Setter
@Alias("FollowRequests")
@Entity
@Table(name = "FOLLOW_REQUESTS")
public class FollowRequest {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "sender_id")
    private int senderId;

    @Column(name = "recipient_id")
    private int recipientId;

    @Enumerated(EnumType.STRING)
    private RequestStatus status;

    @CreationTimestamp
    private Date createDate = new Date();

    public FollowRequest() {
    }

    public FollowRequest(int senderId, int recipientId) {
        this.senderId = senderId;
        this.recipientId = recipientId;
        this.status = RequestStatus.PENDING;
    }

    public FollowRequest(int senderId, int recipientId, RequestStatus status) {
        this.senderId = senderId;
        this.recipientId = recipientId;
        this.status = status;
    }

    public enum RequestStatus {
        PENDING, ACCEPTED, DECLINED, SENT
    }

    public int getId() {
        return id;
    }

    public int getSenderId() {
        return senderId;
    }

    public int getRecipientId() {
        return recipientId;
    }

    public RequestStatus getStatus() {
        return status;
    }

    public Date getCreateDate() {
        return createDate;
    }
}
