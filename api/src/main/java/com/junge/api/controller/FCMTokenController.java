package com.junge.api.controller;

import com.google.firebase.messaging.*;
import com.junge.api.Model.FCMNotification;
import com.junge.api.Model.FCMToken;
import com.junge.api.Repository.FCMTokenRep;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.List;

@RestController
@RequestMapping("/FCMToken")
public class FCMTokenController {

    private final FCMTokenRep fcmTokenRep;
    private final FirebaseMessaging firebaseMessaging;

    public FCMTokenController(FCMTokenRep fcmTokenRep, FirebaseMessaging firebaseMessaging) {
        this.fcmTokenRep = fcmTokenRep;
        this.firebaseMessaging = firebaseMessaging;
    }

    @PostMapping("/check-message")
    public String EQMSFCMTopic() throws FirebaseMessagingException {
    FCMNotification fcmNotification = new FCMNotification();

    fcmNotification.setTitile("지진 알림");
    fcmNotification.setBody("주제 잘 받는지 확인");

    Notification notification = Notification
            .builder()
            .setTitle(fcmNotification.getTitile())
            .setBody(fcmNotification.getBody())
            .build();

    Message message = Message
            .builder()
            .setTopic("EQMS")
            .setNotification(notification)
            .build();

    try {
            firebaseMessaging.send(message);
            return "FCM 알림을 성공적으로 전송했습니다.";
    } catch (FirebaseMessagingException e){
            e.printStackTrace();
            return "FCM 알림 전송에 실패했습니다.";
        }
    }

    @PostMapping("/check")
    public String CheckToken(@RequestBody String token) {
        FCMToken response = fcmTokenRep.getReferenceBytoken(token);

        if(response == null){
            Timestamp ts = new Timestamp(System.currentTimeMillis());
            FCMToken fcmToken = new FCMToken(token, ts, ts);
            fcmTokenRep.save(fcmToken); // insert
            return "subscribe"; // 구독 메세지 보내기
        } else {
            Timestamp ts = new Timestamp(System.currentTimeMillis());
            response.setUpdate_time(ts);
            fcmTokenRep.save(response); // update
            return null; // 이미 구독되어있으니 아무것도 안보냄
        }
    }

    @GetMapping("/deprecated")
    public List<String> CheckDeprecated() throws FirebaseMessagingException {
        List<String> fcmTokenList = fcmTokenRep.findAllDeprecated();
        if (fcmTokenList != null ){
            TopicManagementResponse response = firebaseMessaging.unsubscribeFromTopic(
                    fcmTokenList, "EQMS"
            );
            System.out.print("실패:" + response.getFailureCount());
            System.out.print("성공한 것:" + response.getSuccessCount());
            fcmTokenRep.deleteAllByIdInBatch(fcmTokenList);
        }
        return fcmTokenList;
    }
}
