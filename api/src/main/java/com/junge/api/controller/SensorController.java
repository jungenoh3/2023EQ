package com.junge.api.controller;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.junge.api.Model.FCMNotification;
import com.junge.api.Model.SensorInfo;
import com.junge.api.Repository.SensorInfoRep;
import com.linecorp.bot.client.LineMessagingClient;
import com.linecorp.bot.model.PushMessage;
import com.linecorp.bot.model.message.TextMessage;
import com.linecorp.bot.model.response.BotApiResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping("/sensor-info")
public class SensorController {
    private final SensorInfoRep sensorInfoRep;
    private final FirebaseMessaging firebaseMessaging;
    private final List<SensorInfo> sensorDataList = new ArrayList<SensorInfo>();

    public SensorController(SensorInfoRep sensorInfoRep, FirebaseMessaging firebaseMessaging) {
        this.sensorInfoRep = sensorInfoRep;
        this.firebaseMessaging = firebaseMessaging;
    }

    @GetMapping("/all")
    public ResponseEntity getAllSensor(){
        return ResponseEntity.ok(this.sensorInfoRep.findAll());
    }

    @GetMapping("/test")
    public ResponseEntity getSpecific(){
        return ResponseEntity.ok(this.sensorInfoRep.getNeed());
        // return ResponseEntity.ok(this.sensorInfoRep.getReferenceById(2L));
    }

    @PostMapping("/post")
    public void PostData(@RequestBody SensorInfo sensorInfo) throws Exception {
        sensorDataList.add(sensorInfo);
    }

    @GetMapping("/post")
    public List<SensorInfo> ReceivedData(){
        return sensorDataList;
    }

    @PostMapping("/FCMmessage")
    public String sendFCMNotification() throws FirebaseMessagingException {
        FCMNotification fcmNotification = new FCMNotification();
        // 이젠 기기마다 아이디 찾아야함
        fcmNotification.setToken("coRTOZiMQj-BbYzcasphxU:APA91bEwqxAB9_4gQnU8PkPW60vEqzVW-I80jHQ-GYqelB1XTnFMf0Nv-0z4nVm3LgdLw65UsFNoxu-JnK4Mw_a_ZGpXL39NXsmEkdwcWOp4YfK4a_uSl0Hy03yRre4mhDMTUD5shmXv");
        fcmNotification.setTitile("지진 알림");
        fcmNotification.setBody("N도의 지진이 발생했습니다.");

        Notification notification = Notification
                .builder()
                .setTitle(fcmNotification.getTitile())
                .setBody(fcmNotification.getBody())
                .build();

        Message message = Message
                .builder()
                .setToken(fcmNotification.getToken())
                .setNotification(notification)
                .build();

        try {
            firebaseMessaging.send(message);
            return "알림을 성공적으로 전송했습니다.";
        } catch (FirebaseMessagingException e){
            e.printStackTrace();
            return "실패했습니다.";
        }
    }

    @PostMapping("/LineAPI")
    public String LineApiMessage() {
        final LineMessagingClient client = LineMessagingClient
                .builder("o7WhaO9vMoAzhP7h1WDuxjZNek79QoblCkNLndDcDuLoDlAyBEYJb4crTDVV8cdTFAH3bnzBdhmbgFN+KP1OajTnWrkaCGzmj1h6g8OoTLoF1lN2jz7o+QO4Yo8zc21oYOQzzN53tJRPXlbLHyVsVwdB04t89/1O/w1cDnyilFU=")
                .build();

        // 이제 textMessage 말고도 다른 type도 보낼 수 있겠다!!
        final TextMessage textMessage = new TextMessage("우오아아와");
        final PushMessage pushMessage = new PushMessage(
                "Uf83a19041d324526d51909f41c242778",
                textMessage);

        final BotApiResponse botApiResponse;
        try {
            botApiResponse = client.pushMessage(pushMessage).get();
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
            return "실패";
        }

        System.out.println(botApiResponse);
        return botApiResponse.toString();
    }




}
