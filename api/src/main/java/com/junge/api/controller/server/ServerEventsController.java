//package com.junge.api.controller.server;
//
//import com.junge.api.Model.server.RealTimeData;
//import org.apache.kafka.clients.consumer.ConsumerRecord;
//import org.springframework.http.MediaType;
//import org.springframework.kafka.annotation.KafkaListener;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RestController;
//import reactor.core.publisher.Flux;
//import reactor.core.publisher.Sinks;
//
//import java.io.IOException;
//
//@RestController
//@RequestMapping("/server-events")
//public class ServerEventsController {
//
//    private Sinks.Many<String> realTimeDataMany = Sinks.many().multicast().onBackpressureBuffer();
//
//    public void sendData(String data) {
//        this.realTimeDataMany.tryEmitNext(data);
//    }
//
//    @GetMapping(produces = MediaType.TEXT_EVENT_STREAM_VALUE)
//    public Flux<String> KafkaDataProcess() throws IOException {
//        return this.realTimeDataMany.asFlux();
//    }
//
//    @KafkaListener(topics = "topic1", groupId = "test")
//    void listener(ConsumerRecord<String, String> record) throws IOException {
//        sendData(record.value());
//    }
//
//
//}
