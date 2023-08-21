package com.junge.api.controller.server;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.junge.api.Model.server.Earthquake;
import com.junge.api.Service.DataService;
import org.json.simple.parser.JSONParser;
import org.json.simple.JSONObject;
import com.junge.api.Model.server.FCMNotification;
import com.junge.api.Repository.server.EarthquakeDataRep;
import com.junge.api.Repository.server.SensorDataRep;
import com.junge.api.Service.KafkaService;
import com.linecorp.bot.client.LineMessagingClient;
import com.linecorp.bot.model.Broadcast;
import com.linecorp.bot.model.PushMessage;
import com.linecorp.bot.model.message.TextMessage;
import com.linecorp.bot.model.response.BotApiResponse;
import org.apache.kafka.clients.consumer.ConsumerRecord;
import org.json.simple.parser.ParseException;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Sinks;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping()
public class KafkaController {
    private KafkaService kafkaService;
    private DataService dataService;
    private final SensorDataRep sensorDataRep;
    private final EarthquakeDataRep earthQuakeDataRep;
    private final FirebaseMessaging firebaseMessaging;
    private final ObjectMapper mapper = new ObjectMapper();
    private Sinks.Many<String> realTimeDataMany = Sinks.many().multicast().onBackpressureBuffer();


    public KafkaController(KafkaService kafkaService, DataService dataService, SensorDataRep sensorDataRep, EarthquakeDataRep earthQuakeDataRep, FirebaseMessaging firebaseMessaging) {
        this.kafkaService = kafkaService;
        this.dataService = dataService;
        this.sensorDataRep = sensorDataRep;
        this.earthQuakeDataRep = earthQuakeDataRep;
        this.firebaseMessaging = firebaseMessaging;
    }

    private String EQMSLineAPI(Object lat, Object lng){
        final LineMessagingClient client = LineMessagingClient
                .builder("o7WhaO9vMoAzhP7h1WDuxjZNek79QoblCkNLndDcDuLoDlAyBEYJb4crTDVV8cdTFAH3bnzBdhmbgFN+KP1OajTnWrkaCGzmj1h6g8OoTLoF1lN2jz7o+QO4Yo8zc21oYOQzzN53tJRPXlbLHyVsVwdB04t89/1O/w1cDnyilFU=")
                .build();

        final TextMessage textMessage = new TextMessage("지진이 일어났습니다.\n위치: " + lat + "," + lng + "\n신속히 대피해주세요.");
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

    private String EQMSLineAPIBroadCast(double lat, double lng) {
        final LineMessagingClient client = LineMessagingClient
                .builder("o7WhaO9vMoAzhP7h1WDuxjZNek79QoblCkNLndDcDuLoDlAyBEYJb4crTDVV8cdTFAH3bnzBdhmbgFN+KP1OajTnWrkaCGzmj1h6g8OoTLoF1lN2jz7o+QO4Yo8zc21oYOQzzN53tJRPXlbLHyVsVwdB04t89/1O/w1cDnyilFU=")
                .build();

        final TextMessage textMessage = new TextMessage("지진이 일어났습니다.\n위치: " + lat + "," + lng + "\n신속히 대피해주세요.");
        final Broadcast broadcast = new Broadcast(textMessage);
        final BotApiResponse botApiResponse;
        try {
            botApiResponse = client.broadcast(broadcast).get(); // pushMessage(pushMessage).get();
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
            return "Line 전송 실패";
        }
        return botApiResponse.toString();
    }

    public String EQMSFCMTopic(double lat, double lng) {
        FCMNotification fcmNotification = new FCMNotification();

        fcmNotification.setTitile("지진 알림");
        fcmNotification.setBody("지진이 발생했습니다. 위치: " + lat + "," + lng + "\n신속히 대피해주세요.");

        Notification notification = Notification
                .builder()
                .setTitle(fcmNotification.getTitile())
                .setBody(fcmNotification.getBody())
                .build();

        Message message = Message
                .builder()
                .setTopic("EQMS-1")
                .setNotification(notification)
                .putData("route", "/eqoccur")
                .build();

        try {
            firebaseMessaging.send(message);
            return "FCM 알림을 성공적으로 전송했습니다.";
        } catch (FirebaseMessagingException e){
            e.printStackTrace();
            return "FCM 알림 전송에 실패했습니다.";
        }
    }

    public void sendData(String data) {
        Sinks.EmitResult result = this.realTimeDataMany.tryEmitNext(data);
//        if (result.isFailure()){
//            result.orThrow();
//        }
    }

    @PostMapping("/publish")
    public ResponseEntity<String> publish(@RequestBody JSONObject earthquake){
        kafkaService.sendMessage(earthquake);
        return ResponseEntity.ok("Message sent to kafka topic");
    }

    @GetMapping(value = "/server-events", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public Flux<String> SendDataToClient() throws IOException {
        return this.realTimeDataMany.asFlux();
    }

    void saveEarthquake(JSONObject jsonObject){
        Timestamp ts = new Timestamp(System.currentTimeMillis());
        double lat = (double) jsonObject.get("lat");
        double lng = (double) jsonObject.get("lng");
        Long event_occurred_msecValue = (Long) jsonObject.get("event_occurred_msec");
        Timestamp event_occurred_msec = new Timestamp(event_occurred_msecValue);
        Long alert_created_msecValue = (Long) jsonObject.get("alert_created_msec");
        Timestamp alert_created_msec = new Timestamp(alert_created_msecValue);
        List<String> associated_sensors = (List<String>) jsonObject.get("associated_sensors");
        String stage = (String) jsonObject.get("stage");
        Long assoc_id = (Long) jsonObject.get("assoc_id");

        Earthquake earthquake = new Earthquake(ts, lat, lng, event_occurred_msec, alert_created_msec, associated_sensors, stage, assoc_id);
        this.earthQuakeDataRep.save(earthquake);

        dataService.cacheputEarthquake();
        dataService.cacheputEarthquakeOngoign();
    }

    @KafkaListener(topics = "cr-assoc-results-integration-test", groupId = "cr-alert-mobile")
    void StringDeserializeListener(ConsumerRecord<String, String> record) throws ParseException {
        JSONParser parser = new JSONParser();
        JSONObject jsonObject = (JSONObject) parser.parse(record.value());

        double lat = (double) jsonObject.get("lat");
        double lng = (double) jsonObject.get("lng");

        saveEarthquake(jsonObject);

        String LineAnswer = EQMSLineAPIBroadCast(lat, lng);
        String FCMAnswer = EQMSFCMTopic(lat, lng);
        System.out.println("Record: " + record);
        System.out.println("Firebase" + FCMAnswer);
        System.out.println("LineAnswer" + LineAnswer);
    }


}

