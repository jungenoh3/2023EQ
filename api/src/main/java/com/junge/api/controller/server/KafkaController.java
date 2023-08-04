package com.junge.api.controller.server;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.junge.api.Model.server.Earthquake;
import com.junge.api.Model.server.FCMNotification;
import com.junge.api.Model.server.SensorData;
import com.junge.api.Repository.server.EarthquakeDataRep;
import com.junge.api.Repository.server.SensorDataRep;
import com.linecorp.bot.client.LineMessagingClient;
import com.linecorp.bot.model.PushMessage;
import com.linecorp.bot.model.message.TextMessage;
import com.linecorp.bot.model.response.BotApiResponse;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.springframework.http.MediaType;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Sinks;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping()
public class KafkaController {
    private final SensorDataRep sensorDataRep;
    private final EarthquakeDataRep earthQuakeDataRep;
    private final FirebaseMessaging firebaseMessaging;
    private final ObjectMapper mapper = new ObjectMapper();
    private Sinks.Many<String> realTimeDataMany = Sinks.many().multicast().onBackpressureBuffer();


    public KafkaController(SensorDataRep sensorDataRep, EarthquakeDataRep earthQuakeDataRep, FirebaseMessaging firebaseMessaging) {
        this.sensorDataRep = sensorDataRep;
        this.earthQuakeDataRep = earthQuakeDataRep;
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
        SensorData sensorData = mapper.readValue(kafkaData, SensorData.class);
        Timestamp ts = new Timestamp(System.currentTimeMillis());
        sensorData.setUpdate_time(ts);

        // sensorDataRep.save(sensorData);

        if (sensorData.getAcc_x() > 10){
            Earthquake earthQuake = new Earthquake(sensorData.getLatitude(), sensorData.getLongitude(),
                    ts, sensorData.getAcc_x()/10);
            earthQuakeDataRep.save(earthQuake);
            System.out.println(earthQuake);
            sendData("Earthquake");

//            String LineAnswer = EQMSLineAPI(sensorData.getAcc_x());
//            String FCMAnswer = EQMSFCMTopic(sensorData.getAcc_x());
//            System.out.println(LineAnswer + " " + FCMAnswer);
        }

    }
    public void sendData(String data) {
        Sinks.EmitResult result = this.realTimeDataMany.tryEmitNext(data);
//        if (result.isFailure()){
//            result.orThrow();
//        }
    }

//    @GetMapping(value = "/server-events", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
//    public Flux<String> SendDataToClient() throws IOException {
//        return this.realTimeDataMany.asFlux();
//    }
//
//    @KafkaListener(topics = "topic1", groupId = "test")
//    void listener(ConsumerRecord<String, String> record) throws IOException, FirebaseMessagingException {
//        kafkaMessageProcess(record.value());
//    }

}

