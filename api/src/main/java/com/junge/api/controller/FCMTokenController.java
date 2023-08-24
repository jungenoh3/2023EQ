package com.junge.api.controller;

import com.google.firebase.messaging.*;
import com.junge.api.model.FCMNotification;
import com.junge.api.model.FCMToken;
import com.junge.api.repository.FCMTokenRep;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.util.ArrayList;
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

    @PostMapping("/check-message") // 토픽 메세지 잘 받는지 확인용
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
            .setTopic("EQMS-1")
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

    @PostMapping("/check") // 토큰 받아서 DB로 보내기
    public String CheckToken(@RequestBody String token) {
        FCMToken response = fcmTokenRep.getReferenceBytoken(token);

        if(response == null){
            Timestamp ts = new Timestamp(System.currentTimeMillis());
            FCMToken fcmToken = new FCMToken(token, ts, ts);
            fcmTokenRep.save(fcmToken); // insert

            List<String> tokenList = new ArrayList<String>(); // 구독
            tokenList.add(token);
            try{
                TopicManagementResponse topicManagementResponse = firebaseMessaging.subscribeToTopic(tokenList, "EQMS-1");
                System.out.println(String.format("성공한 수: %d \n실패한 수: %d", topicManagementResponse.getSuccessCount(), topicManagementResponse.getFailureCount()));
            } catch (FirebaseMessagingException e) {
                System.out.println(e);
            }
            return "subscribed"; // 구독 메세지 보내기
        } else {
            Timestamp ts = new Timestamp(System.currentTimeMillis());
            response.setUpdate_time(ts);
            fcmTokenRep.save(response); // update
            return "already subscribed"; // 이미 구독되어있으니 아무것도 안보냄
        }
    }

    @GetMapping("/deprecated")
    public void CheckDeprecated() throws FirebaseMessagingException {
        List<String> fcmTokenList = fcmTokenRep.findAllDeprecated(); // 30분동안 업데이트 되지 않은 것 구독 해제 및 삭제
        if (fcmTokenList != null ){
            TopicManagementResponse response = firebaseMessaging.unsubscribeFromTopic(
                    fcmTokenList, "EQMS-1"
            );
            if (response.getFailureCount() > 0 ){
                System.out.print(response.getErrors());
            } else {
                fcmTokenRep.deleteAllByIdInBatch(fcmTokenList);
                System.out.print("Success: " + response.getSuccessCount());
            }
        }
    }
}
