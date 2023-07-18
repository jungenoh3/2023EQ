package com.junge.api.service;


import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.junge.api.Model.FCMNotification;
import com.junge.api.Model.KafkaModel;
import com.linecorp.bot.client.LineMessagingClient;
import com.linecorp.bot.model.PushMessage;
import com.linecorp.bot.model.message.TextMessage;
import com.linecorp.bot.model.response.BotApiResponse;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.json.simple.parser.ParseException;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

@Component
public class KafkaListeners {
    private final FirebaseMessaging firebaseMessaging;

    public KafkaListeners(FirebaseMessaging firebaseMessaging) {
        this.firebaseMessaging = firebaseMessaging;
    }

    private String EQMSLineAPI(Double data){
        final LineMessagingClient client = LineMessagingClient
                .builder("o7WhaO9vMoAzhP7h1WDuxjZNek79QoblCkNLndDcDuLoDlAyBEYJb4crTDVV8cdTFAH3bnzBdhmbgFN+KP1OajTnWrkaCGzmj1h6g8OoTLoF1lN2jz7o+QO4Yo8zc21oYOQzzN53tJRPXlbLHyVsVwdB04t89/1O/w1cDnyilFU=")
                .build();

        final TextMessage textMessage = new TextMessage("진도 " + data +"의 지진이 일어났습니다.\n신속히 대피해주세요.");
        final PushMessage pushMessage = new PushMessage(
                "Uf83a19041d324526d51909f41c242778",
                textMessage);

        final BotApiResponse botApiResponse;
        try {
            botApiResponse = client.pushMessage(pushMessage).get();
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
            return "Line 전송 실패";
        }
        return botApiResponse.toString();

    }

    public String EQMSFCMTopic(Double data) throws FirebaseMessagingException {
        FCMNotification fcmNotification = new FCMNotification();

        fcmNotification.setTitile("지진 알림");
        fcmNotification.setBody(data + "도의 지진이 발생했습니다.");

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

    private void kafkaMessageProcess(String kafkaData) throws IOException, FirebaseMessagingException {
        ObjectMapper mapper = new ObjectMapper();
        KafkaModel kafkaModel = mapper.readValue(kafkaData, KafkaModel.class);

        System.out.println("Data: " + kafkaModel.getSensor_id() + " " + kafkaModel.getAddress() + " " + kafkaModel.getValue());

        if (kafkaModel.getValue() > 10){
            String LineAnswer = EQMSLineAPI(kafkaModel.getValue());
            String FCMAnswer = EQMSFCMTopic(kafkaModel.getValue());
            System.out.println(LineAnswer + " " + FCMAnswer);
        }

    }

    @KafkaListener(topics = "topic1", groupId = "test")
    void listener(ConsumerRecord<String, String> record) throws IOException, FirebaseMessagingException {
        kafkaMessageProcess(record.value());
    }

}
