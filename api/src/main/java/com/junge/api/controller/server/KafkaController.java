package com.junge.api.controller.server;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.junge.api.Model.server.Earthquake;
import com.junge.api.Model.server.EarthquakeRaw;
import com.junge.api.Model.server.FCMNotification;
import com.junge.api.Repository.server.EarthquakeDataRep;
import com.junge.api.Repository.server.SensorDataRep;
import com.junge.api.Service.KafkaService;
import com.linecorp.bot.client.LineMessagingClient;
import com.linecorp.bot.model.PushMessage;
import com.linecorp.bot.model.message.TextMessage;
import com.linecorp.bot.model.response.BotApiResponse;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Sinks;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping()
public class KafkaController {
    private KafkaService kafkaService;
    private final SensorDataRep sensorDataRep;
    private final EarthquakeDataRep earthQuakeDataRep;
    private final FirebaseMessaging firebaseMessaging;
    private final ObjectMapper mapper = new ObjectMapper();
    private Sinks.Many<String> realTimeDataMany = Sinks.many().multicast().onBackpressureBuffer();


    public KafkaController(KafkaService kafkaService, SensorDataRep sensorDataRep, EarthquakeDataRep earthQuakeDataRep, FirebaseMessaging firebaseMessaging) {
        this.kafkaService = kafkaService;
        this.sensorDataRep = sensorDataRep;
        this.earthQuakeDataRep = earthQuakeDataRep;
        this.firebaseMessaging = firebaseMessaging;
    }

    private String EQMSLineAPI(Long data){
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

    public String EQMSFCMTopic(Long data) throws FirebaseMessagingException {
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
        Earthquake earthquake = mapper.readValue(kafkaData, Earthquake.class);

        Timestamp ts = new Timestamp(System.currentTimeMillis());
        earthquake.setUpdate_time(ts);
        earthQuakeDataRep.save(earthquake);
        String LineAnswer = EQMSLineAPI(earthquake.getAssoc_id());
        String FCMAnswer = EQMSFCMTopic(earthquake.getAssoc_id());
        System.out.println(LineAnswer + " " + FCMAnswer);

    }
    public void sendData(String data) {
        Sinks.EmitResult result = this.realTimeDataMany.tryEmitNext(data);
//        if (result.isFailure()){
//            result.orThrow();
//        }
    }

    @PostMapping("/publish")
    public ResponseEntity<String> publish(@RequestBody Earthquake earthquake){
        kafkaService.sendMessage(earthquake);
        return ResponseEntity.ok("Message sent to kafka topic");
    }

    @GetMapping(value = "/server-events", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public Flux<String> SendDataToClient() throws IOException {
        return this.realTimeDataMany.asFlux();
    }

//    @KafkaListener(topics = "topic1", groupId = "test")
//    void StringDeserializeListener(ConsumerRecord<String, String> record) throws IOException, FirebaseMessagingException {
//        kafkaMessageProcess(record.value());
//    }

    @KafkaListener(topics = "topic1", groupId = "test")
    void JsonDeserializeListener(Earthquake data) throws IOException, FirebaseMessagingException {
        System.out.println(data.toString());

//        Earthquake earthquake = new Earthquake();
//        earthquake.setLat(data.getLat());
//        earthquake.setLng(data.getLng());
//        earthquake.setAlert_created_msec(data.getAlert_created_msec());


        Timestamp ts = new Timestamp(System.currentTimeMillis());
        data.setUpdate_time(ts);

        earthQuakeDataRep.save(data);
        String LineAnswer = EQMSLineAPI(data.getAssoc_id());
        String FCMAnswer = EQMSFCMTopic(data.getAssoc_id());
        System.out.println(LineAnswer + " " + FCMAnswer);

    }

}

