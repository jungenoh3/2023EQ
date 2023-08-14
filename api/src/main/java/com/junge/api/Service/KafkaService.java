package com.junge.api.Service;

import com.junge.api.Model.server.EarthquakeRaw;
import org.springframework.kafka.support.KafkaHeaders;
import org.springframework.kafka.support.serializer.ErrorHandlingDeserializer;
import org.springframework.messaging.Message;
import com.junge.api.Model.server.Earthquake;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.messaging.support.MessageBuilder;
import org.springframework.stereotype.Service;

@Service
public class KafkaService extends ErrorHandlingDeserializer<Earthquake> {
    @Autowired
    private KafkaTemplate<String, Earthquake> kafkaTemplate;

    public void sendMessage(Earthquake earthquake){
        System.out.println(String.format("Message sent -> %s", earthquake.toString()));

        Message<Earthquake> message = MessageBuilder
                .withPayload(earthquake)
                .setHeader(KafkaHeaders.TOPIC, "topic1")
                .build();

        kafkaTemplate.send(message);
    }
}
