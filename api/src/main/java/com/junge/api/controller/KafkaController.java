package com.junge.api.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.junge.api.model.earthquake.Earthquake;
import com.junge.api.service.DataService;
import org.json.simple.parser.JSONParser;
import org.json.simple.JSONObject;
import com.junge.api.model.FCMNotification;
import com.junge.api.repository.EarthquakeDataRep;
import com.junge.api.repository.SensorDataRep;
import com.junge.api.service.KafkaService;
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
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
    private Sinks.Many<Map<Object, Object>> realTimeDataMany = Sinks.many().multicast().onBackpressureBuffer(1000, false);


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

    @PostMapping("/publish")
    public ResponseEntity<String> publish(@RequestBody JSONObject earthquake){
        kafkaService.sendMessage(earthquake);
        return ResponseEntity.ok("Message sent to kafka topic");
    }

    public void sendData(Map<Object, Object> data) {
        Sinks.EmitResult result = this.realTimeDataMany.tryEmitNext(data);
        if (result.isFailure()){
            switch (result) {
                case FAIL_OVERFLOW:
                    System.out.println(result);
                    break;
                case FAIL_CANCELLED:
                    System.out.println(result);
                    break;
                case FAIL_TERMINATED:
                    System.out.println(result);
                    break;
                case FAIL_NON_SERIALIZED:
                    System.out.println(result);
                    break;
                case FAIL_ZERO_SUBSCRIBER:
                    break;
                default:
                    break;
            }
        }
    }

    @GetMapping(value = "/server-events", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public Flux<Map<Object, Object>> SendDataToClient(@RequestParam(required = false) String sensorId) throws IOException {

        Flux<Map<Object, Object>> dataStream = this.realTimeDataMany.asFlux();

        if (sensorId != null ) {
            dataStream = dataStream.filter(data -> {
                Object dataSensorId = data.get("sensorId");
                return dataSensorId != null && dataSensorId.equals(Integer.parseInt(sensorId)); // 추후에 데이터가 없는 오류 처리하기
            });
        }

        return dataStream;

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

    @KafkaListener(topics = "cr-assoc-results-integration-test", containerFactory = "stringKafkaListenerContainerFactory")
    void EarthquakeListener(ConsumerRecord<String, String> record) throws ParseException {
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

    @KafkaListener(topics = "cr-raw-acc-packet", containerFactory = "byteArrayKafkaListenerContainerFactory")
    void AccelerationListener(ConsumerRecord<byte[], byte[]> record) throws ParseException {
        JSONObject obj = new JSONObject();
        byte[] key = record.key();
        ByteBuffer wrapped = ByteBuffer.wrap(key);
        wrapped.order(ByteOrder.LITTLE_ENDIAN);
        int sensorId = wrapped.getInt();
        Map<Object, Object> map = new HashMap<>();

        byte[] bytes = record.value();
        ByteBuffer buffer = ByteBuffer.wrap(bytes);
        buffer.order(ByteOrder.LITTLE_ENDIAN);


        byte[] chunk = new byte[Math.min(7, buffer.remaining())];
        buffer.get(chunk);
        ByteBuffer chunkBuffer = ByteBuffer.wrap(chunk);
        chunkBuffer.order(ByteOrder.LITTLE_ENDIAN);

        int idx = chunkBuffer.get() & 0xFF;
        Integer x = chunkBuffer.getShort() & 0xFFFF;
        Integer y = chunkBuffer.getShort() & 0xFFFF;
        Integer z = chunkBuffer.getShort() & 0xFFFF;

        map.put("sensorId", sensorId);
        // map.put("idx", idx); // 첫번째 인덱스만 받는다.
        map.put("x", x);
        map.put("y", y);
        map.put("z", z);

        // System.out.println(map);
        sendData(map);

    }
}

