package com.junge.api.service;

import com.junge.api.model.earthquake.EarthquakeRaw;
import org.json.simple.JSONObject;
import org.springframework.kafka.support.KafkaHeaders;
import org.springframework.kafka.support.serializer.ErrorHandlingDeserializer;
import org.springframework.messaging.Message;
import com.junge.api.model.earthquake.Earthquake;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.messaging.support.MessageBuilder;
import org.springframework.stereotype.Service;

@Service
public class KafkaService extends ErrorHandlingDeserializer<Earthquake> {
    @Autowired
    private KafkaTemplate<String, EarthquakeRaw> kafkaTemplate;

    public void sendMessage(JSONObject earthquake){
        System.out.println(String.format("Message sent -> %s", earthquake.toString()));

        Message<JSONObject> message = MessageBuilder
                .withPayload(earthquake)
                .setHeader(KafkaHeaders.TOPIC, "cr-assoc-results-integration-test")
                .build();

        kafkaTemplate.send(message);
    }
}
